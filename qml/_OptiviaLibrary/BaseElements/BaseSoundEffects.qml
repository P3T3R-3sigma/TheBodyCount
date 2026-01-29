import Felgo
import QtQuick
import QtMultimedia

import "."

Item {
    property string pAssetCode: ""
    property real pSound: 1
    property int pLoops: 1

    SoundEffect {
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
    function getSource() {
        return iAudio.source.toString()
    }

    function getPos() {
        return iAudio.position
    }

    function play() {
        iAudio.play()
    }
    function stop() {
        iAudio.stop()
    }
}
