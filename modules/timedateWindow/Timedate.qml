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

            Rectangle {

                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "transparent"
                CText {
                    id: mainTime
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: Settings.margin
                    anchors.leftMargin: Settings.margin*5

                    text: timeRoot.localTZ
                    font.pixelSize: Settings.fontSize*5
                }
                CText {
                    anchors.top: mainTime.bottom
                    anchors.left: parent.left
                    anchors.margins: Settings.margin
                    anchors.leftMargin: Settings.margin*5

                    text: timeRoot.utc
                    font.pixelSize: Settings.fontSize*2
                }
            }

            WeatherAPI {
                Layout.fillHeight: true
                Layout.fillWidth: true
                color: "transparent"
            }

            Rect{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: Settings.margin
                Layout.columnSpan: 2
                color: Qt.alpha(Settings.theme.colours[2], 0.7)
            }
        }
    }
}
