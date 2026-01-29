import QtQuick
import Felgo
import QtQuick.LocalStorage


Item {

    id: iChoiceManager

    property var pListAllChoices: []
    property var pSaveFile: { "numOfSaves": 0 }

    function getChoiceFromName(name) {
        if (name === null) {
            return null
        }

        for (var i = 0; i < pListAllChoices.length; i++) {
            if (pListAllChoices[i].objectName === name) {
                return pListAllChoices[i];
            }
        }
        return null;
    }

    function addChoice(lChoice) {
        if (lChoice.objectName) {
            pListAllChoices.push(lChoice)
        } else {
            // console.log("ERROR: No objectName for Choice with title: " + lChoice.mTitle)
        }
    }

    function printChoices() {
        for (let i=0; i<pListAllChoices.length; i++) {
            console.log(pListAllChoices[i])
        }
    }
    function printCompletion() {
        let numScene = 0
        let numSexScene = 0
        for (let i=0; i<pListAllChoices.length; i++) {
            if (pListAllChoices[i].pVisited) {
                if (pListAllChoices[i].mDisplay === mCHc.mDisplayEnum.SEX) {
                    numSexScene ++
                }
                numScene++
            }
        }
        console.log(numScene + " out of " + pListAllChoices.length + " scenes visited.")
        console.log(numSexScene + " out of " + 7 + " Sex scenes visited.")
    }

    function seenAllSex() {
        let numSexScene = 0
        for (let i=0; i< mConstants.pSexSceneVisited.length; i++) {
            if (mConstants.pSexSceneVisited[i]) {
                numSexScene ++
            }
        }
        return numSexScene === 6
    }

    function printSave(obj = pSaveFile, indent = "") {
        for (var key in obj) {
            if (obj.hasOwnProperty(key)) {
                if (typeof obj[key] === "object" && obj[key] !== null) {
                    console.log(indent + key + ": {")
                    printSave(obj[key], indent + "  ")
                    console.log(indent + "}")
                } else {
                    console.log(indent + key + " : " + obj[key])
                }
            }
        }
    }

    function save(num = null) {
        if (num === null) {
            pSaveFile["numOfSaves"]++
            num = pSaveFile["numOfSaves"]
        }
        let saveNum = "save"+num
        pSaveFile[saveNum] = {}
        for (let i=0; i<pListAllChoices.length; i++) {
            pSaveFile[saveNum][pListAllChoices[i].objectName] = pListAllChoices[i].mStatus
        }

        pSaveFile[saveNum]["RoomIntro"] = mConstants.pPlayedIntro
        pSaveFile[saveNum]["SexScene"] = mConstants.pSexSceneVisited
        if (scene.mCurrentSceene === null) {
            pSaveFile[saveNum]["currentScene"] = null
        } else {
            pSaveFile[saveNum]["currentScene"] = scene.mCurrentSceene.objectName
        }

        pSaveFile[saveNum]["currentTime"] = new Date().toISOString()
        pSaveFile = pSaveFile
        // printSave()
        saveGame()
    }
    function load(num) {
        if (num < 0 || num > pSaveFile["numOfSaves"]) {
            console.log("ERROR: No save found with name: save" + num)
            return
        }

        let saveNum = "save"+num
        let loadFile =  pSaveFile[saveNum]
        for (let i=0; i<pListAllChoices.length; i++) {
            pListAllChoices[i].mStatus = loadFile[pListAllChoices[i].objectName]
        }
        mConstants.pPlayedIntro = pSaveFile[saveNum]["RoomIntro"]
        scene.mCurrentSceene.globalResume()
        scene.mCurrentSceene.startFadeOut(getChoiceFromName(loadFile["currentScene"]))
    }

    function saveGame() {
        mSaveStorage.setValue("SAVE_FILE", pSaveFile)
    }

    function loadSaveFile() {
        let tempSave = mSaveStorage.getValue("SAVE_FILE")
        if (tempSave === undefined) {
        } else {
            pSaveFile = tempSave
        }
    }
    function findLatestSave() {
        let latest = -1
        if (pSaveFile["numOfSaves"] === 0) {
            return latest
        }

        for (let i=1; i <= pSaveFile["numOfSaves"]; i++) {
            if (latest === -1) {
                latest = i
            } else if (pSaveFile[("save"+latest)]["currentTime"] < pSaveFile[("save"+i)]["currentTime"]) {
                latest = i
            }
        }
        return latest
    }

    function resetProgress() {
        scene.mCurrentScene.startFadeOut(mConstants.cScenes["Intro"])
        mConstants.pSexSceneVisited = [false, false, false, false, false, false, false]

        for (let i=0; i<pListAllChoices.length; i++) {
            pListAllChoices[i].reset()
        }
        mConstants.meridaStatus = "JERK"
        mConstants.milenaStatus = "JERK"
        mConstants.amberStatus = "JERK"
        mConstants.lollypopStatus = "JERK"

        mBaseGame.resetGame()
    }

    function isSaved() {
        return pSaveFile["numOfSaves"] > 0
    }

    function setVisitedSexScenes() {

        let result = mConstants.pSexSceneVisited
        for (let index = 1; index <= pSaveFile["numOfSaves"]; index++) {
            let boolList = pSaveFile[("save"+index)]["SexScene"]
            for (let i = 0; i < 7; i++) {
                if (boolList[i]) {
                    result[i] = true
                }
            }
        }
        mConstants.pSexSceneVisited = result
    }
}
