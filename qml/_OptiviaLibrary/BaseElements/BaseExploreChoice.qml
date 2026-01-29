import QtQuick
import Felgo


Item {
    id: iExploreChoice
    anchors.fill: parent

    property string pPlace
    property bool pInternalChoices: true
    property var pListChoices: mConstants.cExplorationChoices[pPlace]
    z: 2

    Repeater {
        model: pListChoices
        BaseHoverButton {
            //--------------------------------------------------------------------------
            Text {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: parent.bottom
                }
                text: pListChoices[index]["NAME"]
                color: "white"
                font.weight: 800
            }
            //--------------------------------------------------------------------------
            pAssetCode: "UI" + pListChoices[index]["CODE"]
            pSoundCode: "SOUND" + pListChoices[index]["CODE"]
            pXYWH: pListChoices[index]["POS"]

            pFunctionOnClicked: function() {
                mGlobalSound.setSource(pListChoices[index]["NAME"])
                let goNext = scene.getRoomNextScene(pListChoices[index]["NAME"])
                if (goNext !== null) {
                    iExploreChoice.parent.startFadeOut(goNext)
                } else {
                    mNotebook.startOnGoBack(pListChoices[index]["GIRL"])
                }
            }
        }
    }
    Component.onCompleted: {
        Qt.callLater( function() {
            pListChoices = mConstants.cExplorationChoices[pPlace]
        })
    }
    function pause() {
        return
    }
    function resume() {
        return
    }
}

