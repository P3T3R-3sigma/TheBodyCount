import QtQuick
import Felgo

import "../"
import "../BaseElements"

BaseChoice {
    id: iTinderChoices

    anchors.fill: parent

    TinderChoiceGraphic {
        id: iTinderChoiceGraphics
    }

    BasePopUp {
        id: mIdeaRunOut
        pText: mConstants.cTinderIdeaRunOutText
        pCode: mConstants.cTinderIdeaRunOutCode
        pFunction: callOnClicked
        pListArguments: [nullItem, false]
    }
    BasePopUp {
        id: mTimeRunOut
        pText: mConstants.cChoiceTimeRunOutText
        pCode: mConstants.cChoiceTimeRunOutCode
        pFunction: function() {
            pParent.startFadeOut(pParent.mDefaultChoice)
            mFirstTry = false
        }
    }


    Item {
        id: nullItem

        property int mStatus: mConstants.mStatusEnum.NULL
    }



    onVisibleChanged: {
        if (visible) {
            shadowListRemainingChoices = [...pListChoices]
            getNextPossibleScene()
            iTinderChoiceGraphics.visible = true
            mGlobalSound.playSoundEffect(mConstants.cTinderBackgroundSoundCode)
        }
    }

    function setGraphicToSilver() {
        setTimerToSilver()
        iTinderChoiceGraphics.pState = "SILVER"
    }

    function callOnClicked(lClicked, lBool) {
        if (lClicked.mStatus === mConstants.mStatusEnum.NULL) {
            iTinderChoiceGraphics.visible = true
            shadowListRemainingChoices = [...pListChoices]
            mFirstTry = false
            setStatus("CASANOVA")
            lBool = false
        }

        if (lBool) {
            if (isCorrectChoice(lClicked)) {
                mFirstTry = false
                pFunctionOnCorrectFound(...pFunctionOnCorrectFoundArguments)
                mFoundCorrect = true
            } else if (!mFoundCorrect) {
                pFunctionOnWrongFound(...pFunctionOnWrongFoundArguments)
                mFirstTry = false
            }
            pParent.startFadeOut(lClicked)
        }  else {
            getNextPossibleScene()
        }
    }

    function isCorrectChoice(lClicked) {
        for (let i in mCorrectChoice) {
            if (lClicked === mCorrectChoice[i]) {
                return true
            }
        }
        return false
    }

    function callOnTimeOut(lBool = true) {
        if (lBool) {
            mTimeRunOut.startPopUp()
            setStatus("JERK")
        } else {
            pFunctionOnTimeOut(...pFunctionOnTimeOutArguments)
            pParent.startFadeOut(pParent.mDefaultChoice)
            mFirstTry = false
            setStatus("CASANOVA")
        }
    }


    function getNextPossibleScene() {
        if (shadowListRemainingChoices.length === 0) {
            mIdeaRunOut.startPopUp()
            return
        }

        var idx = Math.floor(Math.random()*shadowListRemainingChoices.length);
        iTinderChoiceGraphics.pNextScene = shadowListRemainingChoices[idx]
        shadowListRemainingChoices.splice(idx, 1)
    }
}
