import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "../../config"

PanelWindow{
    id: popup
    anchors.top: parent.bottom
    implicitWidth: screen.width/3

    property string dayOfWeek: (timeRoot.localTZ).split(" ")[0]
    property string completeTime: timeRoot.localTZ.split('< ')[1]


    property date today : new Date()
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
                    text: timeRoot.localTZ ? (timeRoot.localTZ).split(".")[1].split(" <")[0] : "January 1, 2000"
                    anchors.top: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: Settings.margin+4
                    height: Settings.fontSize*4
                    font.pixelSize: Settings.fontSize*4
                }

                DayOfWeekRow {
                    id: weekLayout
                    anchors.top: dateToday.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.leftMargin: Settings.margin
                    anchors.rightMargin: Settings.margin
                    implicitHeight: Settings.fontSize*1.5

                    locale: Qt.locale("en_US")

                    delegate: ColumnLayout{

                        required property string shortName
                        required property int day
                        required property int index

                        uniformCellSizes: true

                        CText {
                            text: shortName
                            font.pixelSize: Settings.fontSize*1.5
                            color: if (timeRoot.localTZ){
                                if (shortName === dayOfWeek) Qt.darker(Settings.theme.colours[22],1.5)
                                else Settings.theme.colours[22]
                            }
                        }
                        CText {
                            text: (today.getDate()-1) + index
                            color: if (timeRoot.localTZ){
                                if (shortName === dayOfWeek) Qt.darker(Settings.theme.colours[22],1.5)
                                else Settings.theme.colours[22]
                            }
                        }

                    }
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

                    text: completeTime
                    font.pixelSize: Settings.fontSize*7
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
