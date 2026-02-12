pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {

    readonly property real fontSize : 10
    readonly property real curve : 10
    readonly property real margin : 5
    readonly property real topMargin : 10
    readonly property Fonts fonts: Fonts {}

    component Fonts: JsonObject {
        property string regular: "RF Rufo"
        property string time: "Fira Mono"

    }

    readonly property Themes theme : Themes{}

    property color primaryColor: theme?.colours ? theme?.colours[2] : Qt.rgba(0.3,0.02,0.2,1)
    property color sliderColor: Qt.darker(primaryColor,2)
    property color sliderBgColor: Qt.darker(primaryColor, 1.5)
    property color textColor: Qt.lighter(primaryColor,2)

}
