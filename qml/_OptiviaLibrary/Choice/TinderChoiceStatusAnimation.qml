import QtQuick
import Felgo

import "../"
import "../BaseElements"

Item {
    id: iTinderChoicesStatusAnimation

    property string pCode: ""
    property string pSoundCode: ""
    property var pOnFinished: function() {return}

    width: iImage.implicitWidth
    height: iImage.implicitHeight
    x: 1650
    y: 65
    visible: false
    Item {
        anchors.fill: parent

        BaseImage {
            id: iImage
            pAssetCode: pCode
            width: 100
            height: 100
            fillMode: Image.PreserveAspectCrop
            horizontalAlignment: Image.Left
        }
        ParallelAnimation {
            id: iAnimation
            NumberAnimation {
                target: iImage
                property: "width"
                duration: 1000
                to: 0
                easing.type: Easing.InCirc
                onFinished: pOnFinished()
            }
            NumberAnimation {
                target: iImage
                property: "height"
                duration: 1000
                to: 0
                easing.type: Easing.InCirc
            }
            NumberAnimation {
                target: iImage
                property: "x"
                duration: 1000
                to: 150
                easing.type: Easing.InCirc
            }
            NumberAnimation {
                target: iImage
                property: "y"
                duration: 1000
                to: 62
                easing.type: Easing.InCirc
            }
            onFinished: {
                reset()
                pOnFinished()
            }

        }

    }

    Timer {
        id: iTimer
        interval: 1000
        onTriggered: {
            iAnimation.start()
            mGlobalSound.playSoundEffect(pSoundCode)
        }
    }

    function startAnimation(lStatus) {
        if (!visible) {
            iImage.setSource(lStatus)
            visible = true
            iTimer.start()
        }
    }

    function reset() {
        visible = false
        iImage.width = 100
        iImage.height = 100
        iImage.x = 0
        iImage.y = 0
    }
}
