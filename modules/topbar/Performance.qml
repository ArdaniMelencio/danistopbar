import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../config"

CButton {
    id: perfRoot
    implicitWidth: parent.width/6

    property real cpu
    property real ramTotal
    property real ram

    Behavior on cpu {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
        }
    }

    Behavior on ram {
        NumberAnimation {
            duration: 1000
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
        }
    }


    RowLayout {
        anchors.fill: parent
        anchors.margins: Settings.margin
        spacing: 5

        Slider {

            id: cpuProg
            implicitHeight: parent.height - Settings.margin
            implicitWidth: parent.width/2 - Settings.margin
            from: 0
            to: 100
            value: cpu

            background : Rect {
                implicitWidth: cpuProg.visualPosition * parent.width
                implicitHeight: parent.height
                color: Settings.sliderBgColor
            }

            contentItem: Item {
                implicitWidth: parent.width
                implicitHeight: parent.height

                Rect {
                    width: Math.max(parent.height, cpuProg.visualPosition * parent.width)
                    height: parent.height
                    color: Settings.sliderColor
                }
            }

            CText {
                anchors.centerIn: parent

                text : "CPU"
                font.pixelSize: Settings.fontSize
            }

            handle: Rectangle { color: "transparent" }
            enabled: false
        }

        Slider {

            id: ramProg
            implicitHeight: parent.height - Settings.margin
            implicitWidth: parent.width/2 - Settings.margin
            from: 0
            to: perfRoot.ramTotal
            value: perfRoot.ram

            background : Rect {
                implicitWidth: ramProg.visualPosition * parent.width
                implicitHeight: parent.height
                color: Settings.sliderBgColor
            }

            contentItem: Item {
                implicitWidth: parent.width
                implicitHeight: parent.height

                // Progress indicator for determinate state.
                Rect {
                    width: Math.max(parent.height, ramProg.visualPosition * parent.width)
                    height: parent.height
                    color: Settings.sliderColor
                }
            }

            CText {
                anchors.centerIn: parent

                text : "RAM"
                font.pixelSize: Settings.fontSize}

            handle: Rectangle { color: "transparent" }
            enabled: false
        }
    }

    Process {
        id: cpuProc
        command: [
            "sh",
            "-c",
            "top -b -n 1 | grep '%Cpu' | awk '{print $2}'"
        ]
        running: true
        stdout: StdioCollector {
            onStreamFinished: perfRoot.cpu = this.text
        }
    }

    Process {
        id: ramProc
        command: [
            "sh",
            "-c",
            "free | awk '/Mem:/ {print $3}'"
        ]
        running: true
        stdout: StdioCollector {
            onStreamFinished: perfRoot.ram = this.text
        }
    }

    Process {
        command: [
            "sh",
            "-c",
            "free | awk '/Mem:/ {print $2}'"
        ]
        running: true
        stdout: StdioCollector {
            onStreamFinished: perfRoot.ramTotal = this.text
        }
    }


    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            cpuProc.running = true
            ramProc.running = true
        }
    }
}
