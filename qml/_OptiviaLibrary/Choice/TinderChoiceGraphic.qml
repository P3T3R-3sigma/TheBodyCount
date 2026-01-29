import QtQuick
import Felgo
import QtQuick.Shapes

import "../"
import "../BaseElements"

Item {
    id: iOneChoice

    anchors.fill: parent

    property string pState: "GOLD"

    property var pNextScene: null
    property var pFunctionToDo: callOnClicked


    onPStateChanged: {
        if (pState === "GOLD") {
            iBackground.pAssetCode = mConstants.cTinderBackgroundGoldCode
            iAccept.pAssetCode = mConstants.cTinderAcceptGoldCode
            iReject.pAssetCode = mConstants.cTinderRejectGoldCode
        } else {
            iBackground.pAssetCode = mConstants.cTinderBackgroundSilverCode
            iAccept.pAssetCode = mConstants.cTinderAcceptSilverCode
            iReject.pAssetCode = mConstants.cTinderRejectSilverCode
        }
    }

    BaseImage {
        id: iBackground
        pAssetCode: mConstants.cTinderBackgroundGoldCode
        anchors.horizontalCenter: parent.horizontalCenter
        y: 601

        Rectangle {
            width: parent.width
            height: parent.height-20
            z: 10
            color: "transparent"

            Text {
                id: iText
                anchors.fill: parent

                leftPadding: 65
                rightPadding: 65
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap

                text: pNextScene ? pNextScene.mTextBeforeChoosing : ""

                color: mConstants.cTinderTextColor
                font {
                    pixelSize: mConstants.cTinderTextFontSize
                    family: mConstants.cTinderTextFontFamily
                }
                lineHeight: 1.3
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 746.64
        spacing: 60

        Item {
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            BaseHoverButton {
                id: iReject
                pAssetCode: mConstants.cTinderRejectGoldCode
                pSoundCode: mConstants.cTinderRejectSoundCode
                anchors.verticalCenter: parent.verticalCenter
                pXYWH: [0, 0, 80, 80]
                pFunctionOnClicked: pFunctionToDo
                pClickArgument: [pNextScene, false]
            }
        }

        Item {
            width: 80
            height: 80
            anchors.verticalCenter: parent.verticalCenter
            BaseHoverButton {
                id: iAccept
                pAssetCode: mConstants.cTinderAcceptGoldCode
                pSoundCode: mConstants.cTinderAcceptSoundCode
                anchors.verticalCenter: parent.verticalCenter
                pXYWH: [0, 0, 80, 80]
                pFunctionOnClicked: pFunctionToDo
                pClickArgument: [pNextScene, true]
            }
        }
    }
}



