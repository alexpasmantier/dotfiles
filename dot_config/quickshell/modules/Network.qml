import Quickshell
import Quickshell.Networking
import QtQuick
import ".."

IconLabel {
    id: root

    readonly property var devices: Networking.devices.values
    readonly property var wired: devices.find(d => d.type === DeviceType.Wired && d.connected) ?? null
    readonly property var wifiDevice: devices.find(d => d.type === DeviceType.Wifi) ?? null
    readonly property var wifiNetwork: wifiDevice?.networks.values.find(n => n.connected) ?? null

    readonly property var wifiIcons: ["signal_wifi_0_bar", "network_wifi_1_bar", "network_wifi_2_bar", "network_wifi_3_bar", "signal_wifi_4_bar"]

    function wifiIcon(strength) {
        return wifiIcons[Math.min(4, Math.floor(strength * 5))];
    }

    icon: {
        if (wired) return "lan";
        if (wifiNetwork) return wifiIcon(wifiNetwork.signalStrength);
        return Networking.wifiEnabled ? "signal_wifi_bad" : "signal_wifi_off";
    }
    text: !wired && wifiNetwork ? wifiNetwork.name : ""
    onClicked: Popups.toggle(dropdown)

    Dropdown {
        id: dropdown

        // Name of the network waiting for a password, if any.
        property string passwordFor: ""

        anchorItem: root
        onVisibleChanged: passwordFor = ""

        // Scan for networks only while the dropdown is open.
        Binding {
            target: root.wifiDevice
            property: "scannerEnabled"
            value: dropdown.visible
            when: root.wifiDevice !== null
        }

        DropdownHeader {
            width: parent.width
            text: "Wi-Fi"

            Toggle {
                checked: Networking.wifiEnabled
                onToggled: Networking.wifiEnabled = !Networking.wifiEnabled
            }
        }

        Repeater {
            model: {
                if (!Networking.wifiEnabled || !root.wifiDevice) return [];
                return root.wifiDevice.networks.values
                    .filter(n => n.name !== "")
                    .sort((a, b) => b.connected - a.connected || b.signalStrength - a.signalStrength)
                    .slice(0, 12);
            }

            Column {
                id: entry

                required property var modelData
                readonly property bool secured: modelData.security !== WifiSecurityType.Open

                width: parent.width
                spacing: 4

                ListItem {
                    width: parent.width
                    icon: root.wifiIcon(entry.modelData.signalStrength)
                    text: entry.modelData.name
                    active: entry.modelData.connected
                    detail: {
                        const n = entry.modelData;
                        if (n.stateChanging) return "…";
                        if (n.connected) return "Connected";
                        if (n.known) return "Saved";
                        return "";
                    }
                    detailIcon: !entry.modelData.known && entry.secured ? "lock" : ""
                    onClicked: {
                        const n = entry.modelData;
                        if (n.connected) n.disconnect();
                        else if (n.known || !entry.secured) n.connect();
                        else dropdown.passwordFor = n.name;
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 34
                    radius: 8
                    visible: dropdown.passwordFor === entry.modelData.name
                    color: Qt.alpha(Theme.foreground, 0.08)
                    border.color: Qt.alpha(Theme.foreground, 0.25)

                    TextInput {
                        id: password
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        verticalAlignment: TextInput.AlignVCenter
                        color: Theme.foreground
                        font.family: Theme.fontFamily
                        font.pixelSize: 14
                        echoMode: TextInput.Password
                        focus: parent.visible
                        onAccepted: {
                            entry.modelData.connectWithPsk(text);
                            text = "";
                            dropdown.passwordFor = "";
                        }

                        BarText {
                            anchors.verticalCenter: parent.verticalCenter
                            visible: password.text === ""
                            text: "Password, then Enter"
                            color: Theme.foregroundDim
                            font.pixelSize: 14
                        }
                    }
                }
            }
        }
    }
}
