import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2

Item {
    id: root

    property var lesson: ({})
    property var pal: ({})
    property bool compact: false
    property bool showNote: true
    property bool showPhoto: true

    implicitWidth: parent ? parent.width : 280
    implicitHeight: lesson.isMine ? contentRow.implicitHeight + 8 : otherSubgroupBox.implicitHeight + 8

    // ─── Case 1: isMine (regular highlighted lesson) ───────────
    RowLayout {
        id: contentRow
        anchors.fill: parent
        anchors.topMargin: 4
        anchors.bottomMargin: 4
        spacing: 8
        visible: root.lesson.isMine !== false

        // Vertical Accent Color Bar
        Rectangle {
            Layout.preferredWidth: 4
            Layout.fillHeight: true
            Layout.minimumHeight: 28
            radius: 2
            color: root.lesson.typeColorHex || "#9A9A9E"
        }

        // Main info: Subject, Subgroup, Time, Auditory, Note
        ColumnLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter
            spacing: 2

            // Subject + Subgroup row
            RowLayout {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    id: subjectText
                    text: root.lesson.subject || ""
                    font.pixelSize: root.compact ? 12 : 13
                    font.weight: Font.DemiBold
                    color: root.pal.textPrimary || "#FFFFFF"
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                Text {
                    id: subgroupBadge
                    visible: root.lesson.numSubgroup === 1 || root.lesson.numSubgroup === 2
                    text: " " + root.lesson.numSubgroup + " п/г"
                    font.pixelSize: root.compact ? 9 : 10
                    font.weight: Font.Medium
                    color: root.lesson.typeColorHex || "#9A9A9E"
                }

                Text {
                    id: typeBadge
                    visible: root.lesson.typeAbbrev && !root.compact
                    text: root.lesson.typeAbbrev
                    font.pixelSize: 9
                    font.weight: Font.Bold
                    color: root.lesson.typeColorHex || "#9A9A9E"
                    opacity: 0.8
                }
            }

            // Time & Auditory
            Text {
                text: (root.lesson.startTime || "") + "–" + (root.lesson.endTime || "") + (root.lesson.auditoryText || "")
                font.pixelSize: root.compact ? 10 : 11
                color: root.pal.textSecondary || "#98989F"
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            // Teacher Name (if no photos or compact)
            Text {
                visible: (!root.showPhoto || (root.lesson.teachers && root.lesson.teachers.length === 0)) && root.lesson.teacherNames !== ""
                text: root.lesson.teacherNames || ""
                font.pixelSize: 10
                color: root.pal.textSecondary || "#98989F"
                elide: Text.ElideRight
                Layout.fillWidth: true
            }

            // Note (if any)
            Text {
                visible: root.showNote && !!root.lesson.note
                text: root.lesson.note || ""
                font.pixelSize: 10
                font.italic: true
                color: root.pal.textSecondary || "#98989F"
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }

        // Avatars / Student groups stack on the right
        AvatarStack {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            visible: root.showPhoto
            teachers: root.lesson.teachers || []
            studentGroups: root.lesson.studentGroups || []
            pal: root.pal
        }
    }

    // ─── Case 2: !isMine (Other subgroup lesson - muted / dashed) ──
    Rectangle {
        id: otherSubgroupBox
        anchors.fill: parent
        anchors.topMargin: 2
        anchors.bottomMargin: 2
        visible: root.lesson.isMine === false
        color: "transparent"
        border.width: 1
        border.color: (root.lesson.typeColorHex || "#9A9A9E") + "66"
        radius: 8

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 6
            spacing: 2

            RowLayout {
                Layout.fillWidth: true
                spacing: 4

                Text {
                    text: root.lesson.subject || ""
                    font.pixelSize: 12
                    font.weight: Font.Medium
                    color: root.pal.textSecondary || "#98989F"
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                }

                Text {
                    visible: root.lesson.numSubgroup === 1 || root.lesson.numSubgroup === 2
                    text: " " + root.lesson.numSubgroup + " п/г"
                    font.pixelSize: 9
                    font.weight: Font.Medium
                    color: root.lesson.typeColorHex || "#9A9A9E"
                }
            }

            Text {
                text: (root.lesson.startTime || "") + "–" + (root.lesson.endTime || "") + (root.lesson.auditoryText || "")
                font.pixelSize: 10
                color: root.pal.textSecondary || "#98989F"
                elide: Text.ElideRight
                Layout.fillWidth: true
            }
        }
    }

    // Tooltip with detailed subject name & teachers
    QQC2.ToolTip.visible: hoverArea.containsMouse
    QQC2.ToolTip.text: {
        var parts = [];
        if (root.lesson.subjectFullName) parts.push(root.lesson.subjectFullName);
        else if (root.lesson.subject) parts.push(root.lesson.subject);
        if (root.lesson.typeAbbrev) parts.push("Тип: " + root.lesson.typeAbbrev);
        if (root.lesson.teacherNames) parts.push("Преподаватель: " + root.lesson.teacherNames);
        if (root.lesson.auditories && root.lesson.auditories.length > 0) parts.push("Аудитории: " + root.lesson.auditories.join(", "));
        if (root.lesson.note) parts.push("Заметка: " + root.lesson.note);
        return parts.join("\n");
    }
    QQC2.ToolTip.delay: 500

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
