//main view of countdownSection-> contains inside layout and countDownCode ( which is used to make calculations)
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0

Item {
    id:mainContainer
    width: Screen.width
    height: Screen.height

    property alias countDownCodeRoot: countDownCodeRoot

    CountDownCode {
        id: countDownCodeRoot
    }

    //top cover background ( blue margin at top)
    Rectangle {
        id: topCover
        width: parent.width
        height: 10
        anchors.top: parent.top
        color: "#00FF00"
    }

    //name (text "COUNTDOWN")
    StopWatchText {
        id: name
        anchors {
            right: mainContainer.right
            rightMargin: startStopButton.anchors.leftMargin
            top: lapTime.top
        }
        stopWatchText.anchors.right: stopWatchTextContainer.right
        stopWatchTextColor: "white"
        stopWatchTextString: "COUNTDOWN"
        rectangleWidth: parent.width/2
        fontSize: parent.width/35
    }

    //status text (RUNNING, STOPPED, SET TIME)
    StopWatchText {
        id: status
        anchors {
            right: mainContainer.right
            rightMargin: startStopButton.anchors.leftMargin
            top: name.bottom
        }
        stopWatchText.anchors.right: stopWatchTextContainer.right
        stopWatchTextColor: stopWatchTextString == "RUNNING" ? "#00FF00" : "red"
        stopWatchTextString: countDownCodeRoot.getStatus()
        rectangleWidth: parent.width/2
        fontSize: parent.width/35
    }

    //text to display lap time
    StopWatchText {
        id: lapTime
        anchors {
            left: mainContainer.left
            top: topCover.bottom
            topMargin: 10
            leftMargin: startStopButton.anchors.leftMargin
        }
        stopWatchText.anchors.left: stopWatchTextContainer.left
        stopWatchTextColor: "aquamarine"
        stopWatchTextString: countDownCodeRoot.cDLapTimeString
        rectangleWidth: parent.width/2
        fontSize: parent.width/20
    }

    //text to display combined time
    StopWatchText {
        id: combinedTime
        anchors {
            top: lapTime.bottom
            topMargin: 0
            left: mainContainer.left
            leftMargin: startStopButton.anchors.leftMargin
        }
        stopWatchText.anchors.left: stopWatchTextContainer.left
        stopWatchTextColor: countDownCodeRoot.runningCountDown == false ? "red" : "white"
        stopWatchTextString: countDownCodeRoot.cDCombinedTimeString
        rectangleWidth: parent.width
        fontSize: parent.width/10

        MouseArea {
            id: setCountdownTime
            anchors.fill: parent
            onClicked: {countdownSectionStack.push({item: countdownSectionStackRoot.componentMap["CountdownSetTime"]});
                watchList.interactive = false
                countdownSectionStackRoot.componentMap["CountdownSetTime"].visible = true
            }
        }
    }

    //START/STOP button
    StopWatchButton {
        id: startStopButton
        anchors {
            top: combinedTime.bottom
            topMargin: 15
            left: parent.left
            leftMargin: (mainContainer.width -(2*mainContainer.width/2.5))/6
        }

        //default visual aspects
        sWBText: countDownCodeRoot.runningCountDown == false ? "START" : "STOP"
        sWBTextColor: "white"
        sWBTextColorPressed: "black"
        sWBBorderColor: "white"
        sWBBorderColorOn:"white"
        sWBColor: "black"
        sWBcolorPressed: "#00F1FF"

        //on clicked START/STOP
        onButtonClicked: if (sWBText == "START" && countDownCodeRoot.timeToCountDown != 0 ){
                             countDownCodeRoot.startClicked()
                             sWBText = "STOP"; clearlapButton.sWBText = "LAP";}
                         else if (sWBText == "STOP"){
                             countDownCodeRoot.stopClicked()
                             sWBText = "START"; clearlapButton.sWBText = "CLEAR";}
    }

    //CLEAR/LAP button
    StopWatchButton {
        id: clearlapButton
        anchors {
            top: combinedTime.bottom
            topMargin: 15
            right: parent.right
            rightMargin: (mainContainer.width -(2*mainContainer.width/2.5))/6
        }
        //default visual aspects
        sWBText: startStopButton.sWBText == "START" ? "CLEAR" : "LAP"
        sWBTextColor: "white"
        sWBTextColorPressed: "black"
        sWBBorderColor: "white"
        sWBBorderColorOn: "white"
        sWBColor: "black"
        sWBcolorPressed: "#00F1FF"

        //on click CLEAR/LAP button
        onButtonClicked: if (sWBText == "LAP"){
                             saveCountDownModel.saveData(combinedTime.stopWatchTextString+";"+lapTime.stopWatchTextString+";"+countDownCodeRoot.cDLapCount.toString())
                             combinedtimeListColumn.positionViewAtEnd()
                             countDownCodeRoot.lapClicked()
                         }
                         else {
                             countDownCodeRoot.clearClicked()
                             saveCountDownModel.clearData()
                         }
    }

    //ListView container ( to give it possibility to "anchors.fill: parent)
    Item {
        id: timeList
        width: parent.width - (mainContainer.width -(2*mainContainer.width/2.5))/3
        anchors {
            top: startStopButton.bottom
            topMargin: 10
            horizontalCenter: parent.horizontalCenter
            bottom: bottomCover.top
        }

        //header
        Item {
            id: combinedTimeCheckCOntainer1
            width: parent.width
            height: 60
            z:2
            Rectangle {
                id: rectHeader
                width: (parent.width/3+parent.width/12)
                height: parent.height
                anchors.left: rect3Header.right
                border{
                    color: "#003B15"
                    width:1
                }
                color: "#00FF00"
                Text {
                    id: combinedTimeCheckHeader
                    text: "TIME LEFT"
                    anchors.centerIn: parent
                    font.pointSize: parent.width/15
                }
            }

            Rectangle {
                id: rect3Header
                width: parent.width/6
                height: parent.height
                anchors.left: parent.left
                border{
                    color: "#003B15"
                    width:1
                }
                color: "#00FF00"
                Text {
                    id: combinedTimeCheck3Header
                    text: "#"
                    anchors.centerIn: parent
                    font.pointSize: parent.width/6
                }
            }

            Rectangle {
                id: rect2Header
                width: (parent.width/3+parent.width/12)
                height: parent.height
                anchors.right: parent.right
                border{
                    color: "#003B15"
                    width:1
                }
                color: "#00FF00"

                Text {
                    id: combinedTimeCheck2Header
                    text: "CHECK TIME"
                    anchors.centerIn: parent
                    font.pointSize: parent.width/15
                }
            }
        }

        //ListView, displays records
        ListView {
            id: combinedtimeListColumn
            width: parent.width
            anchors {
                top: combinedTimeCheckCOntainer1.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
            spacing: 5
            model: myCountDownModel.myModel
            delegate: delegate

            MyScrollBar {
                id:verticalMyScrollBar
                width: 10
                height: parent.height
                anchors.right: parent.right
                opacity:0.5
                orientation: Qt.Vertical
                position: combinedtimeListColumn.visibleArea.yPosition
                pageSize: combinedtimeListColumn.visibleArea.heightRatio}
        }

        MyScrollBar {
            id: myScrollBar1
            x: 605
            y: 29
        }
    }

    //bottom cover background ( blue margin at bottom)
    Rectangle {
        id: bottomCover
        width: parent.width
        height: 10
        anchors.bottom: parent.bottom
        color: "#00FF00"
    }

    //definition of delegate of ListView ( 3 items with text inside)
    Component{
        id: delegate
        Item {
            id: combinedTimeCheckCOntainer
            width: parent.width
            height: 60

            Item {
                id: rect1
                width: parent.width/3+parent.width/12
                height: parent.height
                anchors.left: rect3.right
                Text {
                    id: combinedTimeCheck
                    text: modelData.totalTime
                    anchors.centerIn: parent
                    font.pointSize: parent.width/15
                    color:"white"
                }
            }

            Item {
                id: rect2
                width: parent.width/3+parent.width/12
                height: parent.height
                anchors.right: parent.right
                Text {
                    id: combinedTimeCheck2
                    text: modelData.lapTime
                    anchors.centerIn: parent
                    font.pointSize: parent.width/15
                    color:"white"
                }
            }

            Item {
                id: rect3
                width: parent.width/6
                height: parent.height
                anchors.left: parent.left
                Text {
                    id: combinedTimeCheck3
                    text: modelData.index
                    anchors.centerIn: parent
                    font.pointSize: parent.width/6
                    color:"aquamarine"
                }
            }
        }
    }

    //    //ListView's listModel
    //    ListModel {
    //        id: tableViewModelCombined
    //    }
}

