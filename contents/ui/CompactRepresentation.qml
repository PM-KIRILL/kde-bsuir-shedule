import QtQuick
import QtQuick.Layouts
import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import "ScheduleLogic.js" as Logic

Item {
    id: compactRoot

    property var scheduleData: null
    property int currentWeek: 1
    property string groupNumber: ""
    property int subgroup: 0
    property bool showPastLessons: false
    property var pal: ({})
    property var timerDate: null

    property var displayInfo: {
        var _tick = compactRoot.timerDate;
        return Logic.resolveDisplay(
            compactRoot.scheduleData,
            compactRoot.currentWeek,
            compactRoot.subgroup,
            compactRoot.showPastLessons
        );
    }

    property var nextLesson: (displayInfo.lessons && displayInfo.lessons.length > 0) ? displayInfo.lessons[0] : null

    implicitWidth: Kirigami.Units.iconSizes.medium
    implicitHeight: Kirigami.Units.iconSizes.medium

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: Plasmoid.expanded = !Plasmoid.expanded
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: 4

        // App/Calendar Icon
        Kirigami.Icon {
            id: icon
            Layout.preferredWidth: Math.min(compactRoot.width, compactRoot.height) - 4
            Layout.preferredHeight: Layout.preferredWidth
            source: Qt.resolvedUrl("../icons/icon.png")
            fallback: "view-calendar-timeline"
        }

        // Small badge with week or next lesson time if panel is wide
        Rectangle {
            visible: compactRoot.width > 70 && !!compactRoot.nextLesson
            Layout.preferredHeight: 18
            Layout.preferredWidth: badgeText.implicitWidth + 8
            radius: 9
            color: compactRoot.nextLesson ? (compactRoot.nextLesson.typeColorHex || Logic.COLOR_BLUE) : Logic.COLOR_BLUE

            Text {
                id: badgeText
                anchors.centerIn: parent
                text: compactRoot.nextLesson ? compactRoot.nextLesson.startTime : ("W" + compactRoot.currentWeek)
                font.pixelSize: 10
                font.bold: true
                color: "#FFFFFF"
            }
        }
    }
}
