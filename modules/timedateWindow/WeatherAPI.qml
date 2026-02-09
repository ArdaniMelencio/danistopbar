import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../config"

Rect {

    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.rightMargin: Settings.margin
    Layout.topMargin: Settings.margin
    color: Qt.alpha(Settings.theme.colours[2],0.2)

    property var ipLoc
    property var result

    property bool canCallAPI :  true

    onIpLocChanged: if (ipLoc && canCallAPI) {callWeatherAPI();canCallAPI=false}

    ColumnLayout {
        anchors.fill: parent
        uniformCellSizes: true

        Rectangle {
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "transparent"

            Rectangle {
                anchors.top:  parent.top
                anchors.right: icon.left
                implicitWidth: parent.width-(icon.width+Settings.margin*2)
                implicitHeight: icon.height
                anchors.topMargin: -Settings.margin

                color: "transparent"
                CText {
                    id: temp

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: Settings.margin
                    anchors.topMargin: result ? 0 : Settings.margin*2
                    font.pixelSize: result ? Settings.fontSize*5 : Settings.fontSize*2

                    text: result ? result.hourly.temperature_2m[23] + result.hourly_units.temperature_2m : "Couldn't connect to API"
                    Component.onCompleted: callIpAPI()
                }

                CText {
                    anchors.top: temp.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: Settings.margin

                    font.pixelSize: Settings.fontSize*1.5

                    text: result ? result.hourly.precipitation_probability[23] + result.hourly_units.precipitation_probability + " chance of rain": "..."
                }
            }



            WMOIcon {
                id: icon
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: Settings.margin


                implicitHeight: parent.height
                implicitWidth: parent.height

                border.color: Qt.alpha(Settings.theme.colours[2],0.2)
                color: "transparent"
                currentHour: currentDate.getHours()
                wMO: result ? result.hourly.weather_code[23] : 0
            }
        }

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter

            Repeater {
                model:[
                        47,
                        71,
                        119,
                        143,
                        167
                     ]


                ColumnLayout {
                    required property int modelData

                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.margins: Settings.margin

                    WMOIcon {

                        Layout.alignment: Qt.AlignCenter
                        implicitHeight: parent.height/1.5
                        implicitWidth: parent.height/1.5
                        border.color: Qt.alpha(Settings.theme.colours[2],0.2)
                        color: "transparent"
                        currentHour: currentDate.getHours()
                        wMO: result ? result.hourly.wewather_code[modelData] : 0
                    }

                    CText {
                        Layout.alignment: Qt.AlignCenter
                        font.pixelSize: Settings.fontSize
                        text: result ? result.hourly.temperature_2m[modelData] + result.hourly_units.temperature_2m: "-173°C"
                    }

                }


            }
        }
    }




    function callIpAPI(){
        var xmlReq = new XMLHttpRequest()
        xmlReq.onreadystatechange = function(){
            if (xmlReq.readyState=== XMLHttpRequest.DONE) {
                if (xmlReq.status === 200 ) {ipLoc = JSON.parse(xmlReq.responseText) }
                else console.log("Error[IP]::Status " + xmlReq.status)
            }
        }
        xmlReq.open("GET","http://ip-api.com/json/")
        xmlReq.send()
    }

    function callWeatherAPI(){
        var xmlReq = new XMLHttpRequest()
        xmlReq.onreadystatechange = function(){
            if (xmlReq.readyState === XMLHttpRequest.DONE) {
                if (xmlReq.status === 200) {
                    result = JSON.parse(xmlReq.responseText)
                }
                else if (xmlReq.status === 429) {
                    console.log("Exceeded daily API request limit")
                    apiCall.running = false
                    apiCooldown.running = true
                }
                else {
                    console.log("Error[WTR]::Status "+xmlReq.status);
                }
            }
        }
        xmlReq.open("GET","https://api.open-meteo.com/v1/forecast?latitude=" + ipLoc.lat + "&longitude=" + ipLoc.lon + "&hourly=temperature_2m,weather_code,precipitation_probability&timezone=" + (ipLoc.timezone).split('/')[0] + "%2F" + (ipLoc.timezone).split('/')[1])
        xmlReq.send()
    }

    Timer {
        id: apiCooldown
        interval: 1000 * 60 * 60 * 24
        onTriggered: {
            callWeatherAPI()
        }
    }

    Timer {
        id: apiCall
        interval: request ? 1000*60*15 : 1000*5
        repeat: true
        onTriggered: {
            callWeatherAPI()
            canCallAPI = true
        }
    }

    Timer {
        id: ipCall
        interval: 1000*30
        running: true
        repeat: true
        onTriggered: callIpAPI()
    }
}
