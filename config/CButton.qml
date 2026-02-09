import QtQuick.Controls
import QtQuick

Button {

    property color bgColor : Settings.theme.colours[2]
    property bool canChange : true

    background : Rect {
        id: bg
        color: bgColor
        anchors.fill: parent
    }
}
