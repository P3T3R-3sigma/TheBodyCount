import Felgo
import QtQuick
import Qt5Compat.GraphicalEffects

import "../../BaseElements"


Item {
    id: iBinaryScoreUI

    property string pGirl
    property string pStatus

    width: 392
    height: 35


    visible: pIndex === pGirlIndex
    Item {
        anchors.fill: parent
        Text {
            text: mTextConstants.cStatusUIText["DATA"][index]
            anchors.left: parent.left
            color: "white"
            font {
                family: "Segoe UI"
                pixelSize: 28
            }
        }
        Text {
            onVisibleChanged: text = Math.floor(mConstants.pScores[pGirl][pStatus]) + "%"
            anchors.right: parent.right
            color: "white"
            font {
                family: "Segoe UI"
                pixelSize: 28
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: function(mouse) {
                iExplanationImage.setSource(Object.keys(mTextConstants.cStatusUIText["EXPLANATION"])[index])
                iTimer.start()
                iExplanationImage.x = parent.x + mouseX
                iExplanationImage.y = parent.y + mouseY
            }
            onExited: {
                iExplanationImage.visible = false
                iTimer.stop()
            }
        }
    }

    BaseImage {
        id: iExplanationImage
        pAssetCode: "UI07"
        z: 2
    }

    Timer {
        id: iTimer
        interval: 500
        onTriggered: {
            iExplanationImage.visible = true
        }
    }

}
