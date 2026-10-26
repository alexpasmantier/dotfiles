import Quickshell
import Quickshell.Hyprland
import QtQuick
import ".."

// Workspaces 1-5 are always shown, others only while they exist.
// The active one is drawn as a wider filled pill.
Row {
    id: root

    required property ShellScreen screen
    readonly property int activeId: Hyprland.monitorFor(screen)?.activeWorkspace?.id ?? -1

    readonly property var ids: {
        const existing = Hyprland.workspaces.values.map(w => w.id).filter(id => id > 0);
        return [...new Set([1, 2, 3, 4, 5, ...existing])].sort((a, b) => a - b);
    }

    spacing: 2

    Repeater {
        model: root.ids

        Rectangle {
            id: pill

            required property int modelData
            readonly property HyprlandWorkspace workspace: Hyprland.workspaces.values.find(w => w.id === modelData) ?? null
            readonly property bool active: modelData === root.activeId

            implicitWidth: active ? 34 : 22
            implicitHeight: 20
            anchors.verticalCenter: parent.verticalCenter
            radius: height / 2
            color: active ? Theme.foreground : mouse.containsMouse ? Qt.alpha(Theme.foreground, 0.15) : "transparent"

            Behavior on implicitWidth {
                NumberAnimation { duration: 150; easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: 150 }
            }

            BarText {
                anchors.centerIn: parent
                text: pill.modelData
                color: pill.active ? Theme.surface : Theme.foreground
                opacity: pill.active || pill.workspace?.toplevels.values.length > 0 ? 1 : 0.5
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = "${pill.modelData}" })`)
            }
        }
    }
}
