import QtQuick

// Rounded background that groups one or more modules.
Rectangle {
    default property alias content: row.data

    implicitWidth: row.implicitWidth + 24
    implicitHeight: Theme.chipHeight
    radius: height / 2
    color: Theme.surface

    Behavior on implicitWidth {
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
    }

    Row {
        id: row
        anchors.centerIn: parent
        spacing: Theme.moduleSpacing
    }
}
