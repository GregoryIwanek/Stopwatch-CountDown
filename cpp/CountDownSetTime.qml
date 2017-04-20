/*Subsection which contains vertical list of numbers to set time to countdown ( based on PathView)*/
import QtQuick 2.0
import QtQuick.Extras 1.4
Item {
    id: listConatiner
    width: parent.width
    height: parent.height

    //to make not focused lists invisible
    property string visibility

    CDLoopListSelector {
        id: hours
        maximumValue: 24
        name: "hours"
        anchors{
            left: parent.left
            leftMargin: parent.width/12
            verticalCenter: parent.verticalCenter
        }
    }
    CDLoopListSelector {
        id: minutes
        maximumValue: 59
        name: "minutes"
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }
    CDLoopListSelector {
        id: seconds
        maximumValue: 59
        name: "seconds"
        anchors{
            right: parent.right
            rightMargin: parent.width/12
            verticalCenter: parent.verticalCenter
        }
    }

    //BACK button
    StopWatchButton {
        id: backButton
        anchors {
            bottom: bottomCover.top
            left: listConatiner.left
            leftMargin: (listConatiner.width -(2*listConatiner.width/2.5))/6
        }

        //default visual aspects
        sWBText: "BACK"
        sWBTextColor: "white"
        sWBTextColorPressed: "black"
        sWBBorderColor: "white"
        sWBBorderColorOn:"white"
        sWBColor: "black"
        sWBcolorPressed: "#00F1FF"

        //on clicked BACK button
        onButtonClicked: {
            countdownSectionStack.push({item: countdownSectionStackRoot.componentMap["CountdownSection"]});
            watchList.interactive = true
            countdownSectionStackRoot.componentMap["CountdownSetTime"].visible = false
        }
    }

    //RESET button
    StopWatchButton {
        id: resetButton
        anchors {
            bottom: bottomCover.top
            right: listConatiner.right
            rightMargin: (listConatiner.width -(2*listConatiner.width/2.5))/6
        }

        //default visual aspects
        sWBText: "RESET"
        sWBTextColor: "white"
        sWBTextColorPressed: "black"
        sWBBorderColor: "white"
        sWBBorderColorOn:"white"
        sWBColor: "black"
        sWBcolorPressed: "#00F1FF"

        //on clicked RESET button
        onButtonClicked: {
            hours.isMoving = true
            minutes.isMoving = true
            seconds.isMoving = true
            hours.currentIndex = 0
            minutes.currentIndex = 0
            seconds.currentIndex = 0
        }
    }

    //top cover background ( green margin at top)
    Rectangle {
        id: topCover
        width: parent.width
        height: 10
        anchors.top: parent.top
        color: "#00FF00"
    }
    //bottom cover background ( green margin at bottom)
    Rectangle {
        id: bottomCover
        width: parent.width
        height: 10
        anchors.bottom: parent.bottom
        color: "#00FF00"
    }
}

