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

}
