import QtQuick.Controls
import "../../config"


CButton {
    id: appSearch

    property bool isOpened : false

    CText {
        anchors.centerIn: parent
        text: "APPS"
        font.pixelSize: Settings.fontSize*1.4
    }

    onClicked: {
        if (!isOpened)
            console.log (isOpened)
    }

}
