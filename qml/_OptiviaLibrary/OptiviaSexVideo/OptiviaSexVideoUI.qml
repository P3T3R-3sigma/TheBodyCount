import QtQuick
import Felgo
import QtMultimedia

import "../BaseElements"

Item {
    id: iOptiviaSexVideoUI
    anchors.fill: parent

    property var pListPositions: []
    property var pListAvailable: []
    property int pTimerWidth: 1386
    property bool pPopUp: false
    property bool pPaused: false
    property bool pShowPreview: false
    property real pVolumeMemory

    opacity: 1
    Behavior on opacity {NumberAnimation {duration: 200}}

    Item {
        width: 1920
        height: 760
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                iOptiviaSexVideoUI.opacity = 0
            }
            onExited: {
                iOptiviaSexVideoUI.opacity = 1
            }
        }
    }

    BaseHoverButton {
        id: iPlay
        pAssetCode: mConstants.cSexPlayCode
        pXYWH: [851, 961, 55, 55]
        visible: pPaused
        opacity: 0.75
        pFunctionOnEntered: function() { opacity = 1 }
        pFunctionOnExited: function() { opacity = 0.75 }
        pFunctionOnClicked: function() {
            playVideo()
            pPaused = false
        }
    }
    BaseHoverButton {
        id: iPause
        pAssetCode: mConstants.cSexPauseCode
        pXYWH: [851, 961, 55, 55]
        visible: !pPaused
        opacity: 0.75
        pFunctionOnEntered: function() { opacity = 1 }
        pFunctionOnExited: function() { opacity = 0.75 }
        pFunctionOnClicked: function() {
            pauseVideo()
            pPaused = true
        }
    }
    BaseHoverButton {
        id: iSkip
        pAssetCode: mConstants.cSexSkipCode
        pXYWH: [932, 961, 55, 55]
        opacity: 0.75
        pFunctionOnEntered: function() { opacity = 1 }
        pFunctionOnExited: function() { opacity = 0.75 }
        pFunctionOnClicked: function() {
            if (pNotebookIndex > 0) {
                mNotebook.startAnimation(pNotebookIndex)
                iTimer.start()
            } else {
                iOpacityAnimation.start()
            }
        }
    }

    Item {
        id: soundBar
        x: 1000
        y: 961
        width: 250
        height: 55
        z: 2
        Item {
            id: soundBarGraphics
            anchors.fill: parent
            opacity: 0
            z: 2
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                x: 80
                height: 14
                width: 126
                radius: height/2
                z: 2
                MouseArea {
                    anchors.fill: parent
                    onPressed: function(mouse) {
                        pVideoVolume = mouse.x/width
                    }
                    onMouseXChanged: function(mouse) {
                        pVideoVolume = mouse.x/width
                        if (pVideoVolume < 0) {
                            pVideoVolume = 0
                        } else if (pVideoVolume > 1) {
                            pVideoVolume = 1
                        }
                    }
                }
            }
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                x: 82
                height: 12
                width: 122 * pVideoVolume
                radius: height/2
                z: 3
                color: "#92a16b"
                BaseImage {
                    id: iVolumeKnob
                    pAssetCode: mConstants.cSexKnobCode
                    anchors.verticalCenter: parent.verticalCenter
                    x: parent.width - width/2
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onContainsMouseChanged: soundBarGraphics.opacity = containsMouse ? 1 : 0
            BaseHoverButton {
                id: iSound
                pAssetCode: mConstants.cSexVolumeCode
                pSoundCode: ""
                pXYWH: [15, 0, 55, 55]
                visible: pVideoVolume !== 0
                opacity: 0.75
                pFunctionOnEntered: function() { opacity = 1 }
                pFunctionOnExited: function() { opacity = 0.75 }
                pFunctionOnClicked: function() { pVolumeMemory = pVideoVolume; pVideoVolume = 0 }
            }
            BaseHoverButton {
                id: iMute
                pAssetCode: mConstants.cSexMuteCode
                pSoundCode: ""
                pXYWH: [15, 0, 55, 55]
                visible: pVideoVolume === 0
                opacity: 0.75
                pFunctionOnEntered: function() { opacity = 1 }
                pFunctionOnExited: function() { opacity = 0.75 }
                pFunctionOnClicked: function() { pVideoVolume = pVolumeMemory; pVolumeMemory = 0.2 }
            }
        }
    }

    BaseHoverButton {
        id: iShowPreview
        pAssetCode: mConstants.cSexOptionUpCode
        pXYWH: [1665, 892, 55, 55]
        visible: !pShowPreview
        opacity: 0.75
        pFunctionOnEntered: function() { opacity = 1 }
        pFunctionOnExited: function() { opacity = 0.75 }
        pFunctionOnClicked: function() {
            pShowPreview = true
        }
    }
    BaseHoverButton {
        id: iHidePreview
        pAssetCode: mConstants.cSexOptionDownCode
        pXYWH: [Math.max(1665, mOptiviaSexVideoImageTimerUI.setHidePreviewButton()), 892, 55, 55]
        visible: pShowPreview
        opacity: 0.75
        pFunctionOnEntered: function() { opacity = 1 }
        pFunctionOnExited: function() { opacity = 0.75 }
        pFunctionOnClicked: function() {
            pShowPreview = false
        }
    }


    OptiviaSexVideoImageTimerUI {
        id: mOptiviaSexVideoImageTimerUI
        pListTimerPositions: [...pListPositions, iSexVideo.duration]
    }

    OptiviaSexVideoTimerUI {
        id: mOptiviaSexVideoTimerUI
        pListTimerPositions: [...pListPositions, iSexVideo.duration]
        y: 910
    }

    function enableTimerBar() {
        mOptiviaSexVideoImageTimerUI.pEnable = true
        mOptiviaSexVideoTimerUI.pEnable = true
    }
    function disableTimerBar() {
        mOptiviaSexVideoImageTimerUI.pEnable = false
        mOptiviaSexVideoTimerUI.pEnable = false
    }


    function getXPosition(idx) {
        let lPosition = pListPositions[idx]
        return lPosition/iSexVideo.duration * pTimerWidth
    }
}
