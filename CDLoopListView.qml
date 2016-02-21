import QtQuick 2.5

PathView {
    id: pathView

    clip: true
    property alias pathView: pathView
    property int delegateWidth: parent.width
    property int delegateHeight: delegateWidth
    property int visibleItemCount: 12

    width: delegateWidth
    height: parent.height
    preferredHighlightBegin: (visibleItemCount/3 )/count //depend on it, determine center field for highlight
    preferredHighlightEnd: (visibleItemCount/3)/count //depend on it, determine center field for highlight

    //definition of path to move by vertical list
    path: Path {
        startX: pathView.delegateWidth / 2
        startY: -pathView.delegateHeight / 2

        PathLine {
            x: pathView.delegateWidth / 2
            y: pathView.delegateHeight * pathView.visibleItemCount
        }

        PathLine {
            x: pathView.delegateWidth / 2
            y: pathView.delegateHeight * pathView.count - pathView.delegateHeight / 2
        }
    }
}
