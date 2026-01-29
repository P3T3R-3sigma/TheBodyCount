import Felgo
import QtQuick
import Qt5Compat.GraphicalEffects

import "../BaseElements"


Item {
    id: iButtonText

    property var pFunctionOnClicked: null
    property bool pEnable: true
    property string text


    width: 238
    height: 66
    onVisibleChanged: {
        pEnable = true
        mask.pPos = 0.0
    }

    Item {
        id: item1
        width: 238
        height: 66
        BaseImage {
            id: iImage
            pAssetCode: "UI67"
            z: -1
        }

        Rectangle {
            id: mask
            width: 238
            height: 66
            radius: 33
            color: "transparent"
            antialiasing: true
            visible: false

            property real pPos: 0.0

            ConicalGradient {
                anchors.fill: parent
                angle: 0
                cached: true
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 0.0001; color: "white" }
                    GradientStop { position: mask.pPos + 0.0001; color: "white" }
                    GradientStop { position: mask.pPos + 0.0002; color: "transparent" }

                    GradientStop { position: 0.5 - mask.pPos - 0.0002; color: "transparent" }
                    GradientStop { position: 0.5 - mask.pPos - 0.0001; color: "white" }
                    GradientStop { position: 0.4999; color: "white" }
                    GradientStop { position: 0.5; color: "transparent" }

                    GradientStop { position: 0.5; color: "transparent" }
                    GradientStop { position: 0.5001; color: "white" }
                    GradientStop { position: 0.5+mask.pPos + 0.0001; color: "white" }
                    GradientStop { position: 0.5+mask.pPos + 0.0002; color: "transparent" }

                    GradientStop { position: 1-mask.pPos - 0.0002; color: "transparent" }
                    GradientStop { position: 1-mask.pPos - 0.0001; color: "white" }
                    GradientStop { position: 0.9999; color: "white" }
                    GradientStop { position: 1; color: "transparent" }
                }
            }

            NumberAnimation {
                id: iAnomation
                target: mask
                property: "pPos"
                to: 0.2497
                duration: 300
                easing.type: Easing.InQuad
            }
        }
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
    }
    Text {
        anchors.centerIn: parent
        text: iButtonText.text
        font {
            pixelSize: 34
            family: "Segoe UI"
            weight: 600
        }
        color: "#FFFFF0"
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            if (pEnable) {
                iAnomation.stop()
                iAnomation.to = 0.2497
                iAnomation.start()
            }
        }
        onExited:{
            if (pEnable) {
                iAnomation.stop()
                iAnomation.to = 0
                iAnomation.start()
            }
        }
        onPressed: {
            pEnable = false
            pFunctionOnClicked()
        }
    }
}

