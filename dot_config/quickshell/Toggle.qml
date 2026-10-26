import QtQuick

Rectangle {
    id: root

    property bool checked: false
    signal toggled

    implicitWidth: 36
    implicitHeight: 20
    radius: height / 2
    color: checked ? Theme.foreground : Qt.alpha(Theme.foreground, 0.2)

    Behavior on color {
        ColorAnimation { duration: 120 }
    }

    Rectangle {
        width: 14
        height: 14
        radius: 7
        x: root.checked ? root.width - width - 3 : 3
        anchors.verticalCenter: parent.verticalCenter
        color: root.checked ? Theme.surface : Theme.foreground

        Behavior on x {
            NumberAnimation { duration: 120; easing.type: Easing.OutCubic }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.toggled()
    }
}
