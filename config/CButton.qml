import QtQuick.Controls
import QtQuick

Button {

    property color bgColor : Settings?.theme ? Qt.darker(Settings.primaryColor, 1.1) : "white"
    property bool canChange : true

    background : Rect {
        id: bg
        anchors.fill: parent
    }
}
