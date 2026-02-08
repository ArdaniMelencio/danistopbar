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

    property string utc
    property string localTZ
    property bool isOpened: false

    Timedate {
        id: popup
        implicitHeight: screen.height/3
    }

    CText {
        id : clock

        text: localTZ.split(':')[0]+":"+localTZ.split(':')[1]
        anchors.centerIn: parent
    }

    onHoveredChanged:  if (hovered)showPanel(true)


    onClicked: showPanel(!isOpened)

    function showPanel(willOpen){
        if (willOpen){
            isOpened = true
            popup.panelY = 0
        }
        else if (!willOpen) {
            isOpened = false
            popup.panelY = -popup.height
        }
    }


    Process {
        id: localTZproc

        running: true
        command: ["sh",
                "-c",
                "date '+%T %Z'"]
        stdout: StdioCollector {
            onStreamFinished: timeRoot.localTZ = this.text
        }
    }

    Process {
        id: utcTZproc

        running: true
        command: ["sh",
                "-c",
                "TZ='UTC' date '+%H:%M:%S %Z'"]
        stdout: StdioCollector {
            onStreamFinished: timeRoot.utc = this.text
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {localTZproc.running = true; utcTZproc.running = true}
    }
}
