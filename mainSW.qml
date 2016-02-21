// MAIN WINDOW /// contains stopWatchSection and CoundDownSection
//from here, we navigate to those sections
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
ApplicationWindow {
    id: myMainWindow
    visible: true
    width: Screen.width
    height: Screen.height

    //list containing StopWatchSection and CountdownSectionStack (stack contains other two subsections: SetTime and Countdown)
    ListView {
        id: watchList
        anchors.fill: parent
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        spacing: 100
        boundsBehavior: Flickable.StopAtBounds
        delegate: Component {
            id: delegateCountDownSection
            Item {
                id: rect
                width: myMainWindow.width
                height: myMainWindow.height
                Loader { id: pageLoader
                    width: parent.width
                    height: parent.height
                    source: title
                    property alias externComponent: pageLoader.item
                }
            }
        }
        model: ListModel {
            id: modelList
            ListElement {
                title: "qrc:/StopWatchSection.qml"
            }
            ListElement {
                title: "qrc:/CountDownSectionStack.qml"
            }
        }
    }
}

