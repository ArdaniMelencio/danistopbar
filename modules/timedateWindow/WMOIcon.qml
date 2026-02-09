import QtQuick
import "../../config"

Rect {

    property string currentHour
    property string wmoString
    property string endString
    property int wMO
    property var wmoGuide:
    ({
        0: "clear",             //done
        1: "cloudy",            //done
        2: "mainly-clear",      //done
        3: "overcast",          //done
        45: "Fog",
        48: "Depositing rime fog",
        51: "Light drizzle",
        53: "Moderate drizzle",
        55: "Dense drizzle",
        56: "Light freezing drizzle",
        57: "Dense freezing drizzle",
        61: "light-rain",       //done
        63: "moderate-rain",    //done
        65: "heavy-rain",       //done
        66: "Light freezing rain",
        67: "Heavy freezing rain",
        71: "Slight snow fall",
        73: "Moderate snow fall",
        77: "Snow grains",
        80: "light-rain",
        81: "Moderate rain showers",
        82: "Violent rain showers",
        85: "Slight snow showers",
        86: "Heavy snow showers",
        95: "Thunderstorm",
        96: "Thunderstorm with light hail",
        99: "Thunderstorm with heavy hail"
    })

    onWMOChanged: wmoString = displayIcon(wMO)

    onCurrentHourChanged: {
        console.log(currentHour)
        if (parseInt(currentHour)<18) endString = "-day"
        else endString = "-night"
    }

    function displayIcon(value){ //temporarily show text instead of svg
        return wmoGuide[value] ?? "Invalid WMO: " + value
    }

    Image {
        anchors.fill: parent
        smooth: true
        fillMode: Image.PreserveAspectFit
        source: (wmoString && endString) ? Qt.resolvedUrl("../../assets/icons/weather/" + wmoString + endString + ".png") : Qt.resolvedUrl("../../assets/icons/weather/cloudy-day.png")
    }
}
