import QtQuick
import Felgo

import "../Choice"
import "../"

TinderChoice {
    id: iTheBodyCountChoice

    pFunctionOnCorrectFound: setStatus
    pFunctionOnCorrectFoundArguments: [pGraphic]

    pFunctionOnWrongFound: setStatus
    pFunctionOnWrongFoundArguments: ["JERK"]

    property string pPerson: ""
    property string pStatus: "JERK"
    property string pGraphic: "SNIPER"

    Component.onCompleted: {
        Qt.callLater(function() {
            var num = parseInt(pParent.pCode.substring(1));
            if (num < 19) {
                pPerson = "KITCHEN"
            } else if (num < 39) {
                pPerson = "DOG_ROOM"
            } else if (num < 69) {
                pPerson = "POOL"
            } else {
                pPerson = "LIBRARY"
            }
        })
    }

    function setStatus(lStatus) {
        if (lStatus === "SNIPER") {
            mFirstTry = true
        } else {
            pGraphic = "CASANOVA"
            setGraphicToSilver()
        }

        pStatus = lStatus
        mGameUI.startStatusAnimation(lStatus)
        calculateStatus(pPerson)
        lStatus = setGirlStatus(lStatus)
        switch (pPerson) {
        case "KITCHEN": mConstants.meridaStatus = lStatus; break
        case "DOG_ROOM": mConstants.amberStatus = lStatus; break
        case "POOL": mConstants.lollypopStatus = lStatus; break
        case "LIBRARY": mConstants.milenaStatus = lStatus; break
        }
    }

    function setGirlStatus(lStatus) {
        if (lStatus === "JERK") {
            return "JERK"
        } else if (mConstants.pScores[pPlace]["SNIPER"] > mConstants.pScores[pPlace]["CASANOVA"]) {
            return "SNIPER"
        } else {
            return "CASANOVA"
        }
    }

    function reset() {
        mFirstTry = true
        mFoundCorrect = false
        pStatus = "JERK"
        pGraphic = "SNIPER"
    }
}
