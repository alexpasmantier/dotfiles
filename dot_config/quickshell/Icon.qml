import QtQuick

// Material Symbols icon, set `text` to the icon name (e.g. "volume_up").
// Names: https://fonts.google.com/icons
Text {
    property bool filled: false

    color: Theme.foreground
    font.family: Theme.iconFont
    font.pixelSize: Theme.iconSize
    font.variableAxes: ({ "FILL": filled ? 1 : 0, "wght": 400, "opsz": 24 })
    verticalAlignment: Text.AlignVCenter
}
