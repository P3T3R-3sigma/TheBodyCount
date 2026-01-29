import Felgo
import QtQuick

import "../BaseElements"

Item {
    id: iNotebook

    anchors.fill: parent
    visible: false

    property bool pRestart: false
    signal closeNotebook()

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        z: -1
    }

    BasePopUp {
        id: mNoMore
        property string pGirl: ""
        pText: qsTr("You already have " + pGirl + " on your body count.\nTry somebody else!")
        pCode: "UI60"
        pPopUpTime: 6000
        z: 2
        pFunction: function() { iCloseButton.visible = true }
    }
    Item {
        id: iNotebookImages
        anchors.fill: parent
        BaseImage {
            pAssetCode: "UI100"
        }
        NotebookAnimationLine {
            id: mNotebookAnimationTheEnd
            pCode: "UI99"
            pSoundCode: ""
            x: 718
            y: 346
            pOnFinished: function() { iCloseButton.visible = true }
        }
        NotebookAnimationTear {
            id: tear
            pFromXYWH: [0, 0, 1920, 1080]
            pToXYWHR: [198, -65, 1920, 1080, 14.5]
            pTarget: iTearTarget
            pCode: "UI109"
            pSoundCode: "SOUND109"
            pOnFinished: function() { mNotebookAnimationTheEnd.startAnimation() }
        }

        Item {
            id: iTearTarget
            z: 3
            x: 0
            y: 0
            width: 1920
            height: 1080
            property real pAngle: 0

            transform: Rotation { origin.x: 735; origin.y: 976; angle: iTearTarget.pAngle}

            NotebookAnimationLine {
                id: mNotebookAnimation11
                pCode: "UI101"
                pSoundCode: "NS01"
                x: 916
                y: 294
                pOnFinished: function() {
                    meridaNum1.startAnimation()
                }
            }
            NotebookAnimationNumber {
                id: meridaNum1
                pCode: "UI105"
                pToXYWH: [1157.28, 299.54, 49, 41]
                pFromXYWH: [1157.28, 299.54, 49, 41]
                // pFromXYWH: [1150, 199, 60, 50]
                pOnFinished: function() { iCloseButton.visible = true; mNotebookAnimationTheEnd.startAnimation() }
            }

            NotebookAnimationNumber {
                id: mNotebookAnimation12
                pCode: "UI106"
                pSoundCode: "NS02"
                pToXYWH: [1146.73, 299.21, 63, 42]
                pFromXYWH: [1146.73, 299.21, 63, 42]
                pDelay: 1050
                // pFromXYWH: [1135, 199, 85, 50]
                pOnFinished: function() {
                    meridaNum1.visible = false
                    iCloseButton.visible = true
                }
            }

            NotebookAnimationLine {
                id: mNotebookAnimation2
                pCode: "UI102"
                pSoundCode: "NS04"
                x: 931
                y: 441
                pOnFinished: function() { iCloseButton.visible = true }
            }

            NotebookAnimationLine {
                id: mNotebookAnimation31
                pCode: "UI103"
                pSoundCode: "NS05"
                x: 782
                y: 399
                pOnFinished: function() {
                    lollypopNum1.startAnimation()
                }
            }
            NotebookAnimationNumber {
                id: lollypopNum1
                pCode: "UI105"
                pToXYWH: [949.28, 390.54, 49, 41]
                pFromXYWH: [949.28, 390.54, 49, 41]
                // pFromXYWH: [940, 290, 60, 50]
                pOnFinished: function() { iCloseButton.visible = true }
            }

            NotebookAnimationNumber {
                id: mNotebookAnimation32
                pCode: "UI106"
                pSoundCode: "NS06"
                pToXYWH: [942.73, 390.21, 63, 42]
                pFromXYWH: [942.73, 390.21, 63, 42]
                pDelay: 1050
                // pFromXYWH: [932, 290, 85, 50]
                pOnFinished: function() {
                    lollypopNum1.visible = false
                    iCloseButton.visible = true
                }
            }

            NotebookAnimationLine {
                id: mNotebookAnimation4
                pCode: "UI104"
                pSoundCode: "NS07"
                x: 757
                y: 555
                pOnFinished: function() { iCloseButton.visible = true }
            }

            NotebookAnimationEnd {
                id: mNotebookAnimationEnd
                x: 757
                y: 555
            }
        }

        BaseHoverButton {
            id: iCloseButton
            pAssetCode: "UI108"

            pXYWH: [991, 967, 79, 80]
            pButtonEnabled: true
            visible: false
            opacity: 0.75

            pFunctionOnEntered: function() { opacity = 1 }
            pFunctionOnExited: function() { opacity = 0.75 }
            pFunctionOnClicked: function() {
                if (scene.mEndGame) {
                    scene.globalPause()
                    return
                }
                iOpacityAnimation.start()
                if (mChoiceManager.seenAllSex()) {
                    scene.mCurrentSceene.startFadeOut(sceeneC14)
                } else {
                    closeNotebook()
                }
            }
        }
    }

    NumberAnimation {
        id: iOpacityAnimation
        target: iNotebookImages
        property: "opacity"
        to: 0
        duration: 250
        onFinished: {
            iNotebook.visible = false
            iNotebookImages.opacity = 1
        }
    }

    function startAnimation(idx) {
        iCloseButton.visible = false
        visible = true
        switch (idx) {
        case 1: mNotebookAnimation11.startAnimation(); break
        case 2: meridaNum1.visible = false; mNotebookAnimation12.startAnimation(); break
        case 3: mNotebookAnimation2.startAnimation(); break
        case 4: mNotebookAnimation2.startAnimation(); break
        case 5: mNotebookAnimation31.startAnimation(); break
        case 6: lollypopNum1.visible = false; mNotebookAnimation32.startAnimation(); break
        case 7: mNotebookAnimation4.startAnimation(); break
        default: console.log("Wrong notebook animation index")
        }
    }
    Timer {
        id: iTimer
        interval: 500
        onTriggered: mNoMore.startPopUp()
    }

    function startOnGoBack(lGirl) {
        visible = true
        iTimer.start()
        mNoMore.pGirl = lGirl
    }

    function reset() {
        visible = false
        mNotebookAnimation11.reset()
        mNotebookAnimation12.reset()
        mNotebookAnimation2.reset()
        mNotebookAnimation31.reset()
        mNotebookAnimation32.reset()
        mNotebookAnimation4.reset()
        mNotebookAnimationEnd.reset()
        meridaNum1.reset()
        lollypopNum1.reset()
    }
}
