import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import ".."

// Left click opens the player controls, right click toggles play/pause.
IconLabel {
    id: root

    readonly property var players: Mpris.players.values.filter(p => !/firefox|playerctld/i.test(p.dbusName))
    readonly property MprisPlayer player: players.find(p => p.isPlaying) ?? players[0] ?? null
    readonly property string track: player ? `${player.trackTitle} - ${player.trackArtist}` : ""

    function formatTime(seconds) {
        const s = Math.max(0, Math.floor(seconds));
        return `${Math.floor(s / 60)}:${String(s % 60).padStart(2, "0")}`;
    }

    visible: player !== null
    maxTextWidth: 400
    textFormat: Text.StyledText
    icon: player?.isPlaying ? "play_arrow" : "pause"
    text: player?.isPlaying ? track : `<i>${track}</i>`

    acceptedButtons: Qt.LeftButton | Qt.RightButton
    onClicked: event => {
        if (event.button === Qt.LeftButton)
            Popups.toggle(dropdown);
        else
            player?.togglePlaying();
    }

    Dropdown {
        id: dropdown

        anchorItem: root

        // MPRIS doesn't push position updates, so poll while visible.
        Timer {
            interval: 1000
            repeat: true
            running: dropdown.visible && (root.player?.isPlaying ?? false)
            onTriggered: root.player.positionChanged()
        }

        RowLayout {
            width: parent.width
            spacing: 12

            ClippingRectangle {
                implicitWidth: 72
                implicitHeight: 72
                radius: 10
                color: Qt.alpha(Theme.foreground, 0.1)

                Icon {
                    anchors.centerIn: parent
                    text: "music_note"
                    font.pixelSize: 32
                    color: Theme.foregroundDim
                }
                Image {
                    anchors.fill: parent
                    source: root.player?.trackArtUrl ?? ""
                    fillMode: Image.PreserveAspectCrop
                    sourceSize: Qt.size(144, 144)
                    asynchronous: true
                }
            }

            ColumnLayout {
                Layout.fillWidth: true
                spacing: 2

                BarText {
                    Layout.fillWidth: true
                    text: root.player?.trackTitle ?? ""
                    font.bold: true
                    elide: Text.ElideRight
                }
                BarText {
                    Layout.fillWidth: true
                    text: root.player?.trackArtist ?? ""
                    color: Theme.foregroundDim
                    font.pixelSize: 13
                    elide: Text.ElideRight
                }
                BarText {
                    Layout.fillWidth: true
                    text: root.player?.identity ?? ""
                    color: Theme.foregroundDim
                    font.pixelSize: 11
                    elide: Text.ElideRight
                }
            }
        }

        Slider {
            width: parent.width
            visible: root.player?.lengthSupported ?? false
            value: root.player && root.player.length > 0 ? root.player.position / root.player.length : 0
            onMoved: value => {
                if (root.player?.canSeek)
                    root.player.position = value * root.player.length;
            }
        }

        RowLayout {
            width: parent.width
            visible: root.player?.lengthSupported ?? false

            BarText {
                text: root.formatTime(root.player?.position ?? 0)
                color: Theme.foregroundDim
                font.pixelSize: 11
            }
            Item {
                Layout.fillWidth: true
            }
            BarText {
                text: root.formatTime(root.player?.length ?? 0)
                color: Theme.foregroundDim
                font.pixelSize: 11
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 16

            IconButton {
                text: "skip_previous"
                enabled: root.player?.canGoPrevious ?? false
                opacity: enabled ? 1 : 0.4
                onClicked: root.player.previous()
            }
            IconButton {
                size: 40
                text: root.player?.isPlaying ? "pause" : "play_arrow"
                font.pixelSize: 26
                onClicked: root.player.togglePlaying()
            }
            IconButton {
                text: "skip_next"
                enabled: root.player?.canGoNext ?? false
                opacity: enabled ? 1 : 0.4
                onClicked: root.player.next()
            }
        }
    }
}
