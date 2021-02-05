/*
	Author: TheTimidShade

	Description:
		Creates and updates the cloak display UI while it is active.

	Parameters:
		NONE
		
	Returns:
		NOTHING

	Execution:
		Executed internally from other cloak functions. Should be executed locally on client activating UI.
	
	Example:
		[] spawn tts_cloak_fnc_updateCloakDisplay;
*/

disableSerialization;

#define IDC_CLOAK_UI_CLOAK_DISP_TEXT	1100

_readyMessage = "CLOAK: <t color='#00d615'>READY</t>";
_activeMessage = "CLOAK: <t color='#f5a442'>ACTIVE</t> (%1)";
_cooldownMessage = "CLOAK: <t color='#ff0000'>COOL</t> (%1)";

_layer = "tts_cloak_layer" cutRsc ["tts_cloak_ui", "PLAIN", 0];
_display = uiNamespace getVariable ["tts_cloak_cloakDisplay", displayNull];

if (_display isEqualTo displayNull) exitWith {systemChat "exited";};

_textBox = _display displayCtrl IDC_CLOAK_UI_CLOAK_DISP_TEXT;

while {tts_cloak_showDisplay && alive player && [player] call tts_cloak_fnc_hasCloak && tts_cloak_useUI} do {
	if (!(player getVariable ["tts_cloak_isCloaked", false])) then { // check if player is cloaked or not
		if (tts_cloak_cooldown <= 0) then { // not cloaked and cooldown finished, show 'ready'
			tts_cloak_displayText = parseText _readyMessage;
		} else { // not cloaked but cooldown still going, show timer
			_timeString = [tts_cloak_cooldown, "MM:SS"] call BIS_fnc_secondsToString;
			tts_cloak_displayText = (parseText format [_cooldownMessage,_timeString]);
		};
	} else { // player is cloaked, show remaining cloak time
		_timeRemaining = (player getVariable ["tts_cloak_duration", 0]) - tts_cloak_activeFor;
		_timeString = [_timeRemaining, "MM:SS"] call BIS_fnc_secondsToString;
		tts_cloak_displayText = (parseText format [_activeMessage, _timeString]);
	};

	_textBox ctrlSetStructuredText tts_cloak_displayText;

	sleep 0.1;
};

// hide the UI if the UI settings were changed or the player had their cloak removed
if (!tts_cloak_useUI) then {tts_cloak_showDisplay = false;};
if (player getVariable ["tts_cloak_cloakDisabled", false]) then {tts_cloak_showDisplay = false;};

_layer cutText ["", "PLAIN", 0];