pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {

    readonly property FontSizes fontSize: FontSizes {}
    readonly property real curve : 10
    readonly property real margin : 5
    readonly property real topMargin : 10
    readonly property Fonts fonts: Fonts {}

    property real lightMultiplier: {
        if (primaryColor.hslLightness < 0.2) 10
        else 2
    }

    component Fonts: JsonObject {
        property string regular: "RF Rufo"
        property string time: "Fira Mono"
    }

    component FontSizes: JsonObject {
        readonly property int small: 5
        readonly property int regular: 10
        readonly property int large: 15
        readonly property int xLarge: 20
        readonly property int huge: 35
    }

    readonly property Themes theme : Themes{}

    property color primaryColor: theme?.colours ? theme?.colours[6] : Qt.rgba(0.3,0.02,0.2,1)
    property color sliderColor: Qt.darker(primaryColor,lightMultiplier)
    property color sliderBgColor: Qt.darker(primaryColor, 1.5)
    property color textColor: Qt.lighter(primaryColor,lightMultiplier)
}
