import Felgo
import QtQuick
import QtMultimedia


BaseImage {
    id: baseHoverButton

    property var pFunctionOnClicked: function() {return}
    property var pClickArgument: []
    property var pFunctionOnEntered: function() {return}
    property var pEnterArgument: []
    property var pFunctionOnExited: function() {return}
    property var pExitArgument: []
    property string pState: "Static"
    property string pSoundCode: "SOUND00"
    property bool pButtonEnabled: scene.mCurrentScene.pEnable
    property bool pBumpEnabled: true
    property bool pMemory: false

    onPStateChanged: setSource(pState)

    z: 2

    onVisibleChanged: {
        if (!pMemory) {
            pState = "Static"
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        enabled: pButtonEnabled
        onEnabledChanged: {
            if (pMemory) {
                return
            }
            if (containsMouse) {
                pState = "Hover"
            } else {
                pState = "Static"
            }
        }

        onEntered: {
            pState = "Hover"
            pFunctionOnEntered(...pEnterArgument)
        }
        onExited: {
            if (pButtonEnabled) {
                pState = "Static"
            }
            pFunctionOnExited(...pExitArgument)
        }
        onPressed: {
            mGlobalSound.playSoundEffect(pSoundCode)
            if (pBumpEnabled) {
                reverseBumpAnimation.start()
            } else {
                pFunctionOnClicked(...pClickArgument)
            }
        }
    }

    ParallelAnimation {
        id: reverseBumpAnimation
        property bool pGoInvard: true
        NumberAnimation {
            target: baseHoverButton
            property: "x"
            duration: 150
            to: reverseBumpAnimation.pGoInvard ? pXYWH[0] + pXYWH[2] * 0.1 : pXYWH[0]
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: baseHoverButton
            property: "y"
            duration: 150
            to: reverseBumpAnimation.pGoInvard ? pXYWH[1] + pXYWH[3] * 0.1 : pXYWH[1]
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: baseHoverButton
            property: "width"
            duration: 150
            to: reverseBumpAnimation.pGoInvard ? pXYWH[2]*0.8 : pXYWH[2]
            easing.type: Easing.InOutQuad
        }
        NumberAnimation {
            target: baseHoverButton
            property: "height"
            duration: 150
            to: reverseBumpAnimation.pGoInvard ? pXYWH[3]*0.8 : pXYWH[3]
            easing.type: Easing.InOutQuad
        }
        onFinished: {
            if (pGoInvard) {
                pGoInvard = false
                reverseBumpAnimation.start()
            } else {
                pGoInvard = true
                pFunctionOnClicked(...pClickArgument)
            }
        }
    }
}
