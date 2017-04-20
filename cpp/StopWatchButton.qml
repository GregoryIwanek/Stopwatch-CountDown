//costomized button
import QtQuick 2.0
import QtQuick.Window 2.0
Item {
    property string sWBText //text to print
    property string sWBTextColor //default text color
    property string sWBTextColorPressed //color of text while pressed
    property string sWBBorderColor //default border color
    property string sWBBorderColorOn //on entered
    property string sWBColor  //black
    property string sWBcolorPressed //aquamarine

    signal buttonClicked

    id: stopWatchButtonRoot
    width: parent.width/2.5
    height: parent.height/10

    Rectangle {
        id: stopWatchButtonRect
        anchors.fill: parent
        border.color: sWBBorderColor
        border.width: 3
        color: stopWatchButtonMouseArea.pressed ? sWBcolorPressed : sWBColor

        Text {
            id: stopWatchButtonText
            font.pointSize: stopWatchButtonRoot.width/12
            anchors.centerIn: parent
            text: sWBText
            color: stopWatchButtonMouseArea.pressed ? sWBTextColorPressed : sWBTextColor
        }

        MouseArea {
            id:stopWatchButtonMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered: stopWatchButtonRect.border.color = sWBBorderColorOn
            onExited: stopWatchButtonRect.border.color = sWBBorderColor
            onClicked: buttonClicked()
        }
    }
}

