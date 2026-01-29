import Felgo
import QtQuick

import "../../BaseElements"

BaseImage {
    id: iGalleryImage
    property var pVideoToStart
    property string pGirlStatus
    property string pGirlName: ""
    property bool pUnlocked: false
    property bool shadowUnlocked: pGirlStatus !== "JERK" && pUnlocked

    Text {
        text: pGirlName
        visible: shadowUnlocked
        anchors.top: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        topPadding: 5
        font {
            italic: true
            weight: 400
            pixelSize: 20
            family: "Segoe UI"
        }
        color: "#a1a1a1"
    }

    BaseImage {
        id: lockImage
        pAssetCode: "UI70"
        anchors.centerIn: parent
        visible: !shadowUnlocked
        z: 2
    }
    BaseImage {
        id: goldImage
        pAssetCode: "UI78"
        anchors.centerIn: parent
        visible: pGirlStatus === "SNIPER"
    }
    BaseImage {
        id: silverImage
        pAssetCode: "UI79"
        anchors.centerIn: parent
        visible: pGirlStatus === "CASANOVA"
    }
    MouseArea {
        anchors.fill: parent
        enabled: shadowUnlocked
        onClicked: {
            iPauseMenu.visible = false
            scene.globalResume()
            mNotebook.visible = false
            scene.mCurrentScene.startFadeOut(pVideoToStart)
            mGlobalSound.playSoundEffect("SOUND00")
        }
    }
}
