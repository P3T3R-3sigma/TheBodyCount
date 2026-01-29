import Felgo
import QtQuick

import "../../BaseElements"
import "../../Notebook"
import "../"

Rectangle {
    id: mDebugWindow

    anchors.fill: parent

    property var pSupportedModes: ["Basic", "Binary", "Mixed"]
    property int pModeIndex: 1

    visible: true
    color: "black"

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        z: -1
    }
    Rectangle {
        id: iSplashForDebug
        y: parent.height * 0.05
        width: parent.width
        height: parent.height * 0.4
        color: "black"
        z: 2
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 15
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                Text {
                    id: baseTimeText
                    text: "The number of seconds added to the timer regardless of the number of choices. (current: " + mConstants.cBaseTime/1000 + ")"
                    font.pixelSize: 40
                    color: "white"
                }

                Rectangle {
                    width: 100; height: 66
                    color: "lightgray"
                    border.color: "black"

                    TextInput {
                        id: baseTimeInput
                        anchors.fill: parent
                        anchors.margins: 10
                        font.pixelSize: 36
                        focus: true
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: IntValidator { bottom: 0; top: 50 }  // Adjust range as needed
                        onTextChanged: {
                            if (text !== "" && (parseInt(text) < 1)) {
                                text = ""
                            }
                        }
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10
                Text {
                    id: perChoiceText
                    text: "The number of seconds added to the timer for every choice. (current: " + mConstants.cAdditionalTime/1000 + ")"
                    font.pixelSize: 40
                    color: "white"
                }

                Rectangle {
                    width: 100; height: 66
                    color: "lightgray"
                    border.color: "black"

                    TextInput {
                        id: perChoiceInput
                        anchors.fill: parent
                        anchors.margins: 10
                        font.pixelSize: 36
                        focus: true
                        inputMethodHints: Qt.ImhDigitsOnly
                        validator: IntValidator { bottom: 0; top: 30 }  // Adjust range as needed
                        onTextChanged: {
                            if (text !== "" && (parseInt(text) < 1)) {
                                text = ""
                            }
                        }
                    }
                }
            }
            AppButton {
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Set timer")
                onClicked: {
                    if (perChoiceInput.text) {
                        mConstants.cAdditionalTime = perChoiceInput.text * 1000
                    }
                    if (baseTimeInput.text) {
                        mConstants.cBaseTime = baseTimeInput.text * 1000
                    }
                }
            }
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 50
                Column {
                    spacing: 5
                    // BaseDebugBoolMenu {
                    //     pText: "Turn " + (scene.mParticleOverall ? "off" : "on") + " the particles: "
                    //     pBool: scene.mParticleOverall
                    //     pFunction: function() {
                    //         scene.mParticleOverall = !scene.mParticleOverall
                    //     }
                    // }
                    // BaseDebugBoolMenu {
                    //     pText: "Show debug text: "
                    //     pBool: scene.mDebugOverall
                    //     pFunction: function() {
                    //         scene.mDebugOverall = !scene.mDebugOverall
                    //     }
                    // }
                    BaseDebugBoolMenu {
                        pText: "Merida Sex Scene 1 unlocked"
                        pBool: mConstants.pSexSceneVisited[0]
                        pFunction: function() {
                            mConstants.pSexSceneVisited[0] = !mConstants.pSexSceneVisited[0]
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Merida Sex Scene 2 unlocked"
                        pBool: mConstants.pSexSceneVisited[1]
                        pFunction: function() {
                            mConstants.pSexSceneVisited[1] = !mConstants.pSexSceneVisited[1]
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Leya Sex Scene unlocked"
                        pBool: mConstants.pSexSceneVisited[2]
                        pFunction: function() {
                            mConstants.pSexSceneVisited[2] = !mConstants.pSexSceneVisited[2]
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Amber Sex Scene unlocked"
                        pBool: mConstants.pSexSceneVisited[3]
                        pFunction: function() {
                            mConstants.pSexSceneVisited[3] = !mConstants.pSexSceneVisited[3]
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Lollypop Sex Scene 1 unlocked"
                        pBool: mConstants.pSexSceneVisited[4]
                        pFunction: function() {
                            mConstants.pSexSceneVisited[4] = !mConstants.pSexSceneVisited[4]
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Lollypop Sex Scene 2 unlocked"
                        pBool: mConstants.pSexSceneVisited[5]
                        pFunction: function() {
                            mConstants.pSexSceneVisited[5] = !mConstants.pSexSceneVisited[5]
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Milena Sex Scene unlocked"
                        pBool: mConstants.pSexSceneVisited[6]
                        pFunction: function() {
                            mConstants.pSexSceneVisited[6] = !mConstants.pSexSceneVisited[6]
                        }
                    }
                }
                Column {
                    spacing: 5
                    BaseDebugBoolMenu {
                        pText: "Merida JERK: "
                        pBool: mConstants.meridaStatus === "JERK"
                        pFunction: function() {
                            mConstants.meridaStatus = "JERK"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Merida CASANOVA: "
                        pBool: mConstants.meridaStatus === "CASANOVA"
                        pFunction: function() {
                            mConstants.meridaStatus = "CASANOVA"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Merida SNIPER: "
                        pBool: mConstants.meridaStatus === "SNIPER"
                        pFunction: function() {
                            mConstants.meridaStatus = "SNIPER"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Amber JERK: "
                        pBool: mConstants.amberStatus === "JERK"
                        pFunction: function() {
                            mConstants.amberStatus = "JERK"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Amber CASANOVA: "
                        pBool: mConstants.amberStatus === "CASANOVA"
                        pFunction: function() {
                            mConstants.amberStatus = "CASANOVA"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Amber SNIPER: "
                        pBool: mConstants.amberStatus === "SNIPER"
                        pFunction: function() {
                            mConstants.amberStatus = "SNIPER"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Lollypop JERK: "
                        pBool: mConstants.lollypopStatus === "JERK"
                        pFunction: function() {
                            mConstants.lollypopStatus = "JERK"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Lollypop CASANOVA: "
                        pBool: mConstants.lollypopStatus === "CASANOVA"
                        pFunction: function() {
                            mConstants.lollypopStatus = "CASANOVA"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Lollypop SNIPER: "
                        pBool: mConstants.lollypopStatus === "SNIPER"
                        pFunction: function() {
                            mConstants.lollypopStatus = "SNIPER"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Milena JERK: "
                        pBool: mConstants.milenaStatus === "JERK"
                        pFunction: function() {
                            mConstants.milenaStatus = "JERK"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Milena CASANOVA: "
                        pBool: mConstants.milenaStatus === "CASANOVA"
                        pFunction: function() {
                            mConstants.milenaStatus = "CASANOVA"
                        }
                    }
                    BaseDebugBoolMenu {
                        pText: "Milena SNIPER: "
                        pBool: mConstants.milenaStatus === "SNIPER"
                        pFunction: function() {
                            mConstants.milenaStatus = "SNIPER"
                        }
                    }
                }
                Column {
                    spacing: 5
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Finished Merida sex 1"
                        color: "white"
                        font.pixelSize: 28
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.startAnimation(1)
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Finished  Merida sex 2"
                        color: "white"
                        font.pixelSize: 28
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.startAnimation(2)
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Finished Leya sex"
                        color: "white"
                        font.pixelSize: 28
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.startAnimation(3)
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Finished Amber sex"
                        color: "white"
                        font.pixelSize: 28
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.startAnimation(4)
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Finished Lollypop sex 1"
                        color: "white"
                        font.pixelSize: 28
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.startAnimation(5)
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Finished Lollypop sex 2"
                        color: "white"
                        font.pixelSize: 28
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.startAnimation(6)
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Finished Milena sex"
                        color: "white"
                        font.pixelSize: 28
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.startAnimation(7)
                        }
                    }
                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Reset Notebook"
                        color: "white"
                        font.pixelSize: 32
                        MouseArea {
                            anchors.fill: parent
                            onClicked: dNoteBook.reset()
                        }
                    }
                }
            }
            Text {
                id: iText
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Debug Videos"
                color: "#FFFFF0"
                font.pixelSize: 40
                font.family: "Century Gothic Pro"
                MouseArea {
                    anchors.fill: parent

                    onClicked: iDebugVideos.visible = true
                }
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Exit"
                font.pixelSize: 50
                color: "white"

                MouseArea {
                    anchors.fill: parent

                    onClicked: mDebugWindow.visible = false
                }
            }
        }
    }
    Notebook {
        id: dNoteBook
        z: 10
    }

    DebugVideos {
        id: iDebugVideos
        z: 3
    }
}
