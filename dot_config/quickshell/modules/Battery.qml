import Quickshell.Services.UPower
import QtQuick
import ".."

// Hidden when plugged in but not charging, like waybar's empty "format-plugged".
IconLabel {
    readonly property UPowerDevice battery: UPower.displayDevice
    readonly property int percent: Math.round((battery?.percentage ?? 0) * 100)
    readonly property int state: battery?.state ?? UPowerDeviceState.Unknown

    readonly property var icons: ["battery_0_bar", "battery_1_bar", "battery_2_bar", "battery_3_bar", "battery_4_bar", "battery_5_bar", "battery_6_bar", "battery_full"]
    readonly property var chargingIcons: ["battery_charging_20", "battery_charging_20", "battery_charging_30", "battery_charging_50", "battery_charging_60", "battery_charging_80", "battery_charging_90", "battery_charging_full"]

    visible: battery?.isLaptopBattery && (state === UPowerDeviceState.Charging || state === UPowerDeviceState.Discharging || state === UPowerDeviceState.FullyCharged)
    icon: {
        if (state === UPowerDeviceState.FullyCharged) return "battery_full";
        const level = Math.min(7, Math.floor(percent / 100 * 8));
        return (state === UPowerDeviceState.Charging ? chargingIcons : icons)[level];
    }
    text: state === UPowerDeviceState.FullyCharged ? "" : `${percent}%`
}
