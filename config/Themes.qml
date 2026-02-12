import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.platform 1.1

Scope {

    property list<string> wallpaperList:
        [
            "spyfamily.png",
            "toori.jpg",
            "saka.jpg",
            "cinna.jpg",
            "sakamoto.jpg",
            "chisa.jpg",
            "chisa2.jpg",
        ]

    property var currentWallpaper : wallpaperList[0]

    property string homeDir: StandardPaths.writableLocation(StandardPaths.HomeLocation)
    property url defaultWallpaper: Qt.resolvedUrl("../assets/wallpapers/" + currentWallpaper)

    property url userWallpaper

    property string link: defaultWallpaper.toString().split(homeDir)[1]

    onLinkChanged: wait.running=true

    ColorQuantizer {
        id: themeColors

        source: defaultWallpaper
        depth: 5
        rescaleSize: 32
    }

    property list<color> colours: themeColors.colors

    Process {
        id: changeWallpaper
        command: [
            "hyprctl",
            "hyprpaper",
            "wallpaper",
            ",",
            "~"+link
        ]

        Component.onCompleted: console.log(link)
    }
    Timer {
        id: wait
        interval: 50
        onTriggered: changeWallpaper.running=true
    }
}
