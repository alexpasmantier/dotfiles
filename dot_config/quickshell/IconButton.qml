import QtQuick

Rectangle {
    id: root

    property alias text: label.text
    property alias font: label.font
    property int size: 32
    signal clicked

    implicitWidth: size
    implicitHeight: size
    radius: size / 2
    color: mouse.containsMouse ? Qt.alpha(Theme.foreground, 0.15) : "transparent"

    Icon {
        id: label
        anchors.centerIn: parent
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
