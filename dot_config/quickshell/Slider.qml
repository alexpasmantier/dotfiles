import QtQuick

// Horizontal slider for values between 0 and 1. Emits `moved` while dragging.
Item {
    id: root

    property real value: 0
    signal moved(real value)

    implicitHeight: 20

    Rectangle {
        id: track
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width
        height: 6
        radius: 3
        color: Qt.alpha(Theme.foreground, 0.2)

        Rectangle {
            width: parent.width * Math.max(0, Math.min(1, root.value))
            height: parent.height
            radius: 3
            color: Theme.foreground
        }
    }

    Rectangle {
        width: 14
        height: 14
        radius: 7
        anchors.verticalCenter: parent.verticalCenter
        x: (root.width - width) * Math.max(0, Math.min(1, root.value))
        color: Theme.foreground
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        function update(x) {
            root.moved(Math.max(0, Math.min(1, x / width)));
        }

        onPressed: mouse => update(mouse.x)
        onPositionChanged: mouse => update(mouse.x)
    }
}
