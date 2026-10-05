import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import "ScheduleLogic.js" as Logic

PlasmoidItem {
    id: root

    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
    preferredRepresentation: Plasmoid.formFactor === PlasmaCore.Types.Planar ? fullRepresentation : null

    // Layout size constraints (enforces minimum dimensions on desktop to avoid squishing content)
    Layout.minimumWidth: Plasmoid.formFactor === PlasmaCore.Types.Planar ? Math.max(280, Kirigami.Units.gridUnit * 16) : -1
    Layout.minimumHeight: Plasmoid.formFactor === PlasmaCore.Types.Planar ? Math.max(180, Kirigami.Units.gridUnit * 11) : -1
    Layout.preferredWidth: Plasmoid.formFactor === PlasmaCore.Types.Planar ? Math.max(340, Kirigami.Units.gridUnit * 20) : -1
    Layout.preferredHeight: Plasmoid.formFactor === PlasmaCore.Types.Planar ? Math.max(300, Kirigami.Units.gridUnit * 17) : -1

    // Declarative Configuration Bindings
    readonly property string cfgGroupNumber: (Plasmoid.configuration.groupNumber && Plasmoid.configuration.groupNumber.trim() !== "")
        ? Plasmoid.configuration.groupNumber.trim()
        : "310101"
    readonly property int cfgSubgroup: Plasmoid.configuration.subgroup || 0
    readonly property string cfgLanguage: Plasmoid.configuration.language || "auto"
    readonly property string lang: Logic.getLanguage(root.cfgLanguage, Qt.locale ? Qt.locale().name : "ru")

    readonly property int cfgThemeMode: Plasmoid.configuration.themeMode || 0
    readonly property string cfgIconChoice: Plasmoid.configuration.iconChoice || "bsuir"
    readonly property bool cfgShowAvatars: Plasmoid.configuration.showAvatars !== undefined ? Plasmoid.configuration.showAvatars : true
    readonly property bool cfgShowTypeBadge: Plasmoid.configuration.showTypeBadge !== undefined ? Plasmoid.configuration.showTypeBadge : true
    readonly property bool cfgShowNotes: Plasmoid.configuration.showNotes !== undefined ? Plasmoid.configuration.showNotes : true

    readonly property var colorOverrides: {
        return {
            colorLK: Plasmoid.configuration.colorLK ? Plasmoid.configuration.colorLK.toString() : "#3FB36F",
            colorLR: Plasmoid.configuration.colorLR ? Plasmoid.configuration.colorLR.toString() : "#F08A24",
            colorPZ: Plasmoid.configuration.colorPZ ? Plasmoid.configuration.colorPZ.toString() : "#8E5CD9",
            colorExam: Plasmoid.configuration.colorExam ? Plasmoid.configuration.colorExam.toString() : "#FF3B30",
            colorConsultation: Plasmoid.configuration.colorConsultation ? Plasmoid.configuration.colorConsultation.toString() : "#32ADE6"
        };
    }

    readonly property int cfgAutoRefreshInterval: (Plasmoid.configuration.autoRefreshInterval !== undefined)
        ? Plasmoid.configuration.autoRefreshInterval
        : 60
    readonly property bool cfgShowPastLessons: !!Plasmoid.configuration.showPastLessons

    property bool isReady: false

    onCfgGroupNumberChanged: if (root.isReady) root.refresh()
    onCfgSubgroupChanged: root.currentTimerDate = new Date()
    onCfgAutoRefreshIntervalChanged: autoRefreshTimer.restart()

    // Tooltip
    toolTipMainText: Logic.tr("scheduleTitle", root.lang) + " (" + root.cfgGroupNumber + ")"
    toolTipSubText: {
        if (!root.scheduleData) return Logic.tr("loading", root.lang);
        var disp = Logic.resolveDisplay(
            root.scheduleData,
            root.currentWeek,
            root.cfgSubgroup,
            root.cfgShowPastLessons,
            root.colorOverrides,
            root.lang
        );
        if (disp.holidayName) return "⭐ " + disp.holidayName;
        if (disp.lessons && disp.lessons.length > 0) {
            var l = disp.lessons[0];
            return l.startTime + " " + l.subject + (l.auditoryText || "");
        }
        return disp.allDone ? Logic.tr("allDone", root.lang) : Logic.tr("noClasses", root.lang);
    }

    // Theme palette
    readonly property bool isSystemDark: Kirigami.Theme.backgroundColor.hslLightness < 0.5
    property var pal: Logic.getPalette(root.cfgThemeMode, isSystemDark)

    // State
    property var scheduleData: null
    property int currentWeek: 1
    property bool isLoading: false
    property string errorMessage: ""
    property var currentTimerDate: new Date()

    // Context actions
    Plasmoid.contextualActions: [
        PlasmaCore.Action {
            text: Logic.tr("refresh", root.lang)
            icon.name: "view-refresh"
            onTriggered: root.refresh()
        }
    ]

    // Minute timer: keeps display state up-to-date in real time (e.g. lesson ends, day rolls over)
    Timer {
        id: minuteTimer
        interval: 60000
        running: true
        repeat: true
        onTriggered: {
            root.currentTimerDate = new Date();
        }
    }

    // Auto-refresh timer (fetches new data from API periodically)
    Timer {
        id: autoRefreshTimer
        interval: Math.max(1, root.cfgAutoRefreshInterval) * 60 * 1000
        running: root.cfgAutoRefreshInterval > 0
        repeat: true
        onTriggered: root.refresh()
    }

    // ─── Network Functions ────────────────────────────────────────
    function fetchCurrentWeek(callback, errorCallback) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", "https://iis.bsuir.by/api/v1/schedule/current-week", true);
        xhr.setRequestHeader("Accept", "application/json");
        xhr.timeout = 10000;
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status >= 200 && xhr.status < 300) {
                    var week = parseInt(xhr.responseText.trim(), 10);
                    if (!isNaN(week) && week >= 1 && week <= 4) {
                        callback(week);
                        return;
                    }
                }
                if (errorCallback) errorCallback(Logic.tr("errorServer", root.lang, xhr.status));
            }
        };
        xhr.ontimeout = function() {
            if (errorCallback) errorCallback(Logic.tr("errorTimeout", root.lang));
        };
        xhr.onerror = function() {
            if (errorCallback) errorCallback(Logic.tr("errorNetwork", root.lang));
        };
        xhr.send();
    }

    function fetchSchedule(groupNumber, callback, errorCallback) {
        if (!groupNumber || groupNumber.trim() === "") {
            if (errorCallback) errorCallback(Logic.tr("errorEmptyGroup", root.lang));
            return;
        }

        var url = "https://iis.bsuir.by/api/v1/schedule?studentGroup=" + encodeURIComponent(groupNumber.trim());
        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);
        xhr.setRequestHeader("Accept", "application/json");
        xhr.timeout = 15000;
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                if (xhr.status >= 200 && xhr.status < 300) {
                    try {
                        var data = JSON.parse(xhr.responseText);
                        callback(data);
                    } catch (e) {
                        if (errorCallback) errorCallback("JSON parse error");
                    }
                    return;
                }
                if (xhr.status === 404) {
                    if (errorCallback) errorCallback(Logic.tr("errorNotFound", root.lang, groupNumber));
                    return;
                }
                if (errorCallback) errorCallback(Logic.tr("errorServer", root.lang, xhr.status));
            }
        };
        xhr.ontimeout = function() {
            if (errorCallback) errorCallback(Logic.tr("errorTimeout", root.lang));
        };
        xhr.onerror = function() {
            if (errorCallback) errorCallback(Logic.tr("errorNetwork", root.lang));
        };
        xhr.send();
    }

    function refresh() {
        var group = root.cfgGroupNumber;
        root.isLoading = true;
        root.errorMessage = "";

        fetchCurrentWeek(function(week) {
            root.currentWeek = week;
            try { Plasmoid.configuration.cachedCurrentWeek = week; } catch(e) {}

            fetchSchedule(group, function(data) {
                root.scheduleData = data;
                root.isLoading = false;
                root.errorMessage = "";
                root.currentTimerDate = new Date();

                // Save cache to Plasmoid configuration
                try {
                    Plasmoid.configuration.cachedScheduleJson = JSON.stringify(data);
                } catch (e) {
                    console.warn("Could not cache schedule JSON:", e);
                }
            }, function(schedErr) {
                root.isLoading = false;
                root.errorMessage = schedErr;
            });
        }, function(weekErr) {
            fetchSchedule(group, function(data) {
                root.scheduleData = data;
                root.isLoading = false;
                root.errorMessage = "";
                root.currentTimerDate = new Date();
            }, function(schedErr) {
                root.isLoading = false;
                root.errorMessage = schedErr || weekErr;
            });
        });
    }

    // Initialize data from cache and start fetch
    Component.onCompleted: {
        try {
            if (Plasmoid.configuration.cachedCurrentWeek > 0) {
                root.currentWeek = Plasmoid.configuration.cachedCurrentWeek;
            }
            if (Plasmoid.configuration.cachedScheduleJson && Plasmoid.configuration.cachedScheduleJson !== "") {
                root.scheduleData = JSON.parse(Plasmoid.configuration.cachedScheduleJson);
            }
        } catch (e) {
            console.warn("Failed to load cached schedule:", e);
        }

        // Fetch fresh data
        root.refresh();
        root.isReady = true;
    }

    // Representations
    compactRepresentation: CompactRepresentation {
        scheduleData: root.scheduleData
        currentWeek: root.currentWeek
        groupNumber: root.cfgGroupNumber
        subgroup: root.cfgSubgroup
        showPastLessons: root.cfgShowPastLessons
        timerDate: root.currentTimerDate
        colorOverrides: root.colorOverrides
        lang: root.lang
        iconChoice: root.cfgIconChoice
        pal: root.pal
    }

    fullRepresentation: FullRepresentation {
        scheduleData: root.scheduleData
        currentWeek: root.currentWeek
        groupNumber: root.cfgGroupNumber
        subgroup: root.cfgSubgroup
        showPastLessons: root.cfgShowPastLessons
        timerDate: root.currentTimerDate
        colorOverrides: root.colorOverrides
        lang: root.lang
        showAvatars: root.cfgShowAvatars
        showTypeBadge: root.cfgShowTypeBadge
        showNotes: root.cfgShowNotes
        isLoading: root.isLoading
        errorMessage: root.errorMessage
        pal: root.pal
        onRefreshRequested: root.refresh()
    }
}
