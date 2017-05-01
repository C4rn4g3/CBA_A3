#include "script_component.hpp"

if (!hasInterface) exitWith {};

#include "XEH_PREP.sqf"

private _supportedKeys = [
    DIK_ESCAPE,
    DIK_1,
    DIK_2,
    DIK_3,
    DIK_4,
    DIK_5,
    DIK_6,
    DIK_7,
    DIK_8,
    DIK_9,
    DIK_0,
    DIK_MINUS,
    DIK_EQUALS,
    DIK_BACK,
    DIK_TAB,
    DIK_Q,
    DIK_W,
    DIK_E,
    DIK_R,
    DIK_T,
    DIK_Y,
    DIK_U,
    DIK_I,
    DIK_O,
    DIK_P,
    DIK_LBRACKET,
    DIK_RBRACKET,
    DIK_RETURN,
    DIK_LCONTROL,
    DIK_A,
    DIK_S,
    DIK_D,
    DIK_F,
    DIK_G,
    DIK_H,
    DIK_J,
    DIK_K,
    DIK_L,
    DIK_SEMICOLON,
    DIK_APOSTROPHE,
    DIK_GRAVE,
    DIK_LSHIFT,
    DIK_BACKSLASH,
    DIK_Z,
    DIK_X,
    DIK_C,
    DIK_V,
    DIK_B,
    DIK_N,
    DIK_M,
    DIK_COMMA,
    DIK_PERIOD,
    DIK_SLASH,
    DIK_RSHIFT,
    DIK_MULTIPLY,
    DIK_LMENU,
    DIK_SPACE,
    DIK_CAPITAL,
    DIK_F1,
    DIK_F2,
    DIK_F3,
    DIK_F4,
    DIK_F5,
    DIK_F6,
    DIK_F7,
    DIK_F8,
    DIK_F9,
    DIK_F10,
    DIK_NUMLOCK,
    DIK_SCROLL,
    DIK_NUMPAD7,
    DIK_NUMPAD8,
    DIK_NUMPAD9,
    DIK_SUBTRACT,
    DIK_NUMPAD4,
    DIK_NUMPAD5,
    DIK_NUMPAD6,
    DIK_ADD,
    DIK_NUMPAD1,
    DIK_NUMPAD2,
    DIK_NUMPAD3,
    DIK_NUMPAD0,
    DIK_DECIMAL,
    DIK_OEM_102,
    DIK_F11,
    DIK_F12,
    DIK_F13,
    DIK_F14,
    DIK_F15,
    DIK_KANA,
    DIK_ABNT_C1,
    DIK_CONVERT,
    DIK_NOCONVERT,
    DIK_YEN,
    DIK_ABNT_C2,
    DIK_NUMPADEQUALS,
    DIK_PREVTRACK,
    DIK_AT,
    DIK_COLON,
    DIK_UNDERLINE,
    DIK_KANJI,
    DIK_STOP,
    DIK_AX,
    DIK_UNLABELED,
    DIK_NEXTTRACK,
    DIK_NUMPADENTER,
    DIK_RCONTROL,
    DIK_MUTE,
    DIK_CALCULATOR,
    DIK_PLAYPAUSE,
    DIK_MEDIASTOP,
    DIK_VOLUMEDOWN,
    DIK_VOLUMEUP,
    DIK_WEBHOME,
    DIK_NUMPADCOMMA,
    DIK_DIVIDE,
    DIK_SYSRQ,
    DIK_RMENU,
    DIK_PAUSE,
    DIK_HOME,
    DIK_UP,
    DIK_PRIOR,
    DIK_LEFT,
    DIK_RIGHT,
    DIK_END,
    DIK_DOWN,
    DIK_NEXT,
    DIK_INSERT,
    DIK_DELETE,
    DIK_LWIN,
    DIK_RWIN,
    DIK_APPS,
    DIK_POWER,
    DIK_SLEEP,
    DIK_WAKE,
    DIK_WEBSEARCH,
    DIK_WEBFAVORITES,
    DIK_WEBREFRESH,
    DIK_WEBSTOP,
    DIK_WEBFORWARD,
    DIK_WEBBACK,
    DIK_MYCOMPUTER,
    DIK_MAIL,
    DIK_MEDIASELECT,
    DIK_XBOX_A,
    DIK_XBOX_B,
    DIK_XBOX_X,
    DIK_XBOX_Y,
    DIK_XBOX_UP,
    DIK_XBOX_DOWN,
    DIK_XBOX_LEFT,
    DIK_XBOX_RIGHT,
    DIK_XBOX_START,
    DIK_XBOX_BACK,
    DIK_XBOX_BLACK,
    DIK_XBOX_WHITE,
    DIK_XBOX_LEFT_THUMB,
    DIK_XBOX_RIGHT_THUMB
];

_supportedKeys = _supportedKeys apply {
    // strip away additional quote marks
    private _keyName = parseSimpleArray format ["[%1]", keyName _x] select 0;

    [str _x, _keyName]
};

GVAR(keyNamesHash) = [_supportedKeys] call CBA_fnc_hashCreate;

// manually add mouse key localizations to our inofficial DIK codes
{
    [GVAR(keyNamesHash), str (_x select 0), parseSimpleArray format ["[%1]", keyName (_x select 1)] select 0] call CBA_fnc_hashSet;
} forEach [
    [0xF0, 0x10000],
    [0xF1, 0x10081],
    [0xF2, 0x10002],
    [0xF3, 0x10003],
    [0xF4, 0x10004],
    [0xF5, 0x10005],
    [0xF6, 0x10006],
    [0xF7, 0x10007],
    [0xF8, 0x100004],
    [0xF9, 0x100005]
];

GVAR(forbiddenKeys) = [
    DIK_XBOX_LEFT_TRIGGER,
    DIK_XBOX_RIGHT_TRIGGER,
    DIK_XBOX_LEFT_THUMB_X_RIGHT,
    DIK_XBOX_LEFT_THUMB_Y_UP,
    DIK_XBOX_RIGHT_THUMB_X_RIGHT,
    DIK_XBOX_RIGHT_THUMB_Y_UP,
    DIK_XBOX_LEFT_THUMB_X_LEFT,
    DIK_XBOX_LEFT_THUMB_Y_DOWN,
    DIK_XBOX_RIGHT_THUMB_X_LEFT,
    DIK_XBOX_RIGHT_THUMB_Y_DOWN
];
