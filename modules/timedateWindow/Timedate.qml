import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../config"

PanelWindow{
    id: popup
    anchors.top: ref.bottom
    implicitWidth: screen.width/3

    property real panelY : -height

    exclusiveZone: 0
    focusable: true

    color: "transparent"
    Behavior on panelY {
        NumberAnimation {
            duration:300
            easing.type: Easing.BezierSpline
            easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
        }
    }

    DropShadow {
        radius: 3
        samples: 5
        color: "black"

        source: shapeRef
        anchors.fill: parent

        //WlrLayershell.layer: WlrLayer.Bottom
    }

    onPanelYChanged: {
        if (panelY === -height) popup.WlrLayershell.layer = WlrLayer.Background
        else  {
            popup.WlrLayershell.layer = WlrLayer.Overlay
        }
    }

    Shape {
        id: shapeRef
        height: parent.height
        width: parent.width
        layer.samples: 4
        layer.enabled: true
        //y: panelY
        ShapePath {
            id: path

            fillColor: mainBar.primary
            strokeWidth: 0
            startX: 0; startY: -1

            property real shapeCurve: Settings.curve * (popup.height/(popup.height-panelY))

            PathArc { x: Settings.curve; y: (popup.height+panelY)>(Settings.curve*2) ? path.shapeCurve : 0
                radiusX: path.shapeCurve; radiusY: Settings.curve
            }
            PathLine { x: Settings.curve; y: (height+panelY)-(Settings.curve+Settings.margin)}
            PathArc { x: Settings.curve*2; y: (height+panelY)-Settings.margin
                radiusX: Settings.curve; radiusY: Settings.curve
                direction: PathArc.Counterclockwise
            }
            PathLine { x: width-Settings.curve*2; y: (height+panelY)-Settings.margin}
            PathArc { x: width-Settings.curve; y: (height+panelY)-(Settings.curve+Settings.margin)
                radiusX: Settings.curve; radiusY: Settings.curve
                direction: PathArc.Counterclockwise
            }
            PathLine { x: width-Settings.curve; y: (popup.height+panelY)>(Settings.curve*2) ? path.shapeCurve : 0}
            PathArc { x: width; y: 0
                radiusX: path.shapeCurve; radiusY: Settings.curve
            }
        }
    }

    Rect {
        id: ext
        color: 'transparent'
        implicitHeight: parent.height
        implicitWidth: parent.width-(2*Settings.curve)
        anchors.horizontalCenter: shapeRef.horizontalCenter
        topRightRadius: 0
        topLeftRadius: 0

        y : panelY

        GridLayout {
            anchors.fill: parent
            columns: 2
            rows: 2

            uniformCellHeights: true
            uniformCellWidths: true


            DatePanel { }

            WeatherAPI { }

            Rect{
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.margins: Settings.margin
                Layout.bottomMargin: Settings.margin*2
                Layout.topMargin: 0
                Layout.columnSpan: 2

                CText {
                    id: mainTime
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Settings.margin
                    anchors.leftMargin: Settings.margin*5

                    font.family: Settings.fonts.time

                    text: Qt.formatDateTime(currentDate, "hh:mm:ss t")
                    font.pixelSize: Settings.fontSize.huge*(parent.height/100)
                }
                CText {
                    anchors.top: mainTime.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.margins: Settings.margin
                    anchors.leftMargin: Settings.margin*5
                    font.family: Settings.fonts.time

                    text: currentDate.toUTCString().split(" ")[3] + " UTC"
                    font.pixelSize: Settings.fontSize.large
                }
            }

        }
    }
}
