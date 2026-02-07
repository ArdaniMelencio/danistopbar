import Quickshell
import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import "topbar"
import "../config"

Scope {
    id: mainBar

    property color primary : Qt.rgba(0.04,0.02,0.04,0.8)

    Variants {
        model: Quickshell.screens

        PanelWindow {

            required property var modelData
            id: topBars
            screen: modelData

            anchors.top: true
            anchors.left: true
            anchors.right: true

            implicitHeight:40
            color: "transparent"

            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 1000
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: [0.2, 0, 0, 1, 1, 1]
                }
            }

            Rectangle {
                id: ref
                anchors.fill: parent
                color: primary

                Applications {
                    id: apps
                    anchors.left: ref.left
                    anchors.top: ref.top
                    anchors.bottom: ref.bottom
                    anchors.margins: Settings.margin

                    implicitWidth: parent.width/30

                }

                Workspaces {
                    id: workspace
                    anchors.left: apps.right
                    anchors.top: ref.top
                    anchors.bottom: ref.bottom
                    anchors.margins: Settings.margin

                    implicitWidth: parent.width/8
                }

                Performance {
                    id: perf
                    anchors.right: time.left
                    anchors.top: ref.top
                    anchors.bottom: ref.bottom
                    anchors.margins: Settings.margin
                }

                Time {
                    id: time
                    anchors.centerIn: ref

                }

                Volume {
                    id: vol
                    anchors.left: time.right
                    anchors.top: ref.top
                    anchors.bottom: ref.bottom
                    anchors.margins: Settings.margin
                }
            }
        }
    }
}
