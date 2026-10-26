import Quickshell
import Quickshell.Bluetooth
import QtQuick
import ".."

IconLabel {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property var devices: adapter?.devices.values ?? []
    readonly property var connected: devices.filter(d => d.connected)

    visible: adapter !== null
    icon: !adapter?.enabled ? "bluetooth_disabled" : connected.length > 0 ? "bluetooth_connected" : "bluetooth"
    text: adapter?.enabled ? connected.map(d => d.name).join(", ") : ""

    function detail(device) {
        if (device.state === BluetoothDeviceState.Connecting || device.pairing) return "…";
        if (!device.connected) return "";
        return device.batteryAvailable ? `${Math.round(device.battery * 100)}%` : "Connected";
    }

    onClicked: Popups.toggle(dropdown)

    Dropdown {
        id: dropdown

        anchorItem: root
        onVisibleChanged: {
            if (!visible && root.adapter)
                root.adapter.discovering = false;
        }

        DropdownHeader {
            width: parent.width
            text: "Bluetooth"

            IconButton {
                size: 24
                text: "bluetooth_searching"
                visible: root.adapter?.enabled ?? false
                opacity: root.adapter?.discovering ? 1 : 0.6
                onClicked: root.adapter.discovering = !root.adapter.discovering
            }
            Toggle {
                anchors.verticalCenter: parent.verticalCenter
                checked: root.adapter?.enabled ?? false
                onToggled: root.adapter.enabled = !root.adapter.enabled
            }
        }

        Repeater {
            model: root.adapter?.enabled ? root.devices.filter(d => d.paired) : []

            ListItem {
                required property BluetoothDevice modelData

                width: parent.width
                icon: modelData.connected ? "bluetooth_connected" : "bluetooth"
                text: modelData.name
                active: modelData.connected
                detail: root.detail(modelData)
                onClicked: modelData.connected ? modelData.disconnect() : modelData.connect()
            }
        }

        SectionLabel {
            text: "Nearby devices"
            visible: root.adapter?.discovering ?? false
        }

        Repeater {
            // Unnamed devices only show their address, skip them.
            model: root.adapter?.discovering
                ? root.devices.filter(d => !d.paired && d.deviceName !== "" && d.name !== d.address.replace(/:/g, "-"))
                : []

            ListItem {
                required property BluetoothDevice modelData

                width: parent.width
                icon: "bluetooth"
                text: modelData.name
                detail: modelData.pairing ? "Pairing…" : "Pair"
                onClicked: {
                    modelData.trusted = true;
                    modelData.pair();
                }
            }
        }
    }
}
