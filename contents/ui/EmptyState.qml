import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property var pal: ({})
    property bool allDone: false
    property string holidayName: ""
    property string dateLabel: ""
    property string noClassesText: i18n("Занятий нет")
    property string allDoneText: i18n("Все занятия на сегодня завершены")

    implicitHeight: 120
    implicitWidth: 200

    ColumnLayout {
        anchors.centerIn: parent
        spacing: 6
        width: Math.min(parent.width - 24, 280)

        // Icon (⭐ for holiday, ✓ for all done, 📅 for no classes)
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: root.holidayName !== "" ? "⭐" : (root.allDone ? "✓" : "📅")
            font.pixelSize: 26
        }

        // Primary title
        Text {
            Layout.alignment: Qt.AlignHCenter
            Layout.fillWidth: true
            text: {
                if (root.holidayName !== "") return root.holidayName;
                return root.allDone ? root.allDoneText : root.noClassesText;
            }
            font.pixelSize: 12
            font.weight: Font.Medium
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            color: root.holidayName !== "" ? (root.pal.textPrimary || "#FFFFFF") : (root.pal.textSecondary || "#98989F")
        }

        // Subtitle (date label if holiday)
        Text {
            Layout.alignment: Qt.AlignHCenter
            visible: root.holidayName !== "" && root.dateLabel !== ""
            text: root.dateLabel
            font.pixelSize: 11
            color: root.pal.textSecondary || "#98989F"
        }
    }
}
