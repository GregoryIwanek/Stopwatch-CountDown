import QtQuick 2.5

Item {
    width: PathView.view.delegateWidth
    height: PathView.view.delegateHeight

    property string colorRect: "#00FF00"
    property bool isVisible: {
        if (indexOf == numberSelector.currentIndex){true}
        else if (numberSelector.isMoving == true){true}
        else if (numberSelector.isMoving == false && countdownSetTime.visibility === numberSelector.name){true}
        else {false}
    }

    property int indexOf

    Rectangle {
        id: rect
        width: parent.width
        height: parent.height
        color: colorRect
        opacity: 0.65
        border{
            width: 5
            color: "black"
        }
    }
}
