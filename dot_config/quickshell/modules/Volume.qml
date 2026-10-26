import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts
import ".."

IconLabel {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property int volume: Math.round((sink?.audio?.volume ?? 0) * 100)

    // Hardware devices only, not app streams.
    readonly property var sinks: Pipewire.nodes.values.filter(n => n.isSink && !n.isStream && n.audio)
    readonly property var sources: Pipewire.nodes.values.filter(n => !n.isSink && !n.isStream && n.audio)

    function volumeIcon(node) {
        if (node?.audio?.muted) return "volume_off";
        const v = node?.audio?.volume ?? 0;
        return v === 0 ? "volume_mute" : v < 0.5 ? "volume_down" : "volume_up";
    }

    function setVolume(node, value) {
        if (!node?.audio) return;
        node.audio.muted = false;
        node.audio.volume = Math.max(0, Math.min(1, value));
    }

    icon: volumeIcon(sink)
    text: sink?.audio?.muted ? "" : `${volume}%`

    // Needed for volume and mute state to be available.
    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: event => {
        if (event.button === Qt.LeftButton)
            Popups.toggle(dropdown);
        else if (sink?.audio)
            sink.audio.muted = !sink.audio.muted;
    }
    onWheel: event => setVolume(sink, (sink?.audio?.volume ?? 0) + (event.angleDelta.y > 0 ? 0.05 : -0.05))

    Dropdown {
        id: dropdown

        anchorItem: root

        DropdownHeader {
            width: parent.width
            text: "Output"
        }

        RowLayout {
            width: parent.width
            spacing: 8

            IconButton {
                text: root.volumeIcon(root.sink)
                onClicked: root.sink.audio.muted = !root.sink.audio.muted
            }
            Slider {
                Layout.fillWidth: true
                value: root.sink?.audio?.volume ?? 0
                onMoved: value => root.setVolume(root.sink, value)
            }
            BarText {
                Layout.preferredWidth: 44
                horizontalAlignment: Text.AlignRight
                text: `${root.volume}%`
                font.pixelSize: 13
            }
        }

        Repeater {
            model: root.sinks.length > 1 ? root.sinks : []

            ListItem {
                required property PwNode modelData

                width: parent.width
                text: modelData.description || modelData.name
                active: modelData === root.sink
                detailIcon: active ? "check" : ""
                onClicked: Pipewire.preferredDefaultAudioSink = modelData
            }
        }

        DropdownHeader {
            width: parent.width
            text: "Input"
        }

        RowLayout {
            width: parent.width
            spacing: 8

            IconButton {
                text: root.source?.audio?.muted ? "mic_off" : "mic"
                onClicked: root.source.audio.muted = !root.source.audio.muted
            }
            Slider {
                Layout.fillWidth: true
                value: root.source?.audio?.volume ?? 0
                onMoved: value => root.setVolume(root.source, value)
            }
            BarText {
                Layout.preferredWidth: 44
                horizontalAlignment: Text.AlignRight
                text: `${Math.round((root.source?.audio?.volume ?? 0) * 100)}%`
                font.pixelSize: 13
            }
        }

        Repeater {
            model: root.sources.length > 1 ? root.sources : []

            ListItem {
                required property PwNode modelData

                width: parent.width
                text: modelData.description || modelData.name
                active: modelData === root.source
                detailIcon: active ? "check" : ""
                onClicked: Pipewire.preferredDefaultAudioSource = modelData
            }
        }
    }
}
