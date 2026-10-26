import QtQuick

// Clickable icon + text, the building block of most bar modules.
MouseArea {
    id: root

    property alias icon: icon.text
    property alias text: label.text
    property alias textFormat: label.textFormat
    property int maxTextWidth: 0
    // Set to false for items with no click action: no hover effect then.
    property bool interactive: true

    implicitWidth: row.implicitWidth
    implicitHeight: Theme.chipHeight
    hoverEnabled: interactive
    cursorShape: interactive ? Qt.PointingHandCursor : Qt.ArrowCursor

    HoverHighlight {}

    Row {
        id: row
        anchors.verticalCenter: parent.verticalCenter
        spacing: 6

        Icon {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
            visible: text !== ""
        }
        BarText {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            visible: text !== ""
            width: root.maxTextWidth > 0 ? Math.min(implicitWidth, root.maxTextWidth) : implicitWidth
            elide: Text.ElideRight
        }
    }
}
