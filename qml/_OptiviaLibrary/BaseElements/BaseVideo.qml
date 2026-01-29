import Felgo
import QtQuick
import QtMultimedia


Item {
    id: baseVideo

    anchors.fill: parent

    property string pAssetCode
    property real mVolume: mSettingManager.mSoundComedy
    property bool lPaused: false
    property bool pChoiceVisible: false
    property int pMillisecBeforeEnd: 600

    signal sVideoEnd(var mediaPlayer)

    visible: false


    VideoOutput {
        id: mVideoOutput

        fillMode: VideoOutput.PreserveAspectFit

        anchors.fill: parent
        transform: [
            Scale {
                id: mVideoOutputScale
                origin.x: width / 2
                origin.y: height / 2
                xScale: 1.0
                yScale: 1.0
            }
        ]
    }

    MediaPlayer {
        id: mVideoMediaPlayer

        videoOutput: mVideoOutput
        audioOutput: AudioOutput {
            volume: mVolume
        }
        onPlaybackStateChanged: {
            if (mediaStatus === MediaPlayer.EndOfMedia) {
                sVideoEnd(mVideoMediaPlayer)
            }
        }
        onSourceChanged: {
            if (visible) {
                startVideo()
            }
        }

        onPositionChanged: {
            if (getVideoPosition() > getVideoDuration()-pMillisecBeforeEnd) {
                if (parent.mChoice) {
                    if (parent.mShadowListChoices.length === 0) {
                        parent.startFadeOut()
                    } else if (parent.mShadowListChoices.length === 1) {
                        parent.startFadeOut(parent.mShadowListChoices[0])
                    } else {
                        lPaused = true
                        pauseVideo()
                        parent.showChoices()
                        pChoiceVisible = true
                    }
                } else {
                    parent.startFadeOut()
                }
            }
        }
    }
    BaseLoader {
        id: iLoader
        pLoadAsset: mVideoMediaPlayer
        pExtractFrom: "qrc:/video_assets.qrc"
    }

    BaseHoverButton {
        id: iSkip

        pAssetCode: mConstants.cVideoSkipCode
        pSoundCode: mConstants.cVideoSkipSoundCode

        pXYWH: [915, 930, 90, 90]
        visible: !lPaused && !mGameUI.lPause
        enabled: baseVideo.parent.pEnable
        opacity: 0

        pFunctionOnClicked: function() {
            skipVideo()
        }
        Behavior on opacity {NumberAnimation {duration: 200}}
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onPositionChanged: function(mouse) {
            if (mouse.y < 870) {
                iSkip.opacity = 0
            } else {
                iSkip.opacity = 1
            }
        }
    }

    onVisibleChanged: {
        if (!visible) {
            stopVideo()
        }
    }

    function startVideo() {
        visible = true
        setVideoPosition(0)
        playVideo()
    }
    function stopVideo(){
        lPaused = true
        pChoiceVisible = false
        mVideoMediaPlayer.stop()
    }
    function pauseVideo(){
        lPaused = true
        mVideoMediaPlayer.pause()
    }
    function playVideo(){
        lPaused = false
        mVideoMediaPlayer.play()
    }
    function skipVideo() {
        if (parent.mChoice) {
            if (!mVideoMediaPlayer.source.toString()) {
                if (parent.mShadowListChoices.length === 0) {
                    parent.startFadeOut()
                } else if (parent.mShadowListChoices.length === 1) {
                    parent.startFadeOut(parent.mShadowListChoices[0])
                } else {
                    parent.showChoices()
                    pChoiceVisible = true
                }
            } else {
                setVideoPosition(getVideoDuration()-pMillisecBeforeEnd-100)
            }
        } else {
            parent.startFadeOut()
        }
    }

    function setVideoOutputScale(originX, originY, scaleX, scaleY) {
        if (originX) {
            mVideoOutputScale.origin.x = originX * width
        }
        if (originY) {
            mVideoOutputScale.origin.y = originY * height
        }
        if (scaleX) {
            mVideoOutputScale.xScale = scaleX
        }
        if (scaleY) {
            mVideoOutputScale.yScale = scaleY
        }
    }

    function getVideoOutputScale() {
        return mVideoOutputScale
    }
    function getVideoOutput() {
        return mVideoOutput
    }
    function getMediaPlayer() {
        return mVideoMediaPlayer
    }


    function getVideoState() {
        return mVideoMediaPlayer.playbackState
    }
    function getVideoDuration() {
        return mVideoMediaPlayer.duration
    }

    function getSource() {
        return mVideoMediaPlayer.source.toString()
    }
    function setSource(lSource) {
        iLoader.setSource(lSource)
    }

    function getVideoPosition() {
        return mVideoMediaPlayer.position
    }
    function setVideoPosition(sPosition) {
        mVideoMediaPlayer.position = sPosition
    }
    function pause() {
        pauseVideo()
    }
    function resume() {
        if (!pChoiceVisible) {
            playVideo()
        }
    }
}
