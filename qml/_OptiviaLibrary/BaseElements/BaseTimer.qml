import QtQuick
import Felgo
import Qt5Compat.GraphicalEffects


Item {
    id: iChoiceTimer

    property string basicBackgroundColor: "#E5E5E5"
    property string basicTimerColor: "#cd983e"

    property int pTimerTime

    anchors.fill: parent

    Item {
        id: iTimerMaskItem
        anchors.horizontalCenter: parent.horizontalCenter
        y: 860
        width: 543
        height: 45
        Item {
            id: mask
            anchors.fill: parent
            z: 1
            Rectangle {
                id: iTimerRect
                anchors.centerIn: parent
                width: parent.width
                height: parent.height/3
                radius: height/2
                color: basicBackgroundColor
            }
            Rectangle {
                anchors.centerIn: parent
                width: parent.height
                height: width
                radius: width/2
                color: basicBackgroundColor
            }
        }
        // BaseImage {
        //     id: mask
        //     anchors.horizontalCenter: parent.horizontalCenter
        //     pAssetCode: mConstants.cTimerMaskCode
        //     z: 1
        // }

        Rectangle {
            id: iTimerGraphic
            width: parent.width
            height: parent.height
            color: basicTimerColor// mConstants.cTimerColor
            z: 2
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }

        Text {
            anchors.centerIn: parent
            text: qsTr("Hall")
            font.pixelSize: 16
            font.family: "Segoe UI"
            z: 3
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.color = "white"
                onExited: parent.color = "black"
                onClicked: {
                    callOnTimeOut(false)
                }
            }
        }
    }

    ParallelAnimation {
        id: iParallelAnimationTimer

        running: false
        loops: 1
        NumberAnimation {
            id: iNumberAnimationWidth
            target: iTimerGraphic
            property: "width"
            duration: 10000
        }
        NumberAnimation {
            id: iNumberAnimationX
            target: iTimerGraphic
            property: "x"
            duration: 10000
        }
        onFinished: {
            callOnTimeOut()
        }
    }

    BaseBackgroundMusic {
        id: timerSound
        pAssetCode: mConstants.cTimerSoundCode
    }

    onVisibleChanged: {
        if (visible) {
            stopTimer()
            startTimer()
            timerSound.play()
        } else {
            stopTimer()
            timerSound.stop()
        }
    }

    function startTimer() {
        pTimerTime = getTime()
        iNumberAnimationWidth.duration = pTimerTime
        iNumberAnimationWidth.to = 0
        iNumberAnimationX.duration = pTimerTime
        iNumberAnimationX.to = iTimerMaskItem.width/2
        iParallelAnimationTimer.running = true
    }
    function stopTimer() {
        iParallelAnimationTimer.running = false
        iTimerGraphic.width = iTimerMaskItem.width
        iTimerGraphic.x = 0
    }
    function pauseTimer() {
        iParallelAnimationTimer.running = false
        timerSound.pause()
    }
    function resumeTimer() {
        if (visible) {
            iNumberAnimationWidth.duration = pTimerTime/iTimerMaskItem.width*iTimerGraphic.width
            iNumberAnimationX.duration = pTimerTime/iTimerMaskItem.width*iTimerGraphic.width
            iParallelAnimationTimer.running = true
            timerSound.play()
            timerSound.setVideoPosition(0)
        }
    }
}
