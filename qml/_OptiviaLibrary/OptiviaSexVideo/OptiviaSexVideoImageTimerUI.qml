import QtQuick
import Felgo
import Qt5Compat.GraphicalEffects

import "../BaseElements"

Item {
    id: iOptiviaSexVideoUI
    visible: pShowPreview
    anchors.horizontalCenter: parent.horizontalCenter

    property var pListTimerPositions: []
    property bool pEnable: true

    y: 830
    width: iImageTimer.implicitWidth
    height: iImageTimer.implicitHeight
    Rectangle {
        anchors.right: parent.right
        width: parent.width * (1-pCurrentSceneIdx/(pListTimerPositions.length-1) - (iSexVideo.position-pListTimerPositions[pCurrentSceneIdx])/(pListTimerPositions[pCurrentSceneIdx+1]-pListTimerPositions[pCurrentSceneIdx])/(pListTimerPositions.length-1))
        height: parent.height
        color: "black"
        opacity: 0.5
        z: 2

        Rectangle {
            color: "white"
            width: 2
            height: parent.height
        }
    }

    Row {
        anchors {
            bottom: iImageTimer.bottom
            horizontalCenter: parent.horizontalCenter
        }
        spacing: 2
        z: 3
        Repeater {
            model: pListTextPositions.length

            Item {
                width: 194
                height: 29
                Rectangle {
                    anchors.fill: parent
                    opacity: 0.5
                    color: "#92a16b"
                }
                Text {
                    anchors.centerIn: parent
                    text: pListTextPositions[index]
                    font {
                        italic: true
                        weight: 400
                        pixelSize: 14
                        family: "Segoe UI"
                        letterSpacing: 1
                    }
                    color: "white"
                    bottomPadding: 5
                }
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        id: iImageTimer
        spacing: 2
        Repeater {
            model: pListSources.length

            AppImage {
                id: iImage
                source: pListSources[index]
                visible: pShowPreview

                BaseImage {
                    id: iVideoLock
                    pAssetCode: mConstants.cSexLockedFrameCode
                    visible: !pListAvailable[index]
                }
                MouseArea {
                    id: iMouseArea
                    anchors.fill: parent
                    enabled: (pListAvailable[index] && pEnable)
                    onEnabledChanged: {
                        if (!pEnable) {
                            setVideoPosition(pListTimerPositions[pCurrentSceneIdx])
                        }
                    }

                    onDoubleClicked: {
                        pCurrentSceneIdx = index
                        setVideoPosition(pListTimerPositions[index])
                    }
                    onPressed: function(mouse) {
                        pauseVideo()
                        pCurrentSceneIdx = getIndex(parent.width, mouse.x, index)
                        setVideoPosition(getPosition(pImageWidth, mouse.x, pCurrentSceneIdx))
                    }
                    onReleased: {
                        playVideo()
                        mOptiviaSexVideoThumbnail.setThumbnaiImage(-1)
                    }
                    onPositionChanged: function(mouse) {
                        if (enabled) {
                            pCurrentSceneIdx = getIndex(parent.width, mouse.x, index)
                            setVideoPosition(getPosition(pImageWidth, mouse.x, pCurrentSceneIdx))
                            mOptiviaSexVideoThumbnail.setThumbnaiImage(iSexVideo.position)
                        }
                    }
                }
            }
        }
    }
    property int pImageWidth: 194
    property bool pLessThanZero: false

    layer.enabled: true
    layer.effect: OpacityMask {
        maskSource: iImageTimer
    }

    function getIndex(width, mouseX, idx) {
        if (idx + mouseX/width < 0) {
            pLessThanZero = true
        } else {
            pLessThanZero = false
        }

        return Math.max(Math.min(idx + mouseX/width, pListTimerPositions.length-1), 0)
    }
    function getPosition(width, mouseX, idx) {
        let delta = (mouseX%width)/width
        if (mouseX < 0) {
            delta = (width + (mouseX%width))/width
        }
        if (pLessThanZero) {
            return 0
        }

        return pListTimerPositions[idx] + (pListTimerPositions[idx+1] - pListTimerPositions[idx])*delta
    }

    function setHidePreviewButton() {
        return 1920/2 + (pListTimerPositions.length-1)*(pImageWidth + (iImageTimer.spacing+1))/2
    }
}
