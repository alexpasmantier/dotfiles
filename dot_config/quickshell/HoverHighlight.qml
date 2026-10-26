import QtQuick

// Rounded highlight behind a clickable bar item while the mouse is over it.
// Put it first inside a MouseArea that has hoverEnabled: true.
Rectangle {
    anchors.fill: parent
    anchors.leftMargin: -7
    anchors.rightMargin: -7
    anchors.topMargin: 3
    anchors.bottomMargin: 3
    radius: height / 2
    color: Qt.alpha(Theme.foreground, parent.containsMouse ? 0.15 : 0)

    Behavior on color {
        ColorAnimation { duration: 120 }
    }
}
