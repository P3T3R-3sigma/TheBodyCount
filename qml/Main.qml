import Felgo 4.0
import QtQuick 2.0

import "_OptiviaLibrary"
import "_OptiviaLibrary/Choice"
import "_OptiviaLibrary/BC_QML"
import "_OptiviaLibrary/Notebook"
import "_OptiviaLibrary/GameUI"
import "_OptiviaLibrary/BaseElements"
import "_OptiviaLibrary/Setting"
import "_OptiviaLibrary/Sound"

GameWindow {
    id: mGameWindow

    activeScene: scene

    screenWidth: 1920
    screenHeight: 1080

    Scene {
        id: scene

        // the "logical size" - the scene content is auto-scaled to match the GameWindow size
        width: 1920
        height: 1080

        property bool mEndGame: false

        property var mCurrentScene: Item {
            id: mMainMenu
            property bool pEnable: false
        }

        TextConstants {
            id: mTextConstants
        }
        Constants {
            id: mConstants
        }
        GlobalSound {
            id: mGlobalSound
        }
        SettingManager {
            id: mSettingManager
        }

        Notebook {
            id: mNotebook
            z: 3
        }
        GameUI {
            id: mGameUI
            z: 10
        }
        ChoiceManager {
            id: mChoiceManager
        }


        BC_BaseGame {
            id: mBaseGame
        }
        function getRoomNextScene(lRoom) {
            let lExploration = Object.keys(mConstants.cExplorationChoices)

            if (lExploration.includes(lRoom)) {
                return mConstants.cRooms[lRoom]
            }

            return mConstants.cRooms[lRoom].getNextScene()
        }

        Keys.onEscapePressed: {
            if (scene.mCurrentScene !== mMainMenu && !mGameUI.lScore) {
                if (mGameUI.lPause) {
                    globalResume()
                } else {
                    globalPause()
                }
                mGlobalSound.playSoundEffect("SOUND64")
            }
        }

        function getmListItemToCheckIfLoaded() {
            return [];
        }

        function globalResume() {
            if (scene.mCurrentScene !== null) {
                if (mGlobalSound.pCurrentSound) {
                    mGlobalSound.resume()
                } else {
                    mCurrentScene.globalResume()
                }
                mGameUI.resume()
            }
        }

        function globalPause() {
            if (scene.mCurrentScene !== null) {
                scene.mCurrentScene.globalPause()
                mGameUI.pause()
            }
        }
    }
    Component.onCompleted: {
        Qt.callLater(function() {
            mSettingManager.applyMode("windowed")
            fullscreenTimer.start()
        })
    }
    Timer {
        id: fullscreenTimer
        interval: 100
        onTriggered: {
            mSettingManager.applyMode("fullscreen")
            mConstants.cScenes["Intro"].startFadeIn()
        }
    }
}
