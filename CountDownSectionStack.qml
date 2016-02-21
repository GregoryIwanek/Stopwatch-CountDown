//sectionStack- contains two subsections: countdownSetTime and countdownSection
//from here, we navigate to those sections and switch between them via "push"
import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Window 2.0

Item {
    id:countdownSectionStackRoot

    StackView {
        id: countdownSectionStack
        anchors.fill: parent
        initialItem: CountDownSection{
        id:countdownSection}
            CountDownSetTime{
            id: countdownSetTime
            visible: false
            }
    }
    //stack's map
    property var componentMap: {
    "CountdownSection": countdownSection,
    "CountdownSetTime": countdownSetTime
    }
    property Component countdownSection: CountDownSection{}
    property Component countdownSetTime: CountDownSetTime{}
}
