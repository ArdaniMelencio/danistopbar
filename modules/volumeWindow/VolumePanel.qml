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
    anchors.left: true
    margins.left: volRef.x - (volRef.width/2)
    implicitWidth: screen.width/3
    implicitHeight: screen.height/3+(2*Settings.curve)

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
    }

    onPanelYChanged: {
        if (panelY === -height) {
            popup.WlrLayershell.layer = WlrLayer.Background
        }
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
}
