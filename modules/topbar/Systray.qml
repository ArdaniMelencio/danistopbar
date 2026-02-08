import "../../config"

CButton {
    property int i: 0
    onClicked: if (i < Settings.theme.wallpaperList.length-1) {
        i = i+1
    }
    else i = 0

    onIChanged: function(){
        Settings.theme.currentWallpaper = Settings.theme.wallpaperList[i]
    }
}
