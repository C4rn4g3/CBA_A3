#include "script_component.hpp"

params ["_display"];
uiNamespace setVariable [QGVAR(display), _display];

// Hide addons group on display init.
private _ctrlKeyboardButtonFake = _display displayCtrl IDC_BTN_KEYBOARD_FAKE;
private _ctrlAddonsGroup = _display displayCtrl IDC_ADDONS_GROUP;
private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;

// Always highlight fake button
_ctrlKeyboardButtonFake ctrlSetTextColor [0,0,0,1];
_ctrlKeyboardButtonFake ctrlSetBackgroundColor [1,1,1,1];

_ctrlKeyboardButtonFake ctrlShow false;
_ctrlKeyboardButtonFake ctrlEnable false;
_ctrlAddonsGroup ctrlShow false;
_ctrlAddonsGroup ctrlEnable false;

_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", {_this call FUNC(onButtonClick_cancel)}];

// ----- disable in main menu
if (isNil QUOTE(ADDON)) exitWith {
    private _ctrlToggleButton = _display displayCtrl IDC_BTN_CONFIGURE_ADDONS;

    _ctrlToggleButton ctrlEnable false;
};

// ----- fill addon combo box
private _addonList = _display displayCtrl IDC_ADDON_LIST;

{
    if (_x in GVAR(activeMods)) then {
        private _nameIndex = (GVAR(modPrettyNames) select 0) find _x;
        private _modPrettyName = _x;

        if (_nameIndex != -1) then {
            _modPrettyName = (GVAR(modPrettyNames) select 1) select _nameIndex;
        };

        _addonList lbSetData [_addonList lbAdd _modPrettyName, _x];
    };
} foreach (GVAR(handlers) select 0);

_addonList lbSetCurSel 0;

// ----- update gui
[] call FUNC(gui_update);
