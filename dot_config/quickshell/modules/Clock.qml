import Quickshell
import QtQuick
import ".."

// Click to switch between "Monday 14:05" and "06 October W41 2026".
IconLabel {
    id: root

    property bool showDate: false

    text: showDate
        ? Qt.formatDate(clock.date, "dd MMMM") + ` W${isoWeek(clock.date)} ` + Qt.formatDate(clock.date, "yyyy")
        : Qt.formatDateTime(clock.date, "dddd HH:mm")

    function isoWeek(date) {
        const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
        d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7));
        const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
        return String(Math.ceil(((d - yearStart) / 86400000 + 1) / 7)).padStart(2, "0");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    onClicked: showDate = !showDate
}
