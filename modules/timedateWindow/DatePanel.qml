import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../../config"

Rect{
    id: datePanelRect
    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.leftMargin: Settings.margin
    Layout.topMargin: Settings.margin
    color: Qt.alpha(Settings.primaryColor,0.2)

    ColumnLayout {

        anchors.fill: parent

        CText {
            id: dateToday

            Layout.alignment: Qt.AlignCenter
            Layout.margins: Settings.margin
            text: currentDate ? Qt.formatDate(currentDate, "MMMM dd, yyyy") : "January 1, 2000"

            font.pixelSize : Settings.fontSize.huge * (parent.height/150)
        }

        DayOfWeekRow {
            id: weekLayout
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignCenter
            Layout.margins: Settings.margin
            Layout.topMargin: 0
            height: parent.height/2 - Settings.margin

            locale: Qt.locale("en_US")

            delegate: ColumnLayout{

                required property string shortName
                required property int day
                required property int index
                spacing: 0

                CText {
                    Layout.alignment: Qt.AlignHCenter
                    text: shortName
                    font.pixelSize: Settings.fontSize.large  * (datePanelRect.height/150)
                    color: if (currentDate){
                        if (shortName === Qt.formatDate(currentDate, "ddd")) Qt.darker(Settings.textColor,1.5)
                        else Settings.textColor
                    }
                }
                CText {
                    Layout.alignment: Qt.AlignHCenter
                    height: weekLayout.height/2
                    font.pixelSize: Settings.fontSize.regular  * (datePanelRect.height/150)
                    text: (currentDate.getDate() - currentDate.getDay()) + index
                    color: if (currentDate){
                        if (shortName === Qt.formatDate(currentDate, "ddd")) Qt.darker(Settings.textColor,1.5)
                        else Settings.textColor
                    }
                }

            }
        }
    }

}
