import Felgo
import QtQuick
import Qt5Compat.GraphicalEffects

import "../../BaseElements"
import "../"


Item {
    id: iVideos

    anchors.fill: parent
    visible: false

    Rectangle {
        anchors.fill: parent
        color: "black"
        z:-1
        MouseArea {
            anchors.fill: parent
            onClicked: {}
        }
    }

    Row {
        x: parent.width * 0.125
        y: parent.height * 0.125
        Repeater {
            model: mChoiceManager.pListAllChoices.length === 0 ? 0 : 5
            Column {
                spacing: 10
                property int pIndex: index
                Repeater {
                    model: mChoiceManager.pListAllChoices.length === 0 ? 0 : (pIndex === 4) ? 13 : 15

                    Rectangle {
                        width: iVideos.width * 0.15
                        height: iVideos.height * 0.03
                        color: "transparent"
                        Text {
                            id: iText
                            anchors.centerIn: parent
                            text: mChoiceManager.pListAllChoices[pIndex * 15 + index].mBackGround.pSource
                            font.family: "Century Gothic Pro"
                            font.pixelSize: iVideos.height * 0.02777
                            color: "#ADADAD"
                        }
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: iSaveGlow.visible = true
                            onExited: iSaveGlow.visible = false

                            onClicked: {
                                scene.mCurrentSceene.startFadeOut(mChoiceManager.pListAllChoices[pIndex * 15 + index])

                                scene.mCurrentSceene.globalResume()
                                iPauseMenu.visible = false
                                lPause = false

                                iDebugVideos.visible = false
                                mDebugWindow.visible = false
                            }
                        }
                        RectangularGlow {
                            id: iSaveGlow
                            anchors.fill: parent
                            visible: false

                            glowRadius: parent.width*0.1
                            color: "lightgray"
                            cornerRadius: parent.width/2
                            opacity: 0.8
                        }
                    }
                }
            }
        }
    }


    ButtonUI {
        id: iBack

        text: "Back"

        pFunctionOnClicked: function() {
            if (scene.mCurrentSceene !== null) {
                iVideos.visible = false
            }
        }
    }
}
