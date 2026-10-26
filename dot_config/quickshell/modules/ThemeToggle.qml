import Quickshell
import QtQuick
import ".."

// Switches the system color scheme. Ghostty and the bar follow it.
IconLabel {
    icon: Theme.dark ? "light_mode" : "dark_mode"
    onClicked: Quickshell.execDetached(["gsettings", "set", "org.gnome.desktop.interface", "color-scheme", Theme.dark ? "prefer-light" : "prefer-dark"])
}
