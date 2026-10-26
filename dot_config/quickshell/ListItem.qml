import QtQuick
import QtQuick.Layouts

// Clickable row: icon, label and a dimmed detail on the right.
Rectangle {
    id: root

    property string icon
    property string text
    property string detail
    property string detailIcon
    property bool active: false
    signal clicked

    implicitHeight: 34
    radius: 8
    color: mouse.containsMouse ? Qt.alpha(Theme.foreground, 0.1) : "transparent"

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 10

        Icon {
            text: root.icon
            visible: root.icon !== ""
            filled: root.active
        }
        BarText {
            Layout.fillWidth: true
            text: root.text
            font.bold: root.active
            elide: Text.ElideRight
        }
        BarText {
            text: root.detail
            visible: root.detail !== ""
            color: Theme.foregroundDim
            font.pixelSize: 12
        }
        Icon {
            text: root.detailIcon
            visible: root.detailIcon !== ""
            color: Theme.foregroundDim
            font.pixelSize: 16
        }
    }

    MouseArea {
        id: mouse
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
    }
}
