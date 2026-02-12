import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel
import Qt.labs.platform 1.1

Scope {

    property bool loaded : false

    property list<string> wallpaperList

    FolderListModel {
        id: wallpaperFolder
        folder: Qt.resolvedUrl("../assets/wallpapers/")
        nameFilters: ["*.jpg","*.png"]

        onStatusChanged: if(status===FolderListModel.Ready) {
                             //console.log (wallpaperFolder.get(0, "fileName") + " = " + wallpaperList[0])
                             loaded = true
                             for (var i = 0; i < wallpaperFolder.count; i++ ){
                                 wallpaperList[i] = wallpaperFolder.get(i, "fileName")
                                 console.log(wallpaperFolder.get(i, "fileName"))
                             }
                         }
    }

    property var currentWallpaper : wallpaperList[0]

    property string homeDir: StandardPaths.writableLocation(StandardPaths.HomeLocation)
    property url defaultWallpaper: Qt.resolvedUrl("../assets/wallpapers/" + currentWallpaper)

    property url userWallpaper

    property string link: ".config/quickshell/assets/wallpapers/" + currentWallpaper //used by hyprctl

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


    }
    Timer {
        id: wait
        interval: 50
        onTriggered: changeWallpaper.running=true
    }
}
