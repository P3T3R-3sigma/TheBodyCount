import QtQuick
import Felgo
import QtMultimedia

import "../BaseElements"

Item {
    id: iOptiviaSexVideoTimerUI
    anchors.horizontalCenter: parent.horizontalCenter
    visible: !pShowPreview

    property string partPosSource
    property  var pListTimerPositions: []
    property bool pEnable: true

    height: 10
    width: pTimerWidth

    Repeater {
        model: pListTimerPositions.length-1
        Item {
            x: pListTimerPositions[index]/iSexVideo.duration * pTimerWidth
            y: 0
            width: (pListTimerPositions[index+1] - pListTimerPositions[index])/iSexVideo.duration * pTimerWidth
            height: 10

            z: 2
            BaseImage {
                id: partPos
                pAssetCode: mConstants.cSexDotCode
                anchors.verticalCenter: parent.verticalCenter
                x: -width/2
                width: 7
            }
        }
    }

    Rectangle {
        id: topTimer
        anchors.verticalCenter: parent.verticalCenter
        z: 1
        width: iSexVideo.position/iSexVideo.duration*pTimerWidth
        height: 12
        radius: height/2
        color: "#92a16b"
    }
    BaseImage {
        id: bottomTimer
        pAssetCode: mConstants.cSexBlackBarCode
        anchors.verticalCenter: parent.verticalCenter
        z: 0
        width: pTimerWidth
        MouseArea {
            anchors.fill: parent
            enabled: pEnable
            onEnabledChanged: {
                if (!enabled) {
                    setVideoPosition(pListTimerPositions[pCurrentSceneIdx])
                }
            }

            onPressed: function(mouse) {
                pauseVideo()
                pCurrentSceneIdx = getIndex(mouse.x/pTimerWidth*iSexVideo.duration)
                setVideoPosition(mouse.x/pTimerWidth*iSexVideo.duration)
            }
            onReleased: {
                mOptiviaSexVideoThumbnail.setThumbnaiImage(-1)
                playVideo()
            }
            onPositionChanged: function(mouse) {
                if (enabled) {
                    pCurrentSceneIdx = getIndex(mouse.x/pTimerWidth*iSexVideo.duration)
                    setVideoPosition(mouse.x/pTimerWidth*iSexVideo.duration)
                    mOptiviaSexVideoThumbnail.setThumbnaiImage(iSexVideo.position)
                }
            }
        }
    }
    BaseImage {
        id: currentPos
        pAssetCode: mConstants.cSexKnobCode
        anchors.verticalCenter: parent.verticalCenter
        z: 3
        x: iSexVideo.position/iSexVideo.duration*pTimerWidth - width/2
    }

    function getIndex(pos) {
        pos = Math.min(Math.max(0, pos), pListPositions[pListPositions.length-1])
        for (let i in pListPositions) {
            if (pListPositions[i] > pos) {
                return i-1
            }
        }
        return pListPositions.length-1
    }
}
