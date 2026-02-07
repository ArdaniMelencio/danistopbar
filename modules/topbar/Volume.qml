import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../config"

CButton {
    implicitWidth: parent.width/6

    RowLayout {
        anchors.fill: parent
        anchors.margins: Settings.margin

        Slider {
            implicitWidth: parent.width/2 - (Settings.margin*2)
        }

        Slider {
            implicitWidth: parent.width/2 - (Settings.margin*2)
        }

    }
}
