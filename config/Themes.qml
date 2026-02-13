import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel
import Qt.labs.platform 1.1

Scope {

    property var config : JSON.parse(File.read("config.json"))

    property bool loaded : false

    property list<string> wallpaperList

    property string homeDir: StandardPaths.writableLocation(StandardPaths.HomeLocation)
    property var currentWallpaper
    property url defaultWallpaper: currentWallpaper ? Qt.resolvedUrl("../assets/wallpapers/" + currentWallpaper) : Qt.resolvedUrl("../assets/wallpapers/1.jpg")
    property string link: ".config/quickshell/assets/wallpapers/" + currentWallpaper //used by hyprctl

    onLinkChanged: wait.running=true

    FolderListModel {
        id: wallpaperFolder
        folder: Qt.resolvedUrl("../assets/wallpapers/")
        nameFilters: ["*.jpg","*.png"]

        onStatusChanged: if(status===FolderListModel.Ready) {
                             console.log("Successfully read folder")
                             loaded = true
                             for (var i = 0; i < wallpaperFolder.count; i++ ){
                                 wallpaperList[i] = wallpaperFolder.get(i, "fileName")
                             }
                         }
    }

    ColorQuantizer {
        id: themeColors

        source: defaultWallpaper
        depth: 3
        rescaleSize: 10
    }

    function changeWallpaper(index){
        currentWallpaper = wallpaperList[index]
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
