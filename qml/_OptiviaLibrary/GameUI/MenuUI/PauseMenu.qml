import Felgo
import QtQuick
import Qt5Compat.GraphicalEffects

import "../../BaseElements"
import "../"


Item {
    id: iPauseMenu

    anchors.fill: parent

    visible: false

    property int pIdx

    onPIdxChanged: {
        mainSettingButton.pState = "Static"
        controlsSettingButton.pState = "Static"
        galleryButton.pState = "Static"

        mainSettingButton.pButtonEnabled = true
        controlsSettingButton.pButtonEnabled = true
        galleryButton.pButtonEnabled = true
    }
    onVisibleChanged: {
        if (visible) {
            pIdx = -1
            pIdx = 0
            mainSettingButton.pState = "Clicked"
            mainSettingButton.pButtonEnabled = false
            mMainMenu.visible = true
            mControlsMenu.visible = false
            mGallery.visible = false
            lPause = true
        } else {
            lPause = false
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 15
        y: 80
        BaseHoverButton {
            id: mainSettingButton
            pAssetCode: "UI61"
            pXYWH: [0, 0, 575, 113]
            pBumpEnabled: false
            pMemory: true
            pFunctionOnClicked: function() {
                pIdx = 0
                mainSettingButton.pState = "Clicked"
                mainSettingButton.pButtonEnabled = false
                mMainMenu.visible = true
                mControlsMenu.visible = false
                mGallery.visible = false
            }
        }
        BaseHoverButton {
            id: controlsSettingButton
            pAssetCode: "UI62"
            pXYWH: [0, 0, 575, 113]
            pBumpEnabled: false
            pMemory: true
            pFunctionOnClicked: function() {
                pIdx = 1
                controlsSettingButton.pState = "Clicked"
                controlsSettingButton.pButtonEnabled = false
                mMainMenu.visible = false
                mControlsMenu.visible = true
                mGallery.visible = false
            }
        }
        BaseHoverButton {
            id: galleryButton
            pAssetCode: "UI63"
            pXYWH: [0, 0, 575, 113]
            pBumpEnabled: false
            pMemory: true
            pFunctionOnClicked: function() {
                pIdx = 2
                galleryButton.pState = "Clicked"
                galleryButton.pButtonEnabled = false
                mMainMenu.visible = false
                mControlsMenu.visible = false
                mGallery.visible = true
            }
        }
    }

    MainMenu {
        id: mMainMenu
        visible: false
    }
    ControlsMenu {
        id: mControlsMenu
        visible: false
    }
    Gallery {
        id: mGallery
        visible: false
    }

    ButtonUI {
        id: debugButton

        text: "Debug Menu"

        pFunctionOnClicked: function() {
            mDebug.visible = true
        }
    }

    DebugWindow { id: mDebug; visible: false }
}
