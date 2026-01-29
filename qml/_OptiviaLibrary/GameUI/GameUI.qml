import Felgo
import QtQuick

import "../Choice"
import "../BaseElements"
import "CharacterUI"
import "MenuUI"





Item {
    id: mGameUI

    anchors.fill: parent
    visible: true

    property bool lPause: false
    property bool lScore: false

    BaseImage {
        id: iPauseMask
        pAssetCode: "UI64"
        anchors.centerIn: parent

        visible: lPause || lScore
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {}
        }
        z: 8
    }

    BaseHoverButton {
        id: iScoreButton
        pAssetCode: "UI20"
        pSoundCode: "SOUND20"

        visible: !lPause && !lScore && scene.mCurrentScene !== mConstants.cScenes["Intro"] && scene.mCurrentScene !== mMainMenu
        opacity: scene.mCurrentScene.opacity
        pXYWH: [1764, 65, 78, 97]

        pFunctionOnClicked: function() {
            scene.globalPause()
            iPauseMenu.visible = false
            lPause = false
            lScore = true
            mStatusUI.visible = true
        }
    }

    PauseMenu {
        id: iPauseMenu
        z: 10
    }

    TinderChoiceStatusAnimation {
        id: iStatusChangeAnimation
        pCode: "UI107"
    }
    function startStatusAnimation(lStatus) {
        iStatusChangeAnimation.startAnimation(lStatus)
    }

    StatusUI {
        id: mStatusUI
        z: 9
    }


    function addBinaryScore(num) {
        // mStatusUI.pScore += num
    }

    function pause() {
        iPauseMenu.visible = true
        lPause = true
    }

    function resume() {
        iPauseMenu.visible = false
        lPause = false
    }
}
