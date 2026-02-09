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

    ColumnLayout {

        anchors.fill: parent

        CText {
            id: dateToday

            Layout.alignment: Qt.AlignCenter
            Layout.margins: Settings.margin
            Layout.topMargin: 0

            text: currentDate ? Qt.formatDate(currentDate, "MMMM dd, yyyy") : "January 1, 2000"

            font.pixelSize: Settings.fontSize*4
        }

        DayOfWeekRow {
            id: weekLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            Layout.margins: Settings.margin
            Layout.topMargin: 0
            height: parent.height/2

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

}
