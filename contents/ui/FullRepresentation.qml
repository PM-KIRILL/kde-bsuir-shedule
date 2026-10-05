import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import "ScheduleLogic.js" as Logic

Item {
    id: root

    property var scheduleData: null
    property int currentWeek: 1
    property string groupNumber: ""
    property int subgroup: 0
    property bool showPastLessons: false
    property bool isLoading: false
    property string errorMessage: ""
    property var pal: ({})
    property var timerDate: null

    signal refreshRequested()

    Layout.minimumWidth: Math.max(280, Kirigami.Units.gridUnit * 16)
    Layout.minimumHeight: Math.max(180, Kirigami.Units.gridUnit * 11)
    Layout.preferredWidth: Math.max(340, Kirigami.Units.gridUnit * 20)
    Layout.preferredHeight: Math.max(300, Kirigami.Units.gridUnit * 17)

    implicitWidth: Layout.preferredWidth
    implicitHeight: Layout.preferredHeight

    // Resolved display calculation (timerDate causes re-evaluation every minute)
    property var displayInfo: {
        var _tick = root.timerDate;
        return Logic.resolveDisplay(
            root.scheduleData,
            root.currentWeek,
            root.subgroup,
            root.showPastLessons
        );
    }

    // Outer card container with 20px radius matching Android widget
    Rectangle {
        id: card
        anchors.fill: parent
        anchors.margins: 4
        radius: 20
        clip: true
        color: root.pal.cardBg || "#1C1C1E"
        border.width: 1
        border.color: root.pal.border || "#38383A"

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 8

            // ─── Header ──────────────────────────────────────────
            RowLayout {
                id: headerRow
                Layout.fillWidth: true
                spacing: 8

                // Left: Group name and Date label
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 8

                    Text {
                        text: root.displayInfo.groupName || root.groupNumber || i18n("Расписание")
                        font.pixelSize: 13
                        font.weight: Font.DemiBold
                        color: root.pal.textPrimary || "#FFFFFF"
                        elide: Text.ElideRight
                    }

                    Text {
                        visible: root.displayInfo.dateLabel !== ""
                        text: root.displayInfo.dateLabel
                        font.pixelSize: 11
                        font.weight: Font.Medium
                        color: root.displayInfo.dateColor || Logic.COLOR_BLUE
                        elide: Text.ElideRight
                    }
                }

                // Right: Week label and Refresh button
                RowLayout {
                    spacing: 6

                    Text {
                        text: i18n("Неделя %1", root.displayInfo.currentWeek || root.currentWeek || 1)
                        font.pixelSize: 11
                        color: root.pal.textSecondary || "#98989F"
                    }

                    // Circular Refresh Button
                    Rectangle {
                        width: 28
                        height: 28
                        radius: 14
                        color: refreshMouseArea.containsMouse ? (root.pal.avatarBg || "#3A3A3C") : "transparent"

                        Text {
                            id: refreshIcon
                            anchors.centerIn: parent
                            text: "↻"
                            font.pixelSize: 17
                            font.bold: true
                            color: Logic.COLOR_BLUE

                            RotationAnimation on rotation {
                                running: root.isLoading
                                from: 0
                                to: 360
                                loops: Animation.Infinite
                                duration: 800
                            }
                        }

                        QQC2.ToolTip.visible: refreshMouseArea.containsMouse
                        QQC2.ToolTip.text: i18n("Обновить расписание")
                        QQC2.ToolTip.delay: 300

                        MouseArea {
                            id: refreshMouseArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.refreshRequested()
                        }
                    }
                }
            }

            // ─── Content ──────────────────────────────────────────
            Item {
                Layout.fillWidth: true
                Layout.fillHeight: true

                // State 1: Loading (no data yet)
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 10
                    visible: root.isLoading && (!root.scheduleData || !root.displayInfo.hasData)

                    QQC2.BusyIndicator {
                        Layout.alignment: Qt.AlignHCenter
                        running: true
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: i18n("Загрузка расписания...")
                        font.pixelSize: 12
                        color: root.pal.textSecondary || "#98989F"
                    }
                }

                // State 2: Error (no data)
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8
                    width: Math.min(parent.width - 20, 260)
                    visible: !root.isLoading && root.errorMessage !== "" && (!root.scheduleData || !root.displayInfo.hasData)

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: "⚠️"
                        font.pixelSize: 26
                    }

                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        Layout.fillWidth: true
                        text: root.errorMessage
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        font.pixelSize: 12
                        color: root.pal.textPrimary || "#FFFFFF"
                    }

                    QQC2.Button {
                        Layout.alignment: Qt.AlignHCenter
                        text: i18n("Повторить")
                        onClicked: root.refreshRequested()
                    }
                }

                // State 3: Holiday / Empty State
                EmptyState {
                    anchors.fill: parent
                    visible: !root.isLoading && (!root.errorMessage || root.displayInfo.hasData) && (root.displayInfo.holidayName || (root.displayInfo.lessons && root.displayInfo.lessons.length === 0))
                    pal: root.pal
                    allDone: root.displayInfo.allDone
                    holidayName: root.displayInfo.holidayName || ""
                    dateLabel: root.displayInfo.dateLabel || ""
                }

                // State 4: Lessons List
                ListView {
                    id: lessonsList
                    anchors.fill: parent
                    clip: true
                    visible: root.displayInfo.lessons && root.displayInfo.lessons.length > 0
                    model: root.displayInfo.lessons || []
                    spacing: 0

                    delegate: ColumnLayout {
                        width: lessonsList.width
                        spacing: 0

                        // Separator between lessons (0.5px)
                        Rectangle {
                            visible: index > 0
                            Layout.fillWidth: true
                            Layout.preferredHeight: 1
                            Layout.topMargin: 2
                            Layout.bottomMargin: 2
                            color: root.pal.separator || "#38383A"
                        }

                        LessonRow {
                            Layout.fillWidth: true
                            lesson: modelData
                            pal: root.pal
                            compact: root.width < 320
                            showNote: root.height >= 260
                            showPhoto: root.width >= 300
                        }
                    }

                    QQC2.ScrollBar.vertical: QQC2.ScrollBar {
                        active: lessonsList.moving || lessonsList.flicking
                    }
                }
            }
        }
    }
}
