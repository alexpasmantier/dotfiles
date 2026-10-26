import Quickshell
import QtQuick
import QtQuick.Layouts
import "modules"

PanelWindow {
    id: bar

    required property var modelData
    screen: modelData

    anchors {
        top: true
        left: true
        right: true
    }
    implicitHeight: Theme.barHeight
    color: "transparent"

    RowLayout {
        anchors.left: parent.left
        anchors.leftMargin: Theme.chipGap
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.chipGap

        Chip {
            Workspaces {
                screen: bar.screen
            }
        }
        Chip {
            visible: media.visible
            Media {
                id: media
            }
        }
    }

    RowLayout {
        anchors.centerIn: parent
        spacing: Theme.chipGap

        Chip {
            Clock {}
        }
        Chip {
            visible: windowTitle.text !== ""
            WindowTitle {
                id: windowTitle
            }
        }
    }

    RowLayout {
        anchors.right: parent.right
        anchors.rightMargin: Theme.chipGap
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.chipGap

        Chip {
            Tray {
                barWindow: bar
            }
        }
        Chip {
            SystemStats {}
        }
        Chip {
            ThemeToggle {}
            Bluetooth {}
            Network {}
            Volume {}
            Battery {}
        }
    }
}
