import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../config"

PanelWindow{
    id: popup
    anchors.top: parent.bottom
    implicitWidth: screen.width/3

    property real panelY : -height

    exclusiveZone: 0
    focusable: true

    color : "transparent"

    Behavior on panelY {
        NumberAnimation {
            duration:200
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
        }
    }

    onPanelYChanged: {
        if (panelY === -height) popup.WlrLayershell.layer = WlrLayer.Bottom
        else  popup.WlrLayershell.layer = WlrLayer.Overlay
    }

    Rect {
        id: ext
        color: mainBar.primary
        implicitHeight: parent.height
        implicitWidth: parent.width
        topRightRadius: 0
        topLeftRadius: 0

        y : panelY

        GridLayout {
            anchors.fill: parent
            columns: 2
            rows: 2

            uniformCellHeights: true
            uniformCellWidths: true


            Rect{
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: Settings.margin
                Layout.topMargin: Settings.margin
                color: Qt.alpha(Settings.theme.colours[2],0.2)

                CText {
                    id: dateToday
                    text: timeRoot.localTZ.split(".")[1].split(" <")[0]
                    anchors.top: parent.top
                    anchors.left: parent.left
                    font.pixelSize: Settings.fontSize*4
                    anchors.topMargin: Settings.margin+4
                }

                CText {
                    id: day
                    text: " - " +timeRoot.localTZ.split(".")[0]
                    anchors.top: dateToday.bottom
                    anchors.left: parent.left
                    font.pixelSize: Settings.fontSize*3
                    anchors.margins: Settings.margin
                }

            }


            WeatherAPI {
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.rightMargin: Settings.margin
                Layout.topMargin: Settings.margin
                color: Qt.alpha(Settings.theme.colours[2],0.2)
            }


            Rect{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: Settings.margin
                Layout.topMargin: 0
                Layout.columnSpan: 2

                color: Qt.alpha(Settings.theme.colours[2],0.2)
                CText {
                    id: mainTime
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Settings.margin
                    anchors.leftMargin: Settings.margin*5

                    text: timeRoot.localTZ.split('< ')[1]
                    font.pixelSize: Settings.fontSize*5
                }
                CText {
                    anchors.top: mainTime.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Settings.margin
                    anchors.leftMargin: Settings.margin*5

                    text: timeRoot.utc
                    font.pixelSize: Settings.fontSize*2
                }
            }

        }
    }
}
