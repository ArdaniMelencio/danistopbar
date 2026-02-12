import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Qt5Compat.GraphicalEffects
import "topbar"
import "../config"

Scope {
    id: mainBar

    property color primary : Qt.rgba(0.02,0.02,0.02, 0.7)

    Variants {
        model: Quickshell.screens

        PanelWindow {

            required property var modelData
            id: topBars
            screen: modelData


            anchors {
                left: true
                top: true
                right: true
            }

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

                color: primary
                anchors.fill: parent

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

                Media {
                    id: music
                    anchors.right: tray.left
                    anchors.top: ref.top
                    anchors.bottom: ref.bottom
                    anchors.margins: Settings.margin
                    implicitWidth: parent.width/8
                }

                Systray {
                    id: tray
                    anchors.right: ref.right
                    anchors.top: ref.top
                    anchors.bottom: ref.bottom
                    anchors.margins: Settings.margin
                    implicitWidth: parent.width/30
                }
            }
        }
    }
}
