#include "script_component.hpp"
SCRIPT(XEH_preInit);

if (!hasInterface) exitWith {};

#include "XEH_PREP.sqf"

ADDON = false;

// Load DIK to string conversion table.
with uiNamespace do {
    GVAR(keyNames) = [GVAR(keyNamesHash)] call CBA_fnc_deserializeNamespace;
};

GVAR(keyNames) = uiNamespace getVariable QGVAR(keyNames);
GVAR(forbiddenKeys) = uiNamespace getVariable QGVAR(forbiddenKeys);

GVAR(input) = [];
GVAR(frameNoKeyPress) = diag_frameNo;
GVAR(modifiers) = [];
GVAR(firstKey) = [];
GVAR(secondKey) = [];
GVAR(thirdKey) = [];
GVAR(waitingForInput) = false;
GVAR(defaultKeybinds) = [[],[]];

if (isNil QGVAR(activeMods)) then {
    GVAR(activeMods) = [] call CBA_fnc_createNamespace;
    GVAR(activeBinds) = [] call CBA_fnc_createNamespace;
};

if (isNil QGVAR(modPrettyNames)) then {
    GVAR(modPrettyNames) = [] call CBA_fnc_createNamespace;
};

// Counter for indexing added key handlers.
GVAR(ehCounter) = 512;

/////////////////////////////////////////////////////////////////////////////////

// Announce initialization complete
ADDON = true;
