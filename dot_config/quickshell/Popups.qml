pragma Singleton

import Quickshell
import QtQuick

// Tracks the open dropdown so only one is shown at a time.
Singleton {
    property var current: null

    function toggle(dropdown) {
        current = current === dropdown ? null : dropdown;
    }
}
