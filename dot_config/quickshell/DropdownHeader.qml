import QtQuick
import QtQuick.Layouts

// Dropdown title with optional controls (e.g. a Toggle) on the right.
RowLayout {
    property string text
    default property alias controls: controls.data

    implicitHeight: 32

    BarText {
        Layout.fillWidth: true
        Layout.leftMargin: 4
        text: parent.text
        font.bold: true
    }
    Row {
        id: controls
        spacing: 8
    }
}
