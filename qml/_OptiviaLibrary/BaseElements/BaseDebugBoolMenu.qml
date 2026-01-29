import Felgo
import QtQuick


Row {
    property string pText: ""
    property bool pBool
    property var pFunction
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 10
    Text {
        id: iLoopBinary
        text: pText
        font.pixelSize: 20
        color: "white"
    }

    Rectangle {
        width: 30; height: 30
        color: pBool ? "green" : "black"
        border.color: "lightgray"
        border.width: 3

        MouseArea {
            anchors.fill: parent

            onClicked: pFunction()
        }
    }
}

