import Quickshell
import QtQuick

// Panel that opens under `anchorItem`. Closes on click outside or Escape.
PopupWindow {
    id: root

    required property Item anchorItem
    default property alias content: column.data

    anchor.item: anchorItem
    anchor.rect.x: anchorItem.width / 2 - implicitWidth / 2
    anchor.rect.y: anchorItem.height + 10
    implicitWidth: 340
    implicitHeight: column.implicitHeight + 24
    color: "transparent"
    grabFocus: true
    visible: Popups.current === root && anchorItem.visible

    onVisibleChanged: {
        if (!visible && Popups.current === root)
            Popups.current = null;
    }

    Rectangle {
        anchors.fill: parent
        radius: 14
        color: Theme.surface
        border.color: Qt.alpha(Theme.foreground, 0.12)

        Column {
            id: column
            anchors.fill: parent
            anchors.margins: 12
            spacing: 6
            focus: true
            Keys.onEscapePressed: Popups.current = null
        }
    }
}
