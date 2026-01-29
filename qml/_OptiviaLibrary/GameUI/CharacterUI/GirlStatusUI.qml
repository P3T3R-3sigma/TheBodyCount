import Felgo
import QtQuick

import "../../BaseElements"

Item {
    property var pText
    property string pStatus: "JERK"
    property string pCode
    property int pIndex

    onPStatusChanged: {
        if (pGirlIndex === pIndex) {
            giveGirlStatus(pStatus)
        }
        iImage.setSource(pStatus)
    }

    onVisibleChanged: {
        if (visible) {
            iImage.setSource(pStatus)
        }
    }

    BaseImage {
        id: iImage

        pAssetCode: pCode

        Text {
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            topPadding: 15
            text: pText[0]
            font.pixelSize: 25
            font.bold: true
            color: "white"
            Text {
                anchors.top: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text: pText[1]
                font.family: mConstants.cTinderTextFontFamily
                font.pixelSize: 16
                font.italic: true
                color: "white"
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                giveGirlStatus(pStatus)
                if (pGirlIndex !== pIndex) {
                    mGlobalSound.playSoundEffect("SOUND00")
                }
                pGirlIndex = pIndex
            }
        }
    }
    BaseImage {
        id: iArc
        pAssetCode: "UI05"
        visible: pIndex === pGirlIndex
        anchors {
            bottom: iImage.top
            horizontalCenter: iImage.horizontalCenter
        }
    }

    Repeater {
        model: mConstants.pStatusList
        ScoreUI {
            pGirl: mConstants.pPlaceList[pIndex]
            pStatus: mConstants.pStatusList[index]
            x: 1053 - parent.x
            y: 646 + index*38 - parent.y
            z: 4-index
        }
    }
}



