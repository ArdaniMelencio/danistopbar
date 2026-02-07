import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.platform 1.1

Scope {

    property string homeDir: StandardPaths.writableLocation(StandardPaths.HomeLocation)
    property url defaultWallpaper: Qt.resolvedUrl("../assets/wallpapers/cinna.jpg")

    property url userWallpaper

    property string link: defaultWallpaper.toString().split(homeDir)[1]

    ColorQuantizer {
        id: themeColors

        source: defaultWallpaper
        depth: 5
        rescaleSize: 32
    }

    property list<color> colours: themeColors.colors

    Process {
        running : true
        command: [
            "hyprctl",
            "hyprpaper",
            "wallpaper",
            ",",
            "~"+link
        ]

        Component.onCompleted: console.log(link)
    }
}
