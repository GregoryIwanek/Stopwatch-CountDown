import QtQuick 2.5
import QtQuick.Window 2.2

CDLoopListView {
    id: numberSelector

    delegateWidth: parent.width/4
    delegateHeight: delegateWidth
    anchors.verticalCenter: parent.verticalCenter
    highlight: Rectangle { width: delegateWidth; height: delegateHeight; color: "orange"}

    property string name:""
    property int highlightedRect//index
    property int chosenTime: 0
    property int value: 0
    property int minimumValue: 0
    property int maximumValue: 99
    property bool updateValueWhileMoving: true
    property bool isMoving: false

    // for internal usage
    property int numberCount: 0
    property bool initialized: false

    function sendNumber() {
        if(name == "hours"){countdownSection.countDownCodeRoot.hours = chosenTime}
        else if (name == "minutes"){countdownSection.countDownCodeRoot.minutes = chosenTime}
        else if (name == "seconds"){countdownSection.countDownCodeRoot.seconds = chosenTime}
    }

    model: numberCount

    onCurrentIndexChanged: {
        if (initialized && updateValueWhileMoving) {value = minimumValue + currentIndex}
        if (countdownSection.countDownCodeRoot.cDIsActive === false){chosenTime = currentIndex; sendNumber()}
    }

    onMovementStarted: {
        if (name == "hours"){countdownSetTime.visibility = "hours"}
        else if (name == "minutes"){countdownSetTime.visibility = "minutes"}
        else if (name  == "seconds"){countdownSetTime.visibility = "seconds"}
        isMoving = true
    }

    onMovementEnded: {
        value = minimumValue + currentIndex
        isMoving = false
    }

    Component.onCompleted: {
        numberCount = maximumValue - minimumValue + 1

        if (value < minimumValue)
            value = minimumValue
        else if (value > maximumValue)
            value = maximumValue

        positionViewAtIndex(value - minimumValue, PathView.SnapPosition)
        initialized = true
    }

    onMinimumValueChanged: {
        if (initialized) {
            var oldValue = value
            numberCount = maximumValue - minimumValue + 1

            if (oldValue < minimumValue)
                oldValue = minimumValue

            value = oldValue
            positionViewAtIndex(oldValue - minimumValue, PathView.SnapPosition)
        }
    }

    onMaximumValueChanged: {
        if (initialized) {
            var oldValue = value
            numberCount = maximumValue - minimumValue + 1

            if (oldValue > maximumValue)
                oldValue = maximumValue

            value = oldValue
            positionViewAtIndex(oldValue - minimumValue, PathView.SnapPosition)
        }
    }

    delegate:
        CDLoopListViewDelegate {      
        id: delegate
        visible: delegate.isVisible
        indexOf: index
        Text {
            id: delegateText
            anchors.fill: parent
            text: numberSelector.minimumValue + index
            font.pixelSize: 8 * Screen.logicalPixelDensity
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }

        MouseArea {
            id: delegatMouseArea
            anchors.fill: parent

            onClicked: {
                numberSelector.currentIndex = index
            }
        }
    }

}

