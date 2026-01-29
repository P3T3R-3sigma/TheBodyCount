import QtQuick
import Felgo

import "../"

Item {
    id: iBaseChoices

    Constants {
        id: mConstants
    }

    visible: false

    property var pFunctionOnTimeOut: function() {return}
    property var pFunctionOnTimeOutArguments: []

    property var pFunctionOnCorrectFound: function() {return}
    property var pFunctionOnCorrectFoundArguments: []
    property var pFunctionOnWrongFound: function() {return}
    property var pFunctionOnWrongFoundArguments: []

    property var pParent: parent
    property bool pInternalChoices: false
    property var pListChoices: []
    property var shadowListRemainingChoices: []
    property var pNextScene: pParent.pChoosenNext
    property var mDefaultChoice
    property var mCorrectChoice: [pListChoices[0]]
    property bool mFirstTry: true
    property bool mFirstVisit: true
    property bool mFoundCorrect: false

    BasePopUp {
        id: mTimeRunOut
        pText: mConstants.cChoiceTimeRunOutText
        pCode: mConstants.cChoiceTimeRunOutCode
        pFunction: function() {
            pFunctionOnTimeOut(...pFunctionOnTimeOutArguments)
            pParent.startFadeOut(pParent.mDefaultChoice)
            mFirstTry = false
        }
    }

    anchors.fill: pParent


    BaseTimer {
        id: mChoiceTimer
    }

    function setTimerToSilver() {
        mChoiceTimer.basicTimerColor = "#9aacb0"
    }

    function getTime() {
        return mConstants.cBaseTime + pListChoices.length * mConstants.cAdditionalTime
    }

    function getOverallTime() {
        return pListChoices.length * getTime()
    }

    function stopTimer() {
        mChoiceTimer.stopTimer()
    }
    function pauseTimer() {
        mChoiceTimer.pauseTimer()
    }
    function startTimer() {
        mChoiceTimer.startTimer()
    }
    function pause() {
        mChoiceTimer.pauseTimer()
    }
    function resume() {
        mChoiceTimer.resumeTimer()
    }
    function reset() {
        mFirstTry = true
        mFoundCorrect = false
    }
}
