import Felgo
import QtQuick

import "../BaseElements"

Item {
    id: iNotebookAnimation
    anchors.fill: parent

    NotebookAnimationStamp {
        id: stamp1
        pFromXYWH: [710, 290, 500, 500]
        pToXYWH: [1049, 255, 134, 134]
        pCode: "UI107"
        pSoundCode: "SOUND107"
        pStatus: mConstants.meridaStatus
        pOnFinished: stamp3.startAnimation
    }
    NotebookAnimationStamp {
        id: stamp2
        pFromXYWH: [710, 290, 500, 500]
        pToXYWH: [1030, 463, 134, 134]
        pCode: "UI107"
        pSoundCode: "SOUND107"
        pStatus: mConstants.amberStatus
        pOnFinished: stamp4.startAnimation
    }
    NotebookAnimationStamp {
        id: stamp3
        pFromXYWH: [710, 290, 500, 500]
        pToXYWH: [728, 410, 134, 134]
        pCode: "UI107"
        pSoundCode: "SOUND107"
        pStatus: mConstants.lollypopStatus
        pOnFinished: stamp2.startAnimation
    }
    NotebookAnimationStamp {
        id: stamp4
        pFromXYWH: [710, 290, 500, 500]
        pToXYWH: [827, 607, 134, 134]
        pCode: "UI107"
        pSoundCode: "SOUND107"
        pStatus: mConstants.milenaStatus
        pOnFinished: function() { tear.startAnimation() }
    }

    function startAnimation() {
        stamp1.startAnimation()
    }
    function reset() {
        stamp1.reset()
        stamp2.reset()
        stamp3.reset()
        stamp4.reset()
    }
}
