import Quickshell.Wayland
import QtQuick
import ".."

BarText {
    readonly property string title: ToplevelManager.activeToplevel?.title ?? ""

    text: {
        const t = title === "t" ? "tmux" : title;
        return t.length > 100 ? t.slice(0, 99) + "…" : t;
    }
}
