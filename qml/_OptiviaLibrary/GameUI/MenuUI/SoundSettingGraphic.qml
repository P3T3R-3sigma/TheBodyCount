import Felgo
import QtQuick

import "../../BaseElements"

Item {
    id: iSoundSetting

    property real volume: 1
    property string pText: ""
    property var pOnSoundDrag

    visible: true
    width: 1920
    height: 122

    Text {
        id: iButtonText
        x: 598
        font.pixelSize: 40
        color: "#FFFFF0"
        font.family: "Segoe UI"
        font.weight: 600

        text: pText
        bottomPadding: 10
    }

    Rectangle {
        id: baseBar
        anchors.verticalCenter: iButtonText.verticalCenter
        x: 946.53

        width: 377
        height:  20
        radius: height/2
        color: "white"
        z: -1
        MouseArea {
            anchors.fill: parent
            onPressed: function(mouse) {
                volume = mouse.x/width
            }
            onMouseXChanged: function(mouse) {
                volume = mouse.x/width
                if (volume < 0) {
                    volume = 0
                } else if (volume > 1) {
                    volume = 1
                }
            }
        }
        Rectangle {
            id: volumeBar
            anchors.verticalCenter: parent.verticalCenter

            x: 2
            width: (parent.width-4) * volume
            height:  parent.height-4
            radius: height/2
            color: "#7eb18d"
            BaseImage {
                id: blob
                pAssetCode: "UI82"
                anchors.verticalCenter: parent.verticalCenter
                x: parent.width - width/2
            }
        }
    }
}
