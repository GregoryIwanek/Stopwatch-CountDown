import QtQuick 2.0

Item {
    id: myScrollBar

    property double position
    property double pageSize
    property variant orientation : Qt.Vertical

    Rectangle {
        id:background
        anchors.fill: parent
        radius: orientation == Qt.Vertical ? (width/2) : (height/2)
        color: "grey"
        opacity: 0.5
    }
    Rectangle {
        x: 1
        y: myScrollBar.position * (myScrollBar.height - 2) +1
        width: parent.width - 2
        height: myScrollBar.pageSize * (myScrollBar.height-2)
        radius: width/2-1
        color: "white"
        opacity: 0.9
    }
}

