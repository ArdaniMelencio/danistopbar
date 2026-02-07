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

    onHoveredChanged: {
        if (hovered && canChange) bgColor = Qt.darker(Settings.theme.colours[2],1.1)
        else if (!hovered && canChange) bgColor = Settings.theme.colours[2]
    }

    onPressedChanged: {
        if (pressed && canChange) bgColor = Qt.darker(Settings.theme.colours[2],1.3)
        else if (!pressed && canChange) bgColor = Qt.darker(Settings.theme.colours[2],1.1)
    }

}
