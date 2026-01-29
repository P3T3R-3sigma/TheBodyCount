import Felgo
import QtQuick

import "../"

Item {
    id: iMainMenu

    anchors.fill: parent

    visible: false
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 66
        y: 380

        ButtonUI {
            id: iResumeButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Resume")
            pFunctionOnClicked: function() {
                scene.globalResume()
            }
        }
        ButtonUI {
            id: iRestartButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Restart")
            pFunctionOnClicked: function() {
                scene.globalResume()
                scene.mEndGame = false
                mChoiceManager.resetProgress()
                iPauseMenu.visible = false
                lPause = false
                mNotebook.reset()
            }
        }
        ButtonUI {
            id: quitButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Quit")
            pFunctionOnClicked: function() {
                Qt.quit()
            }
        }
    }
}
