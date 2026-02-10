import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Controls
import "../../config"
import "../timedateWindow"

CButton  {
    id: timeRoot
    implicitWidth: ref.width/20
    implicitHeight: ref.height-10

    property bool isOpened: false

    property date currentDate : new Date()

    Timedate {
        id: popup
        implicitHeight: screen.height/3
    }

    CText {
        id : clock

        text: Qt.formatTime(currentDate, "hh:mm")
        anchors.centerIn: parent
    }

    onHoveredChanged:  showPanel()

    function showPanel(){
        if (!isOpened){
            isOpened = true
            popup.panelY = 0
        }
        else if (isOpened) {
            isOpened = false
            popup.panelY = -popup.height
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {currentDate = new Date()}
    }
}
