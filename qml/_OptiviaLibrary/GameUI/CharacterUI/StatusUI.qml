import Felgo
import QtQuick
import Qt5Compat.GraphicalEffects

import "../../BaseElements"


Item {
    id: iBinaryScoreUI

    anchors.fill: parent
    visible: false

    property string pGirlStatus
    property int pGirlIndex: 0

    Component.onCompleted: {
        giveGirlStatus(mConstants.meridaStatus)
    }
    onVisibleChanged: {
        iBackGround.setSource(pGirlStatus)
    }


    BaseImage {
        id: iBackGround
        pAssetCode: "UI00"
        pXYWH: [0, 0, 1920, 1080]
        z: -1
    }

    GirlStatusUI {
        id: iGirl1
        pCode: "UI01"
        pIndex: 0
        x: 960
        y: 189
        pText: ["MERIDA", "SuperGlue"]
        pStatus: mConstants.meridaStatus
    }
    GirlStatusUI {
        id: iGirl2
        pCode: "UI02"
        pIndex: 1
        x: 1109
        y: 189
        pText: ["AMBER", "BGF"]
        pStatus: mConstants.amberStatus
    }
    GirlStatusUI {
        id: iGirl3
        pCode: "UI03"
        pIndex: 2
        x: 1258
        y: 189
        pText: ["LOLLYPOP", "The Bitch"]
        pStatus: mConstants.lollypopStatus
    }
    GirlStatusUI {
        id: iGirl4
        pCode: "UI04"
        pIndex: 3
        x: 1407
        y: 189
        pText: ["MILENA", "The Smart One"]
        pStatus: mConstants.milenaStatus
    }

    onPGirlStatusChanged: {
        iBackGround.setSource(pGirlStatus)
    }


    BaseHoverButton {
        id: iResumeButton
        pAssetCode: "UI06"

        pXYWH: [903, 837, 116, 115]
        pButtonEnabled: true

        opacity: 0.75
        pFunctionOnEntered: function() { opacity = 1 }
        pFunctionOnExited: function() { opacity = 0.75 }

        pFunctionOnClicked: function() {
            if (scene.mCurrentScene !== null) {
                scene.mCurrentScene.globalResume()
                iBinaryScoreUI.visible = false
                lScore = false
            }
        }
    }

    function giveGirlStatus(lStatus) {
        pGirlStatus = lStatus
    }
}
