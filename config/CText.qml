import QtQuick

Text {
    font.pixelSize: Settings?.fontSize ? Settings.fontSize * 2 : 10
    font.family: Settings?.fonts.regular
    font.bold: true
    color: Settings?.theme ? Settings?.theme.colours[22] : "white"
}
