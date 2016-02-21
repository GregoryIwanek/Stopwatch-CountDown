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
    preferredHighlightBegin: (visibleItemCount/3 )/count
    preferredHighlightEnd: (visibleItemCount/3)/count


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
