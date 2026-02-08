import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Io
import "../../config"

Rectangle {

    property var ipLoc
    property var result

    onIpLocChanged: if (ipLoc) callWeatherAPI()

    RowLayout {
        id: topRef

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.rightMargin: Settings.margin*5

        CText {
            id: temp
            font.pixelSize: result ? Settings.fontSize*5 : Settings.fontSize*2

            text: result ? result.hourly.temperature_2m[23] + result.hourly_units.temperature_2m : "Couldn't connect to API"

            Component.onCompleted: callIpAPI()
        }


        WMOIcon {
            implicitHeight: parent.width/2
            implicitWidth: parent.width/2
            color: "transparent"
            isDay: result.is_day ? true : false
            wMO: result ? result.hourly.weather_code[23] : 0
        }

    }

    CText {
        anchors.top: topRef.bottom
        anchors.right: parent.right
        anchors.rightMargin: Settings.margin*5
        text: result ? result.hourly.precipitation_probability[23] + result.hourly_units.precipitation_probability + " chance of rain": "..."
    }

    function callIpAPI(){
        var xmlReq = new XMLHttpRequest()
        xmlReq.onreadystatechange = function(){
            if (xmlReq.readyState=== XMLHttpRequest.DONE) {
                if (xmlReq.status === 200 ) {ipLoc = JSON.parse(xmlReq.responseText) }
                else console.log("Error: " + xmlReq.status)
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
                } else {
                    console.log("Error: " + xmlReq.status);
                }
            }
        }
        xmlReq.open("GET","https://api.open-meteo.com/v1/forecast?latitude=" + ipLoc.lat + "&longitude=" + ipLoc.lon + "&hourly=temperature_2m,weather_code,precipitation_probability&current=is_day&timezone=" + (ipLoc.timezone).split('/')[0] + "%2F" + (ipLoc.timezone).split('/')[1] + "&forecast_days=1")
        xmlReq.send()
    }

    Timer {
        id: apiCall
        interval: 1000*60*5
        running:true
        repeat: true
        onTriggered: {
            callWeatherAPI()
        }
    }
}
