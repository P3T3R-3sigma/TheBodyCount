import Felgo
import QtQuick


Item {
    id: iControlsMenu

    visible: true

    anchors.fill: parent
    anchors.horizontalCenter: parent.horizontalCenter
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 378
        spacing: 5
        SoundSettingGraphic {
            anchors.horizontalCenter: parent.horizontalCenter

            onVolumeChanged: mSettingManager.setVolume(volume, "SEX")
            volume: mSettingManager.mMusicSex
            pText: "Music sex"
        }
        SoundSettingGraphic {
            anchors.horizontalCenter: parent.horizontalCenter

            onVolumeChanged: mSettingManager.setVolume(volume, "MUSIC")
            volume: mSettingManager.mMusicComedy
            pText: "Music comedy"
        }
        SoundSettingGraphic {
            anchors.horizontalCenter: parent.horizontalCenter

            onVolumeChanged: mSettingManager.setVolume(volume, "VOICE")
            volume: mSettingManager.mSoundComedy
            pText: "Sound comedy"
        }
        VideoSetting {
            id: iVideoSetting
        }
    }
}

