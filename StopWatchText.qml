//customized text to display
import QtQuick 2.0
import QtQuick.Window 2.0
Item {
    id: stopWatchTextContainer
    width: rectangleWidth
    height: stopWatchText.contentHeight*1.1

    property alias  stopWatchText: stopWatchText
    property alias  stopWatchTextContainer: stopWatchTextContainer
    property string stopWatchTextString
    property string stopWatchTextColor
    property double fontSize
    property double rectangleWidth

    Text {
        id: stopWatchText
        font.pointSize: fontSize
        text: stopWatchTextString
        color: stopWatchTextColor
    }
}


