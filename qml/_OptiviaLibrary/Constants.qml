import QtQuick
import Felgo

Item {
    id: iConstants

    property list<bool> pPlayedIntro: [false, false, false, false, false, false, false, false]
    property list<bool> pSexSceneVisited: [false, false, false, false, false, false, false]


    property var mStatusEnum: {
        "ACCESSIBLE": 0,
        "LOCKED": 1,
        "HIDDEN": 2,
        "TERMINATED": 3,
        "NULL": 4
    }
    property var mDisplayEnum: {
        "ONE_VIDEO": 0,
        "PLACEHOLDER": 1,
        "SEX": 2,
        "HALL": 3,
    }
    property var mIntroToEnum: {
        "HALL": 0,
        "PARENTSROOM": 1,
        "SEXROOM": 2,
        "KITCHEN": 3,
        "BEDROOM": 4,
        "SWIMMINGPOOL": 5,
        "LIBRARY": 6,
        "NOINTRO": 7,
    }
    property var mPersonEnum: {
        "MERIDA": 0,
        "AMBER": 1,
        "LOLLYPOP": 2,
        "MILENA": 3,
    }

    property string meridaStatus: "JERK"
    property string milenaStatus: "JERK"
    property string amberStatus: "JERK"
    property string lollypopStatus: "JERK"

    property var cSexAvailability: {
        "S01": meridaStatus,
        "S02": meridaStatus,
        "S03": "JERK",
        "S04": amberStatus,
        "S05": lollypopStatus,
        "S06": lollypopStatus,
        "S07": milenaStatus,
    }

    property var sexPositionText: {
        "NULL": [],
        "S01": ["Spoon", "Reverse Cowgirl", "Doggy", "Cum shot"],
        "S02": ["Cowgirl", "Reverse Cowgirl", "Doggy", "Cum shot", "Ending"],
        "S03": ["Restraining", "Blowjob", "Missionary", "Reverse Cowgirl", "UIowgirl", "Intermission", "Spoon", "Doggy", "Cum shot"],
        "S04": ["Blowjob", "UIowgirl", "Reverse Cowgirl", "Doggy 1", "Doggy 2", "Cum shot"],
        "S05": ["Blowjob", "UIowgirl", "Doggy", "Reverse Cowgirl", "Cum shot"],
        "S06": ["69", "Spoon", "Doggy 1", "Doggy 2", "Cum shot"],
        "S07": ["Cunni", "Blowjob", "Missionary", "Spoon", "Reverse Cowgirl", "Doggy", "Cum shot"],
    }


    //*******************************
    // CHOICE
    //*******************************

    property string cChoiceTimeRunOutText: qsTr("")
    property string cChoiceTimeRunOutCode: "UI66"

    // TIMER

    property string cTimerMaskCode: ""
    property string cTimerSoundCode: "SOUND36   "
    property string cTimerColor: ""

    property int cBaseTime: 0
    property int cAdditionalTime: 10000

    // TINDER CHOICE

    property string cTinderIdeaRunOutText: qsTr("")
    property string cTinderIdeaRunOutCode: "UI65"

    property string cTinderBackgroundGoldCode: "UI30"
    property string cTinderBackgroundSilverCode: "UI31"
    property string cTinderBackgroundSoundCode: "SOUND30"

    property string cTinderAcceptGoldCode: "UI32"
    property string cTinderAcceptSilverCode: "UI33"
    property string cTinderAcceptSoundCode: "SOUND32"

    property string cTinderRejectGoldCode: "UI34"
    property string cTinderRejectSilverCode: "UI35"
    property string cTinderRejectSoundCode: "SOUND34"


    property string cTinderTextFontFamily: "Segoe UI"
    property int cTinderTextFontSize: 24
    property string cTinderTextColor: ""


    // TEXT

    property var cTextBeforeChoice: {
        "NULL": "NULL",

        // Kitchen
        "C00": mTextConstants.cTextSceneC00,
        "C01": mTextConstants.cTextSceneC01,
        "C02": mTextConstants.cTextSceneC02,
        "C03": mTextConstants.cTextSceneC03,
        "C04": mTextConstants.cTextSceneC04,
        "C08": mTextConstants.cTextSceneC08,
        "C09": mTextConstants.cTextSceneC09,
        "C10": mTextConstants.cTextSceneC10,
        "C11": mTextConstants.cTextSceneC11,
        "C11r": mTextConstants.cTextSceneC11r,
        "C12": mTextConstants.cTextSceneC12,
        "C12r": mTextConstants.cTextSceneC12r,
        "C13": mTextConstants.cTextSceneC13,

        // DogRoom
        "C20": mTextConstants.cTextSceneC20,
        "C22": mTextConstants.cTextSceneC22,
        "C23": mTextConstants.cTextSceneC23,
        "C24": mTextConstants.cTextSceneC24,
        "C25": mTextConstants.cTextSceneC25,
        "C25l": mTextConstants.cTextSceneC25l,
        "C26": mTextConstants.cTextSceneC26,
        "C27": mTextConstants.cTextSceneC27,
        "C28": mTextConstants.cTextSceneC28,
        "C28l": mTextConstants.cTextSceneC28l,
        "C29": mTextConstants.cTextSceneC29,
        "C30": mTextConstants.cTextSceneC30,
        "C31": mTextConstants.cTextSceneC31,
        "C31r": mTextConstants.cTextSceneC31r,
        "C32": mTextConstants.cTextSceneC32,
        "C32r": mTextConstants.cTextSceneC32r,

        // Pool
        "C40": mTextConstants.cTextSceneC40,
        "C41": mTextConstants.cTextSceneC41,
        "C42": mTextConstants.cTextSceneC42,
        "C43": mTextConstants.cTextSceneC43,
        "C44": mTextConstants.cTextSceneC44,
        "C45": mTextConstants.cTextSceneC45,
        "C46": mTextConstants.cTextSceneC46,
        "C49": mTextConstants.cTextSceneC49,
        "C50": mTextConstants.cTextSceneC50,
        "C52": mTextConstants.cTextSceneC52,
        "C56": mTextConstants.cTextSceneC56,
        "C57": mTextConstants.cTextSceneC57,
        "C58": mTextConstants.cTextSceneC58,
        "C58": mTextConstants.cTextSceneC58,
        "C59": mTextConstants.cTextSceneC59,
        "C60": mTextConstants.cTextSceneC60,

        // Library
        "C70": mTextConstants.cTextSceneC70,
        "C71": mTextConstants.cTextSceneC71,
        "C72": mTextConstants.cTextSceneC72,
        "C73": mTextConstants.cTextSceneC73,
        "C74": mTextConstants.cTextSceneC74,
        "C75": mTextConstants.cTextSceneC75,
        "C76": mTextConstants.cTextSceneC76,
        "C77": mTextConstants.cTextSceneC77,
        "C78": mTextConstants.cTextSceneC78,
        "C79": mTextConstants.cTextSceneC79,
        "C80": mTextConstants.cTextSceneC80,
        "C81": mTextConstants.cTextSceneC81,
        "C82": mTextConstants.cTextSceneC82,
        "C83": mTextConstants.cTextSceneC83,
        "C84": mTextConstants.cTextSceneC84,
    }

    // EXPLORATION

    property var cExplorationChoices: {
        "HALL": [
            {
                "NAME": "KITCHEN",
                "CODE": "11",
                "POS": [82, 525, 123, 123],
                "GIRL": "Merida"
            },
            {
                "NAME": "POOL",
                "CODE": "13",
                "POS": [905, 915, 123, 123],
                "GIRL": "Lollypop"
            },
            {
                "NAME": "SECOND_FLOOR",
                "CODE": "15",
                "POS": [1382, 423, 123, 123],
            },
            {
                "NAME": "BASEMENT",
                "CODE": "16",
                "POS": [905, 680, 123, 123],
            },
        ],
        "SECOND_FLOOR": [
            {
                "NAME": "PARENTS_ROOM",
                "CODE": "17",
                "POS": [480, 400, 123, 123],
            },
            {
                "NAME": "DOG_ROOM",
                "CODE": "12",
                "POS": [1285, 400, 123, 123],
                "GIRL": "Amber"
            },
            {
                "NAME": "HALL",
                "CODE": "19",
                "POS": [901, 902, 117, 118],
            },
        ],
        "BASEMENT": [
            {
                "NAME": "LIBRARY",
                "CODE": "14",
                "POS": [133, 433, 123, 123],
                "GIRL": "Milena"
            },
            {
                "NAME": "SEX_ROOM",
                "CODE": "18",
                "POS": [1603, 433, 123, 123],
            },
            {
                "NAME": "HALL",
                "CODE": "19",
                "POS": [901, 902, 117, 118],
            },
        ]
    }

    // SCENES
    property var cKeys: ["CODE", "CHOICE", "DEFAULT", "DEFAULT_FUNC", "CORRECT", "UNLOCKS", "TERMINATES", "STATUS", "FUNCTION", "MILLIS_END_EARLY"]
        property var cScenes: {
            "NULL": null
        }
        property var cRooms: {
            "NULL": null
        }
    property var cRoomChoices: {
        "NULL": {
            "START_SCENE": [],
            "SCENES": [
                {
                    "CODE": "Intro",
                },
                {
                    "CODE": "SexRoom_cinematic",
                },
                {
                    "CODE": "Bedroom_cinematic",
                },
            ]
        },
        "KITCHEN":  {
            "START_SCENES": ["Kitchen_cinematic", "C00", "C02", "C08", "C01"],
            "SCENES": [
                {
                    "CODE": "Kitchen_cinematic",
                    "DEFAULT": "C00",
                    "TERMINATES": ["Kitchen_cinematic"],
                },
                {
                    "CODE": "C00",
                    "CHOICE": ["C03", "C04"],
                    "TERMINATES": ["C00"],
                },
                {
                    "CODE": "C01",
                },
                {
                    "CODE": "C02",
                    "CHOICE": ["C03", "C04"],
                },
                {
                    "CODE": "C03",
                    "TERMINATES": ["C02"],
                    "DEFAULT": "S01",
                    "UNLOCKS": ["C71", "C41", "C24"],
                },
                {
                    "CODE": "C04",
                },
                {
                    "CODE": "C08",
                    "CHOICE": ["C11", "C09", "C10"],
                    "FUNCTION": mBaseGame.changeHall11
                },
                {
                    "CODE": "C09",
                },
                {
                    "CODE": "C10",
                    "DEFAULT": "S03"
                },
                {
                    "CODE": "C11",
                    "CHOICE": ["C12", "HALL"],
                    "FUNCTION": mBaseGame.changeHall12
                },
                {
                    "CODE": "C12",
                    "CHOICE": ["C13", "HALL"],
                },
                {
                    "CODE": "C13",
                    "TERMINATES": ["C08", "C71", "C41", "C24"],
                    "DEFAULT": "S02"
                }
            ]
        },
        "LIBRARY": {
            "START_SCENES": ["Library_cinematic", "C71", "C70"],
            "SCENES": [
                {
                    "CODE": "Library_cinematic",
                    "DEFAULT": "C70",
                    "TERMINATES": ["Library_cinematic"],
                },
                {
                    "CODE": "C70",
                    "CHOICE": ["C72", "C73", "C74", "C75"],
                    "MILLIS_END_EARLY": 1800
                },
                {
                    "CODE": "C71",
                    "STATUS": mConstants.mStatusEnum.HIDDEN
                },
                {
                    "CODE": "C72",
                    "CHOICE": ["C76", "C77", "C78", "C79", "C73"]
                },
                {
                    "CODE": "C73",
                    "DEFAULT": "S03",
                },
                {
                    "CODE": "C74",
                },
                {
                    "CODE": "C75",
                },
                {
                    "CODE": "C76",
                    "CHOICE": ["C80", "C81", "C82", "C83", "C84"]
                },
                {
                    "CODE": "C77",
                },
                {
                    "CODE": "C78",
                },
                {
                    "CODE": "C79",
                },
                {
                    "CODE": "C80",
                    "DEFAULT": "S07",
                    "TERMINATES": ["C70"],
                },
                {
                    "CODE": "C81",
                },
                {
                    "CODE": "C82",
                },
                {
                    "CODE": "C83",
                },
                {
                    "CODE": "C84",
                },
            ]
        },
        "POOL": {
            "START_SCENES": ["Pool_cinematic", "C41", "C40", "C57"],
            "SCENES": [
                {
                    "CODE": "Pool_cinematic",
                    "DEFAULT": "C40",
                    "TERMINATES": ["Pool_cinematic"],
                },
                {
                    "CODE": "C40",
                    "CHOICE": ["C42", "C43", "C44", "C45", "C46"],
                },
                {
                    "CODE": "C41",
                    "STATUS": mConstants.mStatusEnum.HIDDEN
                },
                {
                    "CODE": "C42",
                    "CHOICE": ["C56", "C49", "C50", "C52"]
                },
                {
                    "CODE": "C43",
                },
                {
                    "CODE": "C44",
                },
                {
                    "CODE": "C45",
                },
                {
                    "CODE": "C46",
                    "DEFAULT": "S03",
                },
                {
                    "CODE": "C49",
                },
                {
                    "CODE": "C50",
                },
                {
                    "CODE": "C52",
                },
                {
                    "CODE": "C56",
                    "DEFAULT": "S05",
                    "TERMINATES": ["C40"],
                },
                {
                    "CODE": "C57",
                    "CHOICE": ["C60", "C58", "C59"]
                },
                {
                    "CODE": "C58",
                },
                {
                    "CODE": "C59",
                },
                {
                    "CODE": "C60",
                    "DEFAULT": "S06",
                },
            ]
        },
        "DOG_ROOM": {
            "START_SCENES": ["Dogroom_cinematic", "C24", "C20", "C22", "C23"],
            "SCENES": [
                {
                    "CODE": "Dogroom_cinematic",
                    "DEFAULT": "C20",
                    "TERMINATES": ["Dogroom_cinematic"],
                },
                {
                    "CODE": "C20",
                    "CHOICE": ["C26", "C25", "C28", "C29", "C30"],
                    "CORRECT": ["C26", "C29"],
                    "TERMINATES": ["C20"],
                    "FUNCTION": mBaseGame.setLaughText
                },
                {
                    "CODE": "C22",
                    "CHOICE": ["C26", "C25", "C28", "C29", "C30"],
                    "CORRECT": ["C26", "C29"],
                    "FUNCTION": mBaseGame.setLaughText,
                },
                {
                    "CODE": "C23",
                },
                {
                    "CODE": "C24",
                    "STATUS": mConstants.mStatusEnum.HIDDEN
                },
                {
                    "CODE": "C25",
                    "DEFAULT": "S03"
                },
                {
                    "CODE": "C26",
                    "CHOICE": ["C27", "C28", "C25"]
                },
                {
                    "CODE": "C27",
                    "CHOICE": ["C31", "HALL"],
                    "FUNCTION": mBaseGame.changeHall32
                },
                {
                    "CODE": "C28",
                },
                {
                    "CODE": "C29",
                    "CHOICE": ["C27", "C28", "C25"]
                },
                {
                    "CODE": "C30",
                },
                {
                    "CODE": "C31",
                    "CHOICE": ["C32", "HALL"]
                },
                {
                    "CODE": "C32",
                    "DEFAULT": "S04",
                    "TERMINATES": ["C22"]
                },
            ]
        },
        "PARENTS_ROOM": {
            "START_SCENES": ["Bedroom_cinematic"],
            "SCENES": []
        },
        "SEX_ROOM": {
            "START_SCENES": ["SexRoom_cinematic"],
            "SCENES": [
                {
                    "CODE": "S01",
                },
                {
                    "CODE": "S02",
                },
                {
                    "CODE": "S03",
                },
                {
                    "CODE": "S04",
                },
                {
                    "CODE": "S05",
                },
                {
                    "CODE": "S06",
                },
                {
                    "CODE": "S07",
                },
            ]
        }
    }

    // SCORE

    property var pScores: {
        "KITCHEN": {
            "UNREVEALED": 0,
            "JERK": 0,
            "CASANOVA": 0,
            "SNIPER": 0,
        },
        "DOG_ROOM": {
            "UNREVEALED": 0,
            "JERK": 0,
            "CASANOVA": 0,
            "SNIPER": 0,
        },
        "POOL": {
            "UNREVEALED": 0,
            "JERK": 0,
            "CASANOVA": 0,
            "SNIPER": 0,
        },
        "LIBRARY": {
            "UNREVEALED": 0,
            "JERK": 0,
            "CASANOVA": 0,
            "SNIPER": 0,
        },
    }

    property var pStatusList: ["UNREVEALED", "JERK", "CASANOVA", "SNIPER"]
    property var pPlaceList: ["KITCHEN", "DOG_ROOM", "POOL", "LIBRARY"]
    //*******************************
    // VIDEO
    //*******************************

    property string cVideoSkipCode: "UI23"
    property string cVideoSkipSoundCode: "SOUND23"



    //*******************************
    // SEX SCENE
    //*******************************


    property string cSexVolumeCode: "UI50"
    property string cSexPlayCode: "UI51"
    property string cSexPauseCode: "UI52"
    property string cSexSkipCode: "UI53"
    property string cSexKnobCode: "UI54"
    property string cSexDotCode: "UI55"
    property string cSexOptionDownCode: "UI56"
    property string cSexOptionUpCode: "UI57"
    property string cSexLockedFrameCode: "UI58"
    property string cSexBlackBarCode: "UI59"
    property string cSexMuteCode: "UI90"

    property string cSexBlockLeftCode: "UI92"
    property string cSexBlockRightCode: "UI91"
    property string cSexBlockTextCode: "UI93"

}
