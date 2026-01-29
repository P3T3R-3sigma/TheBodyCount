import QtQuick
import Felgo


Item {
    id: iBaseScene

    anchors.fill: parent

    property var mChoice: null
    property var mBackGround: null

    property int mStatus: mConstants.mStatusEnum.ACCESSIBLE
    property real mPosToZoomInXPercent: 0.5
    property real mPosToZoomInYPercent: 0.2

    property string pCode
    objectName: pCode
    property string mTitle
    property string mTextIfLocked
    property string mTextBeforeChoosing

    property var mDefaultChoice
    property var mListChoices: []
    property var mShadowListChoices: []
    property var mListUnlocks: []
    property var mListLocks: []
    property var mListHides: []
    property var mListTerminates: []
    property var mFunctionToCall: function(){return}
    property var mFunctionArgument: []

    property var pChoosenNext
    property bool pEnable: false
    property bool pVisited: false

    z: 2
    visible: false
    opacity: 0

    ParallelAnimation {
        id: iParallelAnimationChoice

        running: false
        loops: 1
        NumberAnimation {
            id: iNumberAnimationOpacity
            target: iBaseScene
            property: "opacity"
            duration: 500
        }

        onStarted: {
            pEnable = false
        }
        onFinished: {
            if (opacity < 0.5) {
                iBaseScene.hideChoices()
                iBaseScene.visible = false
                setStatusChanges()
                if (pChoosenNext) {
                    pChoosenNext.startFadeIn()
                } else {
                    scene.mCurrentScene = null
                }
            }
            pEnable = true
        }
    }

    onMChoiceChanged: shadow_getChoices()

    Component.onCompleted: {
        mChoiceManager.addChoice(iBaseScene)
        shadow_getChoices()
        Qt.callLater(function() {
            if (mConstants.cTextBeforeChoice[pCode]) {
                mTextBeforeChoosing = mConstants.cTextBeforeChoice[pCode]
            } else {
                mTextBeforeChoosing = ""
            }
        })
    }

    function startFadeOut(lNext) {
        if (pEnable) {
            if (!lNext) {
                pChoosenNext = mDefaultChoice
            } else {
                pChoosenNext = lNext
            }

            if (mChoice) {
                if (!mChoice.pInternalChoices) {
                    mChoice.pauseTimer()
                }
            }
            iNumberAnimationOpacity.to = 0
            iParallelAnimationChoice.running = true
        }
    }
    function startFadeIn() {
        if (mStatus === mConstants.mStatusEnum.TERMINATED) {
            mConstants.cRooms["HALL"].startFadeIn()
            return
        }

        scene.mCurrentScene = this
        shadow_getChoices()
        setNextSources()
        visible = true
        pVisited = true
        mBackGround.visible = true
        if (mChoice) {
            if (mChoice.pInternalChoices) {
                showChoices()
            }
        }

        iNumberAnimationOpacity.to = 1
        iParallelAnimationChoice.running = true
        // mParticleManager.showParticle(mDefaultBackgroundParticles)
    }

    function getTime() {
        if (mChoice) {
            return mChoice.getOverallTime()
        }
        return 0
    }

    function shadow_getChoices() {
        var lShadowListChoices = []
        for (let i=0; i < mListChoices.length; i++) {
            if (mListChoices[i].mStatus !== mConstants.mStatusEnum.HIDDEN && mListChoices[i].mStatus !== mConstants.mStatusEnum.TERMINATED) {
                lShadowListChoices.push(mListChoices[i])
            }
        }

        mShadowListChoices = lShadowListChoices
        if (mChoice) {
            if (!mChoice.pInternalChoices) {
                mChoice.pListChoices = lShadowListChoices
            }
        }
    }

    function setStatusChanges() {
        let i = 0

        for (i=0; i < mListUnlocks.length; i++) {
            mListUnlocks[i].makeAccessible()
        }
        for (i=0; i < mListTerminates.length; i++) {
            mListTerminates[i].terminate()
        }
        for (i=0; i < mListHides.length; i++) {
            mListHides[i].hide()
        }
        mFunctionToCall(...mFunctionArgument)
    }

    function setNextSources() {
        for (let i=0; i < mShadowListChoices.length; i++) {
            if (!mShadowListChoices[i].getSource()) {
                mShadowListChoices[i].setSource()
            }
        }
        if (mDefaultChoice) {
            if (!mDefaultChoice.getSource()) {
                mDefaultChoice.setSource()
            }
        }

        if (!getSource()) {
            setSource()
        } else {
            mBackGround.startVideo()
        }
    }

    function setSource() {
        mBackGround.setSource()
    }
    function getSource() {
        return mBackGround.getSource()
    }

    function showChoices() {
        if (mChoice) {
            mChoice.visible = true
        }
    }
    function hideChoices() {
        if (mChoice) {
            mChoice.visible = false
        }
    }

    function globalPause() {
        pEnable = false
        if (mChoice) {
            mChoice.pause()
        }
        mBackGround.pause()
    }
    function globalResume() {
        pEnable = true
        if (mChoice) {
            mChoice.resume()
        }
        mBackGround.resume()
    }

    function hide() {
        mStatus = mConstants.mStatusEnum.HIDDEN
    }
    function terminate() {
        mStatus = mConstants.mStatusEnum.TERMINATED
    }
    function makeAccessible() {
        mStatus = mConstants.mStatusEnum.ACCESSIBLE
    }
    function lock() {
        mStatus = mConstants.mStatusEnum.LOCKED
    }

    function reset() {
        pVisited = false
        if (mChoice) {
            if (!mChoice.pInternalChoices) {
                mChoice.reset()
            }
        }
    }
}
