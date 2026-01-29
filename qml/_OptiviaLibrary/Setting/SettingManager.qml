import Felgo
import QtQuick
import Qt5Compat.GraphicalEffects


Item {
    id: iSettingManager

    property real mMusicSex: 0.8
    property real mMusicComedy: 0.8
    property real mSoundComedy: 0.8
    property string mDisplayMode
    property var mResolution

    function setVolume(volume, type) {
        switch (type) {
        case "VOICE": mSoundComedy = volume; break
        case "MUSIC": mMusicComedy = volume; break
        case "SEX": mMusicSex = volume; break
        }
    }

    function applyResolution() {
        mGameWindow.visibility = Window.Windowed
        mGameWindow.flags = Qt.Window
        scene.sceneAlignmentY = "top"
        mGameWindow.height = 1080
        mGameWindow.width = 1920
    }

    function applyMode(mode) {
        if (mode) {
            mDisplayMode = mode

            if (mode === "windowed") {
                applyResolution()
                shadowCenterOnMonitor()
            }
            else if (mode === "fullscreen") {

                mGameWindow.screen = Qt.application.screens[0]
                mGameWindow.flags = Qt.FramelessWindowHint | Qt.Window
                mGameWindow.visibility = Window.FullScreen
                mResolution = null
            }
        }
    }

    function shadowCenterOnMonitor() {
        mGameWindow.x = (Screen.width - 1920)/2
        mGameWindow.y = (Screen.height - 1080)/2
    }
}
