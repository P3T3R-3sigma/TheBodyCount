import Felgo
import QtQuick

import "../BaseElements"

Item {
    id: iNotebookStampAnimation

    property string pCode: ""
    property string pSoundCode: ""
    property var pOnFinished: function() {return}
    property int pEasingType: Easing.InOutCubic
    property int pDuration: 1000
    property var pFromXYWH: []
    property var pToXYWHR: []
    property var pTarget

    property real pAngle: 0

    anchors.fill: parent
    visible: true
    z: 2

    // onVisibleChanged: iImage.setSource(pStatus)
    // onPStatusChanged: iImage.setSource(pStatus)

    BaseImage {
        id: iImage1
        pAssetCode: pCode + "B"
        x: pFromXYWH[0]
        y: pFromXYWH[1]
        width: pFromXYWH[2]
        height: pFromXYWH[3]
        fillMode: Image.PreserveAspectCrop
        transform: Rotation { origin.x: 735; origin.y: 976; angle: pAngle}
        horizontalAlignment: Image.Left
        z: 1
    }
    BaseImage {
        id: iImage2
        pAssetCode: pCode + "S"
        x: pFromXYWH[0]
        y: pFromXYWH[1]
        width: pFromXYWH[2]
        height: pFromXYWH[3]
        opacity: 0
        fillMode: Image.PreserveAspectCrop
        transform: Rotation { origin.x: 735; origin.y: 976; angle: pAngle}
        horizontalAlignment: Image.Left
        z: 2
    }
    ParallelAnimation {
        id: iAnimation
        NumberAnimation {
            targets: [iImage1, iImage2, pTarget]
            property: "x"
            duration: pDuration
            to: pToXYWHR[0]
            easing.type: pEasingType
        }
        NumberAnimation {
            targets: [iImage1, iImage2, pTarget]
            property: "y"
            duration: pDuration
            to: pToXYWHR[1]
            easing.type: pEasingType
        }
        NumberAnimation {
            targets: [iNotebookStampAnimation, pTarget]
            property: "pAngle"
            duration: pDuration
            to: pToXYWHR[4]
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: iImage2
            property: "opacity"
            duration: pDuration
            to: 1
            easing.type: pEasingType
        }
        onFinished: pOnFinished()
    }

    Timer {
        id: iTimer
        interval: 500
        onTriggered: {
            visible = true
            iTimerAnimation.start()
            mGlobalSound.playSoundEffect(pSoundCode)
        }
    }
    Timer {
        id: iTimerAnimation
        interval: 300
        onTriggered: {
            iAnimation.start()
        }
    }

    function startAnimation() {
        iTimer.start()
    }

    function reset() {
        visible = false
        iImage1.x = pFromXYWH[0]
        iImage1.y = pFromXYWH[1]
        iImage1.width = pFromXYWH[2]
        iImage1.height = pFromXYWH[3]
        iImage1.rotation = 0
        iImage2.x = pFromXYWH[0]
        iImage2.y = pFromXYWH[1]
        iImage2.width = pFromXYWH[2]
        iImage2.height = pFromXYWH[3]
        iImage2.rotation = 0
        iImage2.opacity = 0
        pTarget.x = pFromXYWH[0]
        pTarget.y = pFromXYWH[1]
        pTarget.width = pFromXYWH[2]
        pTarget.height = pFromXYWH[3]
        pTarget.rotation = 0
    }
}
