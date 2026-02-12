import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import Quickshell.Hyprland
import "../../config"

CButton {
    implicitWidth: parent.width/6

    onClicked: {
    	Hyprland.dispatch("exec pavucontrol --tab=3")
    }


    function changeAudio(value, slider){
        if (slider === "sink") Hyprland.dispatch("exec pactl set-sink-volume @DEFAULT_SINK@ " + value + "%")
        else if (slider === "source") Hyprland.dispatch("exec pactl set-source-volume @DEFAULT_SOURCE@ " + value + "%")
    }

    Process {
        id: getSinkValue
        running:true
        command: ["sh","-c","pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'"]
        stdout: StdioCollector {
            onStreamFinished: speaker.value = (this.text).split('%')[0]
        }
    }

    Process {
        id: getSourceValue
        running:true
        command: ["sh","-c","pactl get-source-volume @DEFAULT_SOURCE@ | awk '{print $5}'"]
        stdout: StdioCollector {
            onStreamFinished: mic.value = (this.text).split('%')[0]
        }
    }

    RowLayout {
        anchors.fill: parent
        anchors.margins: Settings.margin

        Slider {
            id: speaker
            implicitHeight: parent.height - Settings.margin
            Layout.fillWidth: true

            implicitWidth: parent.width/2 - (Settings.margin*2)

            from: 153
            to: 0

            onValueChanged: {
                changeAudio(value, "sink")
            }

            background : Rect {
                implicitWidth: speaker.visualPosition * parent.width
                implicitHeight: parent.height
                color: Settings.sliderBgColor
            }

            contentItem: Item {
                implicitWidth: parent.width
                implicitHeight: parent.height

                Rect {
                    width: Math.max(parent.height, (1-speaker.visualPosition) * parent.width)
                    height: parent.height

                    x: Math.min((speaker.visualPosition * parent.width),parent.width-parent.height)
                    color: Settings.sliderColor
                }
            }

            CText {
                anchors.centerIn: parent

                text : "SPEAKER"
                font.pixelSize: Settings.fontSize
            }


            handle: Rectangle{
                color : "transparent"
            }
        }

        Slider {
            id: mic
            implicitHeight: parent.height - Settings.margin
            Layout.fillWidth: true

            implicitWidth: parent.width/2 - (Settings.margin*2)

            from: 153
            to: 0

            onValueChanged: {
                changeAudio(value, "source")
            }

            background : Rect {
                implicitWidth: mic.visualPosition * parent.width
                implicitHeight: parent.height
                color: Settings.sliderBgColor
            }

            contentItem: Item {
                implicitWidth: parent.width
                implicitHeight: parent.height

                Rect {
                    width: Math.max(parent.height, (1-mic.visualPosition) * parent.width)
                    height: parent.height

                    x: Math.min((mic.visualPosition * parent.width),parent.width-parent.height)
                    color: Settings.sliderColor
                }
            }

            CText {
                anchors.centerIn: parent

                text : "MIC"
                font.pixelSize: Settings.fontSize
            }


            handle: Rectangle{
                color : "transparent"
            }
        }
    }
}
