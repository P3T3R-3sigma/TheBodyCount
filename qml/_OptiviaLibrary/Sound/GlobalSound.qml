import Felgo
import QtQuick
import QtMultimedia

import "../BaseElements"

Item {
    id: mGameUI

    anchors.fill: parent

    property var pCurrentSound: null
    property bool pEnabled: true

    property string pSource: ""

    visible: true


    BaseBackgroundMusic {
        pAssetCode: pSource
    }
    BaseSoundEffects {
        id: iSoundEffect
    }

    function setSource(lSource) {
        switch (lSource) {
        case "MENU": pSource = "MAIN"; break
        case "POOL": pSource = "POOL"; break
        case "KITCHEN": pSource = "KITCHEN"; break
        case "BASEMENT": pSource = "MAIN"; break
        case "SECOND_FLOOR": pSource = "MAIN"; break
        case "DOG_ROOM": pSource = "DOGROOM"; break
        case "PARENTS_ROOM": pSource = ""; break
        case "SEX_ROOM": pSource = ""; break
        case "LIBRARY": pSource = "LIBRARY"; break
        case "SEX": pSource = ""; break
        default: console.log("ERROR: wrong song input: " + lSource); break
        }
    }

    function playSoundEffect(lSound) {
        iSoundEffect.stop()
        iSoundEffect.pAssetCode = lSound
        iSoundEffect.play()
    }


    function pause() {
        if (pCurrentSound) {
            pEnabled = false
            pCurrentSound.pause()
        }
    }
    function resume() {
        if (pCurrentSound) {
            pEnabled = true
            pCurrentSound.resume()
        }
    }
    function stop() {
        if (pCurrentSound) {
            pCurrentSound.stop()
        }
    }

    function pauseBackgroungMusic() {
        iMainAudio.pause()
    }
    function resumeBackgroungMusic() {
        // iMainAudio.play()
    }
}
