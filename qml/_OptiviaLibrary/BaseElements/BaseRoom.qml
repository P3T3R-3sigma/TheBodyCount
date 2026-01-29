import QtQuick
import Felgo


Item {
    id: iExploreChoice
    anchors.fill: parent

    property string pPlace: ""
    property var pListChoices: mConstants.cRoomChoices[pPlace]
    property var pListScenes: []
    property var pListVideoToStart: []
    property var pListValidChoice: []
    property var pComponentSexVideo
    property var pComponentBackgroundVideo

    z: 2

    function resetText() {
        return
    }
    function reset() {
        calculateStatus(pPlace)
    }

    function getNextScene() {
        resetText()
        for (let i=0; i < pListVideoToStart.length; i++) {
            if (pListVideoToStart[i].mStatus === mConstants.mStatusEnum.ACCESSIBLE) {
                return pListVideoToStart[i]
            }
        }
        return null
    }

    Repeater {
        model: pListChoices
        Loader {
            id: sceneLoader
            anchors.fill: parent

            sourceComponent: {
                if (pPlace === "SEX_ROOM") {
                    return pComponentSexVideo
                } else {
                    return pComponentBackgroundVideo
                }
            }
            Binding {
                target: sceneLoader.item
                property: "pGirlStatus"
                value: mConstants.cSexAvailability[pListChoices[index]["CODE"]]
                when: sceneLoader.item !== null && sceneLoader.sourceComponent === pComponentSexVideo
            }

            Component.onCompleted: {
                sceneLoader.item.pCode = pListChoices[index]["CODE"]
                mConstants.cScenes[sceneLoader.item.pCode] = sceneLoader.item
            }
        }
    }
    Component.onCompleted: {
        Qt.callLater( function() {
            pListChoices = mConstants.cRoomChoices[pPlace]["SCENES"]
            Qt.callLater( function() {
                fillChoice()
            })
        })
    }

    function fillChoice() {
        let lListScenes = mConstants.cRoomChoices[pPlace]["SCENES"]
        for (let i in lListScenes) {
            let lScene = getScene(lListScenes[i]["CODE"])
            for (let j in Object.keys(lListScenes[i])) {
                let key = Object.keys(lListScenes[i])[j]
                switch (key) {
                case "CODE": break
                case "CHOICE": lScene.mListChoices = getSceneList(lListScenes[i][key]); break
                case "DEFAULT": lScene.mDefaultChoice = getScene(lListScenes[i][key]); break
                case "DEFAULT_FUNC": lScene.mDefaultChoice = lListScenes[i][key](); break
                case "CORRECT": lScene.mChoice.mCorrectChoice = getSceneList(lListScenes[i][key]); break
                case "UNLOCKS": lScene.mListUnlocks = getSceneList(lListScenes[i][key]); break
                case "TERMINATES": lScene.mListTerminates = getSceneList(lListScenes[i][key]); break
                case "STATUS": lScene.mStatus = lListScenes[i][key]; break
                case "FUNCTION": lScene.mFunctionToCall = lListScenes[i][key]; break
                case "MILLIS_END_EARLY": lScene.pMillisBeforeEnd = lListScenes[i][key]; break
                default: console.log("ERROR - Wrong key: " + key)
                }
            }
            if (lScene.mChoice) {
                pListValidChoice.push(lScene)
            }
        }
        pListVideoToStart = getSceneList(mConstants.cRoomChoices[pPlace]["START_SCENES"])
        calculateStatus(pPlace)
    }

    function getSceneList(lList) {
        let choiceList = []
        for (let i in lList) {
            choiceList.push(getScene(lList[i]))
        }
        return choiceList
    }

    function getScene(lSceneCode) {
        if (lSceneCode === "HALL") {
            return mConstants.cRooms["HALL"]
        }
        return mConstants.cScenes[lSceneCode]
    }

    function calculateStatus(lPerson) {
        let lSniper = 0
        let lCasanova = 0
        let lJerk = 0
        let lNumVisited = 0
        for (let i in pListValidChoice) {
            if (pListValidChoice[i].pVisited) {
                lNumVisited++
                switch (pListValidChoice[i].mChoice.pStatus) {
                case "SNIPER": lSniper++; break
                case "CASANOVA": lCasanova++; break
                case "JERK": lJerk++; break
                }
            }
        }

        if (pListValidChoice.length === 0) {
            return
        }

        mConstants.pScores[pPlace]["UNREVEALED"] = 100 - (lNumVisited / pListValidChoice.length * 100)
        if (lNumVisited === 0) {
            lNumVisited = 1
        }
        mConstants.pScores[pPlace]["SNIPER"] = lSniper / pListValidChoice.length * 100
        mConstants.pScores[pPlace]["CASANOVA"] = lCasanova / pListValidChoice.length * 100
        mConstants.pScores[pPlace]["JERK"] = lJerk / pListValidChoice.length * 100
    }
}

