import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "../../config"

Rectangle {

    property var result

    CText {
        id: temp
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: Settings.margin
        anchors.rightMargin: Settings.margin*5
        font.pixelSize: Settings.fontSize*5

        text: result ? result.hourly.temperature_2m[23] + result.hourly_units.temperature_2m : "0.0C"

        Component.onCompleted: callAPI()
    }

    CText {
        anchors.top: temp.bottom
        anchors.right: parent.right
        anchors.margins: Settings.margin
        anchors.rightMargin: Settings.margin*5
        text: result ? result.hourly.precipitation_probability[23] + result.hourly_units.precipitation_probability : "0%"
    }

    function callAPI(){
        var xmlReq = new XMLHttpRequest()
        xmlReq.onreadystatechange = function(){
            if (xmlReq.readyState === XMLHttpRequest.DONE) {
                if (xmlReq.status === 200) {
                    result = JSON.parse(xmlReq.responseText)
                    console.log(xmlReq.responseText)
                } else {
                    console.log("Error: " + xmlReq.status);
                }
            }
        }
        xmlReq.open("GET","https://api.open-meteo.com/v1/forecast?latitude=13.4088&longitude=122.5615&hourly=temperature_2m,weather_code,precipitation_probability&timezone=Asia%2FSingapore&forecast_days=1")
        xmlReq.send()
    }

    Timer {
        id: apiCall
        interval: 1000*60*5
        running:true
        repeat: true
        onTriggered: {
            callAPI()
        }
    }
}
