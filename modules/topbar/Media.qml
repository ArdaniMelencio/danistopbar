import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import "../../config"

Rect {

    id: mediaRect

    readonly property string assetUrl: "../../assets/icons/media/"
    readonly property string playIcon: "playing.png"
    readonly property string pauseIcon: "paused.png"
    readonly property string nextIcon: "next.png"
    readonly property string previousIcon: "previous.png"

    RowLayout {

        anchors.fill: parent

        uniformCellSizes: true
        Rect {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: Settings.margin
            color: Qt.darker(Settings.theme.colours[2],1.2)
            CText {anchors.fill: parent; text: "UI Placeholder"}
        }
        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: Settings.margin

            Button {
                Layout.fillHeight: true
                Layout.fillWidth: true

                background:
                Image {
                    source: Qt.resolvedUrl(assetUrl+previousIcon)
                    smooth: true
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit

                    Rectangle {
                        id: prev
                        anchors.fill: parent
                        color : Settings.textColor
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: parent
                        }
                    }
                }
            }
            Button {
                Layout.fillHeight: true
                Layout.fillWidth: true

                background:
                Image {
                    source: Qt.resolvedUrl(assetUrl+playIcon)
                    smooth: true
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit

                    Rectangle {
                        id: pausePlay
                        anchors.fill: parent
                        color : Settings.textColor
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: parent
                        }
                    }
                }
            }
            Button {
                Layout.fillHeight: true
                Layout.fillWidth: true

                background:
                Image {
                    source: Qt.resolvedUrl(assetUrl+nextIcon)
                    smooth: true
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit

                    Rectangle {
                        id: next
                        anchors.fill: parent
                        color : Settings.textColor
                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: parent
                        }
                    }
                }
            }
        }
    }

}
