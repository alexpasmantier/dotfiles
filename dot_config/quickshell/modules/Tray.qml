import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick
import ".."

// "+" that reveals the tray icons on hover.
Row {
    id: root

    required property var barWindow

    // Stay open a bit after the mouse leaves, like waybar's drawer.
    property bool expanded: false

    spacing: 17

    HoverHandler {
        onHoveredChanged: hovered ? (hideTimer.stop(), root.expanded = true) : hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: 600
        onTriggered: root.expanded = false
    }

    Icon {
        anchors.verticalCenter: parent.verticalCenter
        text: root.expanded ? "chevron_right" : "chevron_left"
    }

    Repeater {
        model: SystemTray.items

        MouseArea {
            id: item

            required property SystemTrayItem modelData

            visible: root.expanded
            implicitWidth: 14
            implicitHeight: Theme.chipHeight
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: event => {
                if (event.button === Qt.LeftButton && !modelData.onlyMenu) {
                    modelData.activate();
                } else if (modelData.hasMenu) {
                    const pos = item.mapToItem(null, 0, item.height);
                    modelData.display(root.barWindow, pos.x, pos.y);
                }
            }

            HoverHighlight {}

            IconImage {
                anchors.centerIn: parent
                implicitSize: 14
                source: item.modelData.icon
            }
        }
    }
}
