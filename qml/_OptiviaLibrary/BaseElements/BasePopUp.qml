import Felgo
import QtQuick

Item {
    id: iBasePopUp
    anchors.fill: parent
    visible: false

    property string pText: ""
    property string pTextColor: "#e5e5e5"
    property var pFunction: function(){return}
    property var pListArguments: []
    property int pPopUpTime: 4000
    property string pCode: "UI60"
    property string pCloseCode: "UI69"
    property string pSoundCode: "SOUND60"

    z: 10

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {return}
    }

    Item {
        id: iItem
        width: parent.width
        height: parent.height
        BaseImage {
            id: iPopUp
            pAssetCode: pCode
            anchors.horizontalCenter: parent.horizontalCenter
            y: 262.5
            Item {
                height: parent.height-15
                width: parent.width
                visible: pText
                Text {
                    id: iText
                    anchors.centerIn: parent
                    text: pText
                    color: pTextColor
                    font.pixelSize: 32
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
        BaseHoverButton {
            id: iClose
            pAssetCode: pCloseCode
            pXYWH: [1284, 293, 65, 66]
            pFunctionOnClicked: function() {
                iTimer.stop()
                iBasePopUp.visible = false
                pFunction(...pListArguments)
            }
        }
    }


    ParallelAnimation {
        id: iParallelAnimationPopUp

        running: false
        loops: 1
        NumberAnimation {
            id: iNumberAnimationY
            target: iItem
            property: "y"
            to: -iPopUp.height
            duration: 500
        }
        NumberAnimation {
            id: iNumberAnimationOpacity
            target: iItem
            property: "opacity"
            to: 0
            duration: 500
        }
        onFinished: {
            pFunction(...pListArguments)
            visible = false
        }
    }

    Timer {
        id: iTimer
        interval: pPopUpTime
        onTriggered: {
            iParallelAnimationPopUp.start()
        }
    }

    function startPopUp() {
        iItem.y = 0
        iItem.opacity = 1
        visible = true
        iTimer.start()
        mGlobalSound.playSoundEffect(pSoundCode)
    }
}
