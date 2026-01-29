import Felgo
import QtQuick
import Qt5Compat.GraphicalEffects

import "../BaseElements"

Item {
    id: iNotebookAnimation

    property string pCode: ""
    property string pSoundCode: ""
    property var pOnFinished: function() {return}

    width: iImage.implicitWidth
    height: iImage.implicitHeight
    visible: false
    Item {
        anchors.fill: parent

        BaseImage {
            id: iImage
            pAssetCode: pCode
            width: 0
            fillMode: Image.PreserveAspectCrop
            horizontalAlignment: Image.Left
        }

        NumberAnimation {
            id: iAnimation
            target: iImage
            property: "width"
            duration: 1050
            to: iImage.implicitWidth
            easing.type: Easing.InCirc
            onFinished: iTimer.start()
        }
    }

    Timer {
        id: iTimer
        interval: 500
        onTriggered: {
            pOnFinished()
        }
    }

    function startAnimation() {
        if (!visible) {
            visible = true
            iAnimation.start()
            mGlobalSound.playSoundEffect(pSoundCode)
        } else {
            iCloseButton.visible = true
        }
    }

    function reset() {
        visible = false
        iImage.width = 0
    }
}
