import QtQuick.Controls
import Quickshell.Hyprland
import "../../config"


CButton {
    id: appSearch

    property bool isOpened : false

    CText {
        anchors.centerIn: parent
        text: "APPS"
        font.pixelSize: Settings.fontSize*1.4
    }

    onClicked: {
        if (!isOpened) Hyprland.dispatch("exec wofi --show drun")
    }

}
