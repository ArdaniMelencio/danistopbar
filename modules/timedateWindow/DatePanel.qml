import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../config"

Rect{
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.leftMargin: Settings.margin
    Layout.topMargin: Settings.margin
    color: Qt.alpha(Settings.theme.colours[2],0.2)


    CText {
        id: dateToday
        text: currentDate ? Qt.formatDate(currentDate, "MMMM dd, yyyy") : "January 1, 2000"
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height/2 - contentHeight
        height: Settings.fontSize*4
        font.pixelSize: Settings.fontSize*4
    }

    DayOfWeekRow {
        id: weekLayout
        anchors.top: dateToday.bottom
        anchors.left: dateToday.left
        anchors.right: dateToday.right
        anchors.leftMargin: Settings.margin
        anchors.rightMargin: Settings.margin

        locale: Qt.locale("en_US")

        delegate: ColumnLayout{

            required property string shortName
            required property int day
            required property int index

            uniformCellSizes: true

            CText {
                anchors.horizontalCenter: parent.horizontalCenter
                text: shortName
                font.pixelSize: Settings.fontSize*1.5
                color: if (currentDate){
                    if (shortName === Qt.formatDate(currentDate, "ddd")) Qt.darker(Settings.theme.colours[22],1.5)
                    else Settings.theme.colours[22]
                }
            }
            CText {

                anchors.horizontalCenter: parent.horizontalCenter
                text: (today.getDate()-1) + index
                color: if (currentDate){
                    if (shortName === Qt.formatDate(currentDate, "ddd")) Qt.darker(Settings.theme.colours[22],1.5)
                    else Settings.theme.colours[22]
                }
            }

        }
    }
}
