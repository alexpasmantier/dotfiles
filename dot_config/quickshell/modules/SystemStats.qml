import Quickshell
import Quickshell.Io
import QtQuick
import ".."

// Memory and CPU usage, read from /proc every 5 seconds.
Row {
    id: root

    property string memory: ""
    property int cpuUsage: 0
    property var lastCpu: null

    spacing: Theme.moduleSpacing

    function update() {
        meminfo.reload();
        const kb = key => Number(meminfo.text().match(new RegExp(`^${key}:\\s+(\\d+)`, "m"))[1]);
        const gib = value => (value / 1024 / 1024).toFixed(1);
        const total = kb("MemTotal");
        memory = `${gib(total - kb("MemAvailable"))}/${gib(total)}G`;

        stat.reload();
        const fields = stat.text().split("\n")[0].split(/\s+/).slice(1).map(Number);
        const idle = fields[3] + fields[4];
        const total2 = fields.reduce((a, b) => a + b, 0);
        if (lastCpu) {
            const dTotal = total2 - lastCpu.total;
            cpuUsage = dTotal > 0 ? Math.round(100 * (1 - (idle - lastCpu.idle) / dTotal)) : 0;
        }
        lastCpu = { idle, total: total2 };
    }

    FileView {
        id: meminfo
        path: "/proc/meminfo"
        blockLoading: true
    }

    FileView {
        id: stat
        path: "/proc/stat"
        blockLoading: true
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: root.update()
    }

    IconLabel {
        icon: "memory_alt"
        interactive: false
        text: root.memory
    }

    IconLabel {
        icon: "memory"
        text: `${root.cpuUsage}%`
        onClicked: Quickshell.execDetached(["kitty", "-e", "btm"])
    }
}
