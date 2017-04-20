// MAIN WINDOW
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
Item {
    id:mainContainer
    width: Screen.width
    height: Screen.height

    StopWatchCode {
        id: stopWatchCodeRoot
    }

    //top cover background ( blue margin at top)
    Rectangle {
        id: topCover
        width: parent.width
        height: 10
        anchors.top: parent.top
        color: "#009EFF"
    }

    //name (text "STOPWATCH")
    StopWatchText {
        id: name
        anchors {
            right: mainContainer.right
            rightMargin: startStopButton.anchors.leftMargin
            top: lapTime.top
        }
        stopWatchText.anchors.right: stopWatchTextContainer.right
        stopWatchTextColor: "white"
        stopWatchTextString: "STOPWATCH"
        rectangleWidth: parent.width/2
        fontSize: parent.width/35
    }

    //status text (RUNNING, STOPPED, INACTIVE)
    StopWatchText {
        id: status
        anchors {
            right: mainContainer.right
            rightMargin: startStopButton.anchors.leftMargin
            top: name.bottom
        }
        stopWatchText.anchors.right: stopWatchTextContainer.right
        stopWatchTextColor: stopWatchTextString == "RUNNING" ? "#00FF00" : "red"
        stopWatchTextString: stopWatchCodeRoot.getStatus()
        rectangleWidth: parent.width/2
        fontSize: parent.width/35
    }

    //text to display lap time ( since last click on LAP button)
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
        stopWatchTextString: stopWatchCodeRoot.sWLapTimeString
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
        stopWatchTextColor: stopWatchCodeRoot.runningStopWatch == false ? "red" : "white"
        stopWatchTextString: stopWatchCodeRoot.sWCombinedTimeString
        rectangleWidth: parent.width
        fontSize: parent.width/10
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
        sWBText: stopWatchCodeRoot.runningStopWatch == false ? "START" : "STOP"
        sWBTextColor: "white"
        sWBTextColorPressed: "black"
        sWBBorderColor: "white"
        sWBBorderColorOn:"white"
        sWBColor: "black"
        sWBcolorPressed: "#00F1FF"

        //on clicked START/STOP
        onButtonClicked: if (sWBText == "START"){
                             stopWatchCodeRoot.startClicked()
                             sWBText = "STOP"; clearLapButton.sWBText = "LAP";}
                         else if (sWBText == "STOP"){
                             stopWatchCodeRoot.stopClicked()
                             sWBText = "START"; clearLapButton.sWBText = "CLEAR";}
    }

    //CLEAR/LAP button
    StopWatchButton {
        id: clearLapButton
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
                             saveStopWatchModel.saveData(combinedTime.stopWatchTextString+";"+lapTime.stopWatchTextString+";"+stopWatchCodeRoot.sWLapCount.toString())
                             combinedtimeListColumn.positionViewAtEnd()
                             stopWatchCodeRoot.lapClicked()
                         }
                         else {
                             stopWatchCodeRoot.clearClicked()
                             saveStopWatchModel.clearData()
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
            //color:"transparent"
            // rotation: 180
            z:2
            Rectangle {
                id: rectHeader
                width: (parent.width/3+parent.width/12)
                height: parent.height
                anchors.left: rect3Header.right
                border{
                    color: "#00FFBD"
                    width:1
                }
                color: "#009EFF"
                Text {
                    id: combinedTimeCheckHeader
                    text: "TOTAL TIME"
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
                    color: "#00FFBD"
                    width:1
                }
                color: "#009EFF"
                Text {
                    id: combinedTimeCheck3Header
                    text: "LAP#"
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
                    color: "#00FFBD"
                    width:1
                }
                color: "#009EFF"
                Text {
                    id: combinedTimeCheck2Header
                    text: "LAP TIME"
                    anchors.centerIn: parent
                    font.pointSize: parent.width/15
                }
            }
        }

        //ListView contains records
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
            model: myStopWatchModel.myModel
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
    }

    //bottom cover background ( blue margin at bottom)
    Rectangle {
        id: bottomCover
        width: parent.width
        height: 10
        anchors.bottom: parent.bottom
        color: "#009EFF"
    }

    //definition of delegate of ListView ( 3 rectangles with text inside)
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
}

