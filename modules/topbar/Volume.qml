import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Hyprland
import "../../config"

CButton {
    implicitWidth: parent.width/6

    onClicked: {
    	Hyprland.dispatch("exec pavucontrol --tab=3")
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
            value: 50

            background : Rect {
                implicitWidth: speaker.visualPosition * parent.width
                implicitHeight: parent.height
                color: mainBar.primary
            }

            contentItem: Item {
                implicitWidth: parent.width
                implicitHeight: parent.height

                Rect {
                    width: Math.max(parent.height, (1-speaker.visualPosition) * parent.width)
                    height: parent.height

                    x: Math.min((speaker.visualPosition * parent.width),parent.width-parent.height)
                    color: Qt.darker(Settings.theme.colours[22],1.2)
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
            value: 50

            background : Rect {
                implicitWidth: mic.visualPosition * parent.width
                implicitHeight: parent.height
                color: mainBar.primary
            }

            contentItem: Item {
                implicitWidth: parent.width
                implicitHeight: parent.height

                Rect {
                    width: Math.max(parent.height, (1-mic.visualPosition) * parent.width)
                    height: parent.height

                    x: Math.min((mic.visualPosition * parent.width),parent.width-parent.height)
                    color: Qt.darker(Settings.theme.colours[22],1.2)
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
