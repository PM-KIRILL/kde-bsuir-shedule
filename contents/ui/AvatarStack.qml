import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import QtQuick.Effects

Item {
    id: root

    property var teachers: []
    property var studentGroups: []
    property var pal: ({})

    implicitHeight: 28
    implicitWidth: {
        if (teachers && teachers.length > 0) {
            var count = Math.min(teachers.length, 2);
            var extra = teachers.length > 2 ? 1 : 0;
            return (count + extra) * 18 + 10;
        }
        if (studentGroups && studentGroups.length > 0) {
            var gCount = Math.min(studentGroups.length, 2);
            var gExtra = studentGroups.length > 2 ? 1 : 0;
            return (gCount + gExtra) * 18 + 12;
        }
        return 0;
    }

    // Teacher Avatars
    Row {
        id: teacherRow
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: -10
        visible: teachers && teachers.length > 0
        layoutDirection: Qt.RightToLeft

        // First 2 teachers (rendered right-to-left)
        Repeater {
            model: root.teachers ? root.teachers.slice(0, 2) : []

            Rectangle {
                id: avatarCircle
                width: 28
                height: 28
                radius: 14
                color: root.pal.avatarBg || "#3A3A3C"
                border.width: 1.5
                border.color: root.pal.cardBg || "#1C1C1E"
                clip: true

                // Fallback Initials
                Text {
                    anchors.centerIn: parent
                    text: modelData.initials || "?"
                    font.pixelSize: 10
                    font.bold: true
                    color: root.pal.textSecondary || "#98989F"
                    visible: !photoImg.visible || photoImg.status !== Image.Ready
                }

                // Photo Image
                Image {
                    id: photoImg
                    anchors.fill: parent
                    source: modelData.photoUrl || ""
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    cache: true
                    visible: status === Image.Ready
                    layer.enabled: true
                    layer.effect: MultiEffect {
                        maskEnabled: true
                        maskThresholdMin: 0.5
                        maskSpreadAtMin: 1.0
                        maskSource: ShaderEffectSource {
                            sourceItem: Rectangle {
                                width: 28
                                height: 28
                                radius: 14
                            }
                        }
                    }
                }

                QQC2.ToolTip.visible: mouseArea.containsMouse
                QQC2.ToolTip.text: modelData.fullName || modelData.name || ""
                QQC2.ToolTip.delay: 300

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
        }

        // "+N" circle if > 2 teachers
        Rectangle {
            width: 28
            height: 28
            radius: 14
            color: root.pal.avatarBg || "#3A3A3C"
            border.width: 1.5
            border.color: root.pal.cardBg || "#1C1C1E"
            visible: root.teachers && root.teachers.length > 2

            Text {
                anchors.centerIn: parent
                text: "+" + (root.teachers.length - 2)
                font.pixelSize: 10
                font.bold: true
                color: root.pal.textSecondary || "#98989F"
            }

            QQC2.ToolTip.visible: extraMouseArea.containsMouse
            QQC2.ToolTip.text: {
                if (!root.teachers) return "";
                var names = [];
                for (var i = 2; i < root.teachers.length; i++) {
                    names.push(root.teachers[i].fullName || root.teachers[i].name);
                }
                return names.join("\n");
            }
            QQC2.ToolTip.delay: 300

            MouseArea {
                id: extraMouseArea
                anchors.fill: parent
                hoverEnabled: true
            }
        }
    }

    // Student Group Circles (for employee schedule)
    Row {
        id: groupRow
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: -10
        visible: (!root.teachers || root.teachers.length === 0) && root.studentGroups && root.studentGroups.length > 0
        layoutDirection: Qt.RightToLeft

        Repeater {
            model: root.studentGroups ? root.studentGroups.slice(0, 2) : []

            Rectangle {
                width: 30
                height: 30
                radius: 15
                color: root.pal.avatarBg || "#3A3A3C"
                border.width: 1.5
                border.color: root.pal.cardBg || "#1C1C1E"

                Text {
                    anchors.centerIn: parent
                    text: modelData
                    font.pixelSize: 7
                    font.bold: true
                    color: root.pal.textSecondary || "#98989F"
                }
            }
        }

        Rectangle {
            width: 30
            height: 30
            radius: 15
            color: root.pal.avatarBg || "#3A3A3C"
            border.width: 1.5
            border.color: root.pal.cardBg || "#1C1C1E"
            visible: root.studentGroups && root.studentGroups.length > 2

            Text {
                anchors.centerIn: parent
                text: "+" + (root.studentGroups.length - 2)
                font.pixelSize: 9
                font.bold: true
                color: root.pal.textSecondary || "#98989F"
            }
        }
    }
}
