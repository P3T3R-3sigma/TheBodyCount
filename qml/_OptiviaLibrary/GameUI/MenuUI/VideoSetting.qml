import Felgo
import QtQuick

import "../../BaseElements"

Item {
    id: iVideoSetting

    visible: true

    width: 1920
    height: 100

    Text {
        id: iText
        x: 598
        text: "Display"
        color: "#FFFFF0"
        font.family: "Segoe UI"
        font.weight: 600
        font.pixelSize: 40
        bottomPadding: 10
    }
    Row {
        x: 946.53
        anchors.verticalCenter: iText.verticalCenter
        spacing: 21
        BaseHoverButton {
            id: windowedButton
            pAssetCode: "UI81"
            pXYWH: [0, 0, 178, 32]
            pBumpEnabled: false
            pMemory: true
            onVisibleChanged: {
                if (mSettingManager.mDisplayMode === "windowed") {
                    pState = "Clicked"
                    pButtonEnabled = false
                } else {
                    pState = "Static"
                    pButtonEnabled = true
                }
            }

            pFunctionOnClicked: function() {
                pState = "Clicked"
                pButtonEnabled = false
                fullscreenButton.pState = "Static"
                fullscreenButton.pButtonEnabled = true
                mSettingManager.applyMode("windowed")
            }
        }
        BaseHoverButton {
            id: fullscreenButton
            pAssetCode: "UI80"
            pXYWH: [0, 0, 178, 32]
            pBumpEnabled: false
            pMemory: true
            onVisibleChanged: {
                if (mSettingManager.mDisplayMode === "fullscreen") {
                    pState = "Clicked"
                    pButtonEnabled = false
                } else {
                    pState = "Static"
                    pButtonEnabled = true
                }
            }

            pFunctionOnClicked: function() {
                pState = "Clicked"
                pButtonEnabled = false
                windowedButton.pState = "Static"
                windowedButton.pButtonEnabled = true
                mSettingManager.applyMode("fullscreen")
            }
        }
    }
}
