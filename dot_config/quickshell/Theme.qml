pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

// Colors follow the system light/dark mode, matching ghostty's themes
// (vague_aubergine when dark, iTerm2 Solarized Light when light).
Singleton {
    id: root

    property bool dark: true

    readonly property color foreground: dark ? "#b2b2d3" : "#657b83"
    readonly property color foregroundDim: dark ? "#727294" : "#93a1a1"
    readonly property color background: dark ? "#241f31" : "#fdf6e3"
    readonly property color surface: dark ? "#322b44" : "#eee8d5"

    readonly property string fontFamily: "JetBrains Mono"
    readonly property string iconFont: "Material Symbols Rounded"
    readonly property int iconSize: 18
    readonly property int fontSize: 15
    readonly property int barHeight: 34
    readonly property int chipHeight: 26
    readonly property int chipGap: 6
    readonly property int moduleSpacing: 14

    readonly property string wallpaper: dark
        ? "/home/alex/Downloads/space.jpg"
        : "/home/alex/Downloads/pia26680orig.png"

    onWallpaperChanged: Quickshell.execDetached(["hyprctl", "hyprpaper", "wallpaper", `,${wallpaper}`])

    function readScheme(value) {
        root.dark = value.includes("dark");
    }

    Process {
        command: ["gsettings", "get", "org.gnome.desktop.interface", "color-scheme"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.readScheme(text)
        }
    }

    Process {
        command: ["gsettings", "monitor", "org.gnome.desktop.interface", "color-scheme"]
        running: true
        stdout: SplitParser {
            onRead: line => root.readScheme(line)
        }
    }
}
