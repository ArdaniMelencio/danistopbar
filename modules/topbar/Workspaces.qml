import Quickshell.Hyprland
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick
import "../../config"

Rect {
    id: root

    RowLayout {
        id: rowRef
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.margins: Settings.margin
        anchors.left: parent.left
        anchors.leftMargin: Settings.margin/2

        Repeater {
            model: Hyprland.workspaces

            Button {
                required property var modelData

                implicitWidth: root.width/10-(Settings.margin)
                implicitHeight: root.height/2

                background: Rect{
                    color: if (modelData.active) Qt.darker(Settings.theme.colours[0],1.2)
                        else if (!modelData.active) Settings.theme.colours[2]
                }

                CText { text : (modelData.id); anchors.centerIn: parent; font.pixelSize: Settings.fontSize*1.2}

                onClicked: Hyprland.dispatch("workspace "+modelData.id)
            }
        }
    }

}
