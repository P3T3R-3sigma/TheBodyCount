import Felgo
import QtQuick

import "../BaseElements"

Item {
    id: iNotebookStampAnimation

    property string pCode: ""
    property string pSoundCode: ""
    property string pStatus: "JERK"
    property var pOnFinished: function() {return}
    property int pEasingType: Easing.InCirc
    property int pDuration: 500
    property var pFromXYWH: []
    property var pToXYWH: []

    anchors.fill: parent
    visible: false
    z: 3

    onVisibleChanged: iImage.setSource(pStatus)
    onPStatusChanged: iImage.setSource(pStatus)

    BaseImage {
        id: iImage
        pAssetCode: pCode
        x: pFromXYWH[0]
        y: pFromXYWH[1]
        width: pFromXYWH[2]
        height: pFromXYWH[3]
        fillMode: Image.PreserveAspectCrop
        horizontalAlignment: Image.Left
    }
    ParallelAnimation {
        id: iAnimation
        NumberAnimation {
            target: iImage
            property: "x"
            duration: pDuration
            to: pToXYWH[0]
            easing.type: pEasingType
        }
        NumberAnimation {
            target: iImage
            property: "y"
            duration: pDuration
            to: pToXYWH[1]
            easing.type: pEasingType
        }
        NumberAnimation {
            target: iImage
            property: "width"
            duration: pDuration
            to: pToXYWH[2]
            easing.type: pEasingType
        }
        NumberAnimation {
            target: iImage
            property: "height"
            duration: pDuration
            to: pToXYWH[3]
            easing.type: pEasingType
        }
        onFinished: pOnFinished()
    }

    Timer {
        id: iTimer
        interval: 500
        onTriggered: {
            visible = true
            iAnimation.start()
            mGlobalSound.playSoundEffect(pSoundCode)
        }
    }

    function startAnimation() {
        if (!visible) {
            iTimer.start()
        }
    }

    function reset() {
        visible = false
        iImage.x = pFromXYWH[0]
        iImage.y = pFromXYWH[1]
        iImage.width = pFromXYWH[2]
        iImage.height = pFromXYWH[3]
    }
}
