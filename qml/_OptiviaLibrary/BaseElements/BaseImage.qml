import Felgo
import QtQuick
import QtMultimedia


AppImage {
    id: baseImage

    property var pXYWH: [0, 0, 0, 0]
    property string pAssetCode

    x: pXYWH[0]
    y: pXYWH[1]

    BaseLoader {
        id: iLoader
    }

    // Rectangle {
    //     anchors.fill: parent
    //     color: "blue"
    //     opacity: 0.2
    // }

    onPAssetCodeChanged: iLoader.pAssetCode = pAssetCode

    function setSource(lSource) {
        iLoader.setSource(lSource)
    }
    function getSource() {
        return source.toString()
    }
    function startVideo() {
        return
    }
    function pause() {
        return
    }
    function resume() {
        return
    }
}
