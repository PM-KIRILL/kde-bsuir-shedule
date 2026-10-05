import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import QtQuick.Dialogs as Dialogs
import org.kde.kcmutils as KCM
import org.kde.kirigami as Kirigami
import "../ScheduleLogic.js" as Logic
import "../" as UI

KCM.SimpleKCM {
    id: configAppearance

    property alias cfg_themeMode: themeCombo.currentIndex
    property string cfg_iconChoice: iconCombo.model[iconCombo.currentIndex].value
    property alias cfg_showAvatars: showAvatarsCheck.checked
    property alias cfg_showTypeBadge: showTypeBadgeCheck.checked
    property alias cfg_showNotes: showNotesCheck.checked

    property color cfg_colorLK: lkColorRect.selectedColor
    property color cfg_colorLR: lrColorRect.selectedColor
    property color cfg_colorPZ: pzColorRect.selectedColor
    property color cfg_colorExam: examColorRect.selectedColor
    property color cfg_colorConsultation: consultationColorRect.selectedColor

    // Active color overrides dictionary for preview and bindings
    readonly property var activeColorOverrides: {
        return {
            colorLK: cfg_colorLK.toString(),
            colorLR: cfg_colorLR.toString(),
            colorPZ: cfg_colorPZ.toString(),
            colorExam: cfg_colorExam.toString(),
            colorConsultation: cfg_colorConsultation.toString()
        };
    }

    // Active palette for preview
    readonly property bool isSysDark: Kirigami.Theme.backgroundColor.hslLightness < 0.5
    readonly property var previewPal: Logic.getPalette(cfg_themeMode, isSysDark)
    readonly property string previewLang: Logic.getLanguage(Plasmoid.configuration.language, Qt.locale ? Qt.locale().name : "ru")

    Dialogs.ColorDialog {
        id: colorPicker
        property var targetRect: null
        title: i18n("Выберите цвет занятия")
        onAccepted: {
            if (targetRect) {
                targetRect.selectedColor = selectedColor;
            }
        }
    }

    ColumnLayout {
        spacing: Kirigami.Units.largeSpacing
        Layout.fillWidth: true

        // ─── 1. Live Preview Section ─────────────────────────────
        Kirigami.Heading {
            text: i18n("Предпросмотр")
            level: 3
        }

        Rectangle {
            id: previewBox
            Layout.fillWidth: true
            Layout.preferredHeight: previewCard.implicitHeight + 24
            Layout.maximumWidth: 420
            Layout.alignment: Qt.AlignHCenter
            radius: 12
            color: Kirigami.Theme.alternateBackgroundColor
            border.width: 1
            border.color: Kirigami.Theme.separatorColor

            // Embedded live card
            Rectangle {
                id: previewCard
                anchors.centerIn: parent
                width: Math.min(parent.width - 24, 350)
                implicitHeight: 260
                radius: 20
                clip: true
                color: configAppearance.previewPal.cardBg || "#1C1C1E"
                border.width: 1
                border.color: configAppearance.previewPal.border || "#38383A"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 8

                    // Header
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 8

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 8

                            Text {
                                text: Plasmoid.configuration.groupNumber || "310101"
                                font.pixelSize: 13
                                font.weight: Font.DemiBold
                                color: configAppearance.previewPal.textPrimary || "#FFFFFF"
                            }

                            Text {
                                text: Logic.formatDayLabel(new Date(), configAppearance.previewLang)
                                font.pixelSize: 11
                                font.weight: Font.Medium
                                color: Logic.COLOR_BLUE
                            }
                        }

                        RowLayout {
                            spacing: 6

                            Text {
                                text: Logic.tr("weekLabel", configAppearance.previewLang) + " 2"
                                font.pixelSize: 11
                                color: configAppearance.previewPal.textSecondary || "#98989F"
                            }

                            Rectangle {
                                width: 24
                                height: 24
                                radius: 12
                                color: "transparent"

                                Text {
                                    anchors.centerIn: parent
                                    text: "↻"
                                    font.pixelSize: 15
                                    font.bold: true
                                    color: Logic.COLOR_BLUE
                                }
                            }
                        }
                    }

                    // Separator
                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: configAppearance.previewPal.separator || "#38383A"
                    }

                    // Mock Lesson List
                    ListView {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        interactive: false
                        clip: true
                        spacing: 0
                        model: Logic.getMockLessons(configAppearance.activeColorOverrides, configAppearance.previewLang)

                        delegate: ColumnLayout {
                            width: parent.width
                            spacing: 0

                            Rectangle {
                                visible: index > 0
                                Layout.fillWidth: true
                                height: 1
                                Layout.topMargin: 2
                                Layout.bottomMargin: 2
                                color: configAppearance.previewPal.separator || "#38383A"
                            }

                            UI.LessonRow {
                                Layout.fillWidth: true
                                lesson: modelData
                                pal: configAppearance.previewPal
                                compact: false
                                showNote: configAppearance.cfg_showNotes
                                showPhoto: configAppearance.cfg_showAvatars
                            }
                        }
                    }
                }
            }
        }

        // ─── 2. General Appearance & Icons ───────────────────────
        Kirigami.Heading {
            text: i18n("Внешний вид и иконка")
            level: 3
        }

        Kirigami.FormLayout {
            Layout.fillWidth: true

            QQC2.ComboBox {
                id: themeCombo
                Kirigami.FormData.label: i18n("Тема оформления:")
                model: [
                    i18n("Как в системе (Plasma)"),
                    i18n("Тёмная (Dark)"),
                    i18n("Светлая (Light)")
                ]
                Layout.fillWidth: true
                Component.onCompleted: {
                    currentIndex = Plasmoid.configuration.themeMode || 0;
                }
            }

            QQC2.ComboBox {
                id: iconCombo
                Kirigami.FormData.label: i18n("Иконка в панели:")
                textRole: "text"
                model: [
                    { text: i18n("Bsuir Time (по умолчанию)"), value: "bsuir", icon: Qt.resolvedUrl("../../icons/icon.png") },
                    { text: i18n("Системный календарь"), value: "view-calendar-timeline", icon: "view-calendar-timeline" },
                    { text: i18n("Обучение / Диплом"), value: "school", icon: "school" },
                    { text: i18n("Блокнот / Расписание"), value: "document-edit", icon: "document-edit" },
                    { text: i18n("Часы"), value: "preferences-system-time", icon: "preferences-system-time" }
                ]
                Layout.fillWidth: true
                Component.onCompleted: {
                    var cur = Plasmoid.configuration.iconChoice || "bsuir";
                    for (var i = 0; i < model.length; ++i) {
                        if (model[i].value === cur) {
                            currentIndex = i;
                            break;
                        }
                    }
                }
            }

            QQC2.CheckBox {
                id: showAvatarsCheck
                Kirigami.FormData.label: i18n("Элементы списка:")
                text: i18n("Показывать аватары преподавателей")
                checked: Plasmoid.configuration.showAvatars !== undefined ? Plasmoid.configuration.showAvatars : true
            }

            QQC2.CheckBox {
                id: showTypeBadgeCheck
                text: i18n("Показывать метку типа пары (ЛК, ЛР, ПЗ)")
                checked: Plasmoid.configuration.showTypeBadge !== undefined ? Plasmoid.configuration.showTypeBadge : true
            }

            QQC2.CheckBox {
                id: showNotesCheck
                text: i18n("Показывать заметки к занятиям")
                checked: Plasmoid.configuration.showNotes !== undefined ? Plasmoid.configuration.showNotes : true
            }
        }

        // ─── 3. Lesson Colors ────────────────────────────────────
        Kirigami.Heading {
            text: i18n("Цвета типов занятий")
            level: 3
        }

        Kirigami.FormLayout {
            Layout.fillWidth: true

            // Color Row: ЛК
            RowLayout {
                Kirigami.FormData.label: i18n("Лекция (ЛК):")
                spacing: 10

                Rectangle {
                    id: lkColorRect
                    property color selectedColor: Plasmoid.configuration.colorLK || "#3FB36F"
                    width: 32
                    height: 24
                    radius: 6
                    color: selectedColor
                    border.width: 1
                    border.color: Kirigami.Theme.separatorColor

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            colorPicker.targetRect = lkColorRect;
                            colorPicker.selectedColor = lkColorRect.selectedColor;
                            colorPicker.open();
                        }
                    }
                }

                QQC2.Label {
                    text: lkColorRect.selectedColor.toString().toUpperCase()
                    font.family: "Monospace"
                }

                QQC2.Button {
                    text: i18n("Выбрать…")
                    onClicked: {
                        colorPicker.targetRect = lkColorRect;
                        colorPicker.selectedColor = lkColorRect.selectedColor;
                        colorPicker.open();
                    }
                }
            }

            // Color Row: ЛР
            RowLayout {
                Kirigami.FormData.label: i18n("Лабораторная (ЛР):")
                spacing: 10

                Rectangle {
                    id: lrColorRect
                    property color selectedColor: Plasmoid.configuration.colorLR || "#F08A24"
                    width: 32
                    height: 24
                    radius: 6
                    color: selectedColor
                    border.width: 1
                    border.color: Kirigami.Theme.separatorColor

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            colorPicker.targetRect = lrColorRect;
                            colorPicker.selectedColor = lrColorRect.selectedColor;
                            colorPicker.open();
                        }
                    }
                }

                QQC2.Label {
                    text: lrColorRect.selectedColor.toString().toUpperCase()
                    font.family: "Monospace"
                }

                QQC2.Button {
                    text: i18n("Выбрать…")
                    onClicked: {
                        colorPicker.targetRect = lrColorRect;
                        colorPicker.selectedColor = lrColorRect.selectedColor;
                        colorPicker.open();
                    }
                }
            }

            // Color Row: ПЗ
            RowLayout {
                Kirigami.FormData.label: i18n("Практика (ПЗ):")
                spacing: 10

                Rectangle {
                    id: pzColorRect
                    property color selectedColor: Plasmoid.configuration.colorPZ || "#8E5CD9"
                    width: 32
                    height: 24
                    radius: 6
                    color: selectedColor
                    border.width: 1
                    border.color: Kirigami.Theme.separatorColor

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            colorPicker.targetRect = pzColorRect;
                            colorPicker.selectedColor = pzColorRect.selectedColor;
                            colorPicker.open();
                        }
                    }
                }

                QQC2.Label {
                    text: pzColorRect.selectedColor.toString().toUpperCase()
                    font.family: "Monospace"
                }

                QQC2.Button {
                    text: i18n("Выбрать…")
                    onClicked: {
                        colorPicker.targetRect = pzColorRect;
                        colorPicker.selectedColor = pzColorRect.selectedColor;
                        colorPicker.open();
                    }
                }
            }

            // Color Row: Экзамен
            RowLayout {
                Kirigami.FormData.label: i18n("Экзамен:")
                spacing: 10

                Rectangle {
                    id: examColorRect
                    property color selectedColor: Plasmoid.configuration.colorExam || "#FF3B30"
                    width: 32
                    height: 24
                    radius: 6
                    color: selectedColor
                    border.width: 1
                    border.color: Kirigami.Theme.separatorColor

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            colorPicker.targetRect = examColorRect;
                            colorPicker.selectedColor = examColorRect.selectedColor;
                            colorPicker.open();
                        }
                    }
                }

                QQC2.Label {
                    text: examColorRect.selectedColor.toString().toUpperCase()
                    font.family: "Monospace"
                }

                QQC2.Button {
                    text: i18n("Выбрать…")
                    onClicked: {
                        colorPicker.targetRect = examColorRect;
                        colorPicker.selectedColor = examColorRect.selectedColor;
                        colorPicker.open();
                    }
                }
            }

            // Color Row: Консультация
            RowLayout {
                Kirigami.FormData.label: i18n("Консультация:")
                spacing: 10

                Rectangle {
                    id: consultationColorRect
                    property color selectedColor: Plasmoid.configuration.colorConsultation || "#32ADE6"
                    width: 32
                    height: 24
                    radius: 6
                    color: selectedColor
                    border.width: 1
                    border.color: Kirigami.Theme.separatorColor

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            colorPicker.targetRect = consultationColorRect;
                            colorPicker.selectedColor = consultationColorRect.selectedColor;
                            colorPicker.open();
                        }
                    }
                }

                QQC2.Label {
                    text: consultationColorRect.selectedColor.toString().toUpperCase()
                    font.family: "Monospace"
                }

                QQC2.Button {
                    text: i18n("Выбрать…")
                    onClicked: {
                        colorPicker.targetRect = consultationColorRect;
                        colorPicker.selectedColor = consultationColorRect.selectedColor;
                        colorPicker.open();
                    }
                }
            }

            // Reset Colors Button
            QQC2.Button {
                text: i18n("Сбросить цвета на стандартные")
                icon.name: "edit-undo"
                onClicked: {
                    lkColorRect.selectedColor = "#3FB36F";
                    lrColorRect.selectedColor = "#F08A24";
                    pzColorRect.selectedColor = "#8E5CD9";
                    examColorRect.selectedColor = "#FF3B30";
                    consultationColorRect.selectedColor = "#32ADE6";
                }
            }
        }
    }
}
