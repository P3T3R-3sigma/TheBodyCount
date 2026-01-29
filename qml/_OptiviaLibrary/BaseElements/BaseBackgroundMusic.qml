import Felgo
import QtQuick
import QtMultimedia

import "."

Item {
    property string pAssetCode: ""
    property real pSound: 1
    property int pLoops: 1


    BackgroundMusic {
        id: iAudio
        loops: pLoops
        volume: pSound
    }

    BaseLoader {
        id: iLoader
        pExtractFrom: "qrc:/audio_assets.qrc"
        pLoadAsset: iAudio
    }

    function setSource(lSource) {
        iLoader.setSource(lSource)
    }

    function getPos() {
        return iAudio.position
    }

    function setVideoPosition(pos) {
        iAudio.position = pos
    }
    function play() {
        iAudio.play()
    }
    function stop() {
        iAudio.stop()
    }
    function pause() {
        iAudio.pause()
    }
}
