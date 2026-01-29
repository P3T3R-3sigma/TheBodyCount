import QtQuick
import Felgo
import QtMultimedia
import QtQuick.Window
import Qt5Compat.GraphicalEffects

import "../BaseElements"

Item {
    id: iOptiviaSexVideo

    anchors.fill: parent

    property string pAssetCode: "NULL"
    property string pMusicCode: pAssetCode + "MUSIC"
    property int pCurrentSceneIdx: 0
    property int pNotebookIndex: -1
    property var pListPositions: []
    property var pListAvailable: []
    property var pListSources: []
    property var pListTextPositions: mConstants.sexPositionText[pAssetCode]
    property string personStatus
    property real pVideoVolume: 1


    BaseSourceContainer {
        id: mJumpSourceContainer
        pAssetCode: "screenshot" + parent.pAssetCode
        onPListSourcesChanged: fillList()
    }
    onPersonStatusChanged: fillList()

    Component.onCompleted: mNotebook.closeNotebook.connect(closeEarly)

    VideoOutput {
        id: iVideoOutput
        anchors.fill: parent
    }

    OptiviaSexVideoThumbnail {
        id: mOptiviaSexVideoThumbnail
    }

    MediaPlayer {
        id: iSexVideo

        videoOutput: iVideoOutput
        audioOutput: AudioOutput {
            volume: pVideoVolume
        }

        onSourceChanged: {
            if (visible) {
                startVideo()
            }
        }
        onPositionChanged: {
            if (!pListAvailable[pCurrentSceneIdx] && !sexUI.pPopUp && visible) {
                iBlockRect.visible = true
                sexUI.pPopUp = true
                iTimerAmination.start()
                scene.mCurrentScene.pEnable = false
                sexUI.disableTimerBar()
            } else if (iSexVideo.position > pListPositions[pCurrentSceneIdx+1]) {
                pCurrentSceneIdx++
            }
            if (iSexVideo.position > iSexVideo.duration-6000 && !iTimer.running) {
                if (pNotebookIndex > 0) {
                    mNotebook.startAnimation(pAssetCode)
                }
                iTimer.start()
            }
        }
    }
    BaseLoader {id: iLoader; pLoadAsset: iSexVideo; pAssetCode: pAssetCode; pExtractFrom: "qrc:/video_assets.qrc" }
    Timer {
        id: iTimer
        interval: 5000
        onTriggered: iOpacityAnimation.start()
    }

    NumberAnimation {
        id: iOpacityAnimation
        target: iOptiviaSexVideo
        property: "opacity"
        to: 0
        duration: 250
        onFinished: {
            startFadeOut()
            skipVideo()
            iOptiviaSexVideo.opacity = 1
        }
    }

    BaseBackgroundMusic {
        id: iSoundEffects
        pAssetCode: pMusicCode
        pSound: mSettingManager.mMusicSex
    }


    Item {
        id: iBlockRect
        anchors.fill: parent
        visible: false
        z: 10
        property int posDelta: width/2
        BaseImage {
            x: iBlockRect.posDelta
            y: 0
            pAssetCode: mConstants.cSexBlockLeftCode
        }
        BaseImage {
            x: -iBlockRect.posDelta
            y: 0
            pAssetCode: mConstants.cSexBlockRightCode
        }
        BaseImage {
            x: 0
            y: -iBlockRect.posDelta
            pAssetCode: mConstants.cSexBlockTextCode
        }

        NumberAnimation {
            id: iTimerAmination
            target: iBlockRect;
            property: "posDelta";
            to: 0;
            duration: 2000
            onFinished: {
                if (iTimerAmination.to === 0) {
                    to = iBlockRect.width/2
                    iBlockTimer.start()
                } else {
                    to = 0
                    iBlockRect.visible = false
                    sexUI.enableTimerBar()
                }
            }
            easing.type: Easing.InOutCubic
        }
        Timer {
            id: iBlockTimer
            interval: 4000
            onTriggered: {
                setNextAvailable()
                playVideo()
                sexUI.pPopUp = false
                iTimerAmination.start()
                scene.mCurrentScene.pEnable = true
            }
        }
    }

    OptiviaSexVideoUI {
        id: sexUI
        z: 11
        pListPositions: iOptiviaSexVideo.pListPositions
        pListAvailable: iOptiviaSexVideo.pListAvailable
    }

    function fillList() {
        if (pListAvailable.length === 0) {
            for (let i in mJumpSourceContainer.pListSources) {
                pListAvailable.push(false)
            }
        }

        pListPositions = []
        for (let i in mJumpSourceContainer.pListSources) {
            let sourceData = mJumpSourceContainer.pListSources[i].split("_")
            pListPositions.push(parseInt(sourceData[1]))
            switch (sourceData[2].split(".")[0]) {
            case "JERK": pListAvailable[i] = true; break
            case "CASANOVA": pListAvailable[i] = personStatus !== "JERK"; break
            case "SNIPER": pListAvailable[i] = personStatus === "SNIPER"; break
            default: console.log("Error - Sexvideo: " + sourceData[2]); break
            }
        }
        pListPositions = pListPositions
        pListAvailable = pListAvailable
        pListSources = mJumpSourceContainer.pListSources
    }

    function setNextAvailable() {
        for (let i=pCurrentSceneIdx+1; i < pListAvailable.length; i++) {
            if (pListAvailable[i]) {
                pCurrentSceneIdx = i
                setVideoPosition(pListPositions[pCurrentSceneIdx])
                return
            }
        }
        startVideo()
    }

    function closeEarly() {
        if (scene.mCurrentSceene === parent) {
            iTimer.stop()
            iOpacityAnimation.start()
        }
    }

    function getSource() {
        return iSexVideo.source.toString()
    }
    function setSource() {
        iLoader.setSource()
    }

    function setVideoPosition(pos) {
        iSexVideo.setPosition(pos)
        iSoundEffects.setVideoPosition(pos)
    }
    function pauseVideo() {
        sexUI.pPaused = true
        iSexVideo.pause()
        iSoundEffects.pause()
    }
    function skipVideo() {
        iSexVideo.stop()
        iSoundEffects.stop()
    }
    function playVideo() {
        sexUI.pPaused = false
        iSexVideo.play()
        iSoundEffects.play()
        iSoundEffects.setVideoPosition(iSexVideo.position)
    }
    function startVideo() {
        setVideoPosition(0)
        playVideo()
    }
    function pause() {
        pauseVideo()
    }
    function resume() {
        playVideo()
    }
}
