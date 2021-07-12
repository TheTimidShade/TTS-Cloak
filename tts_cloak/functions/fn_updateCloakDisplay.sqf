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

if (_display isEqualTo displayNull) exitWith {};

_textBox = _display displayCtrl IDC_CLOAK_UI_CLOAK_DISP_TEXT;

while {tts_cloak_showDisplay && alive player && [player] call tts_cloak_fnc_hasCloak} do {
	if (!(player getVariable ["tts_cloak_isCloaked", false])) then { // check if player is cloaked or not
		if (tts_cloak_cooldown <= 0) then { // not cloaked and cooldown finished, show 'ready'
			tts_cloak_displayText = parseText _readyMessage;
		} else { // not cloaked but cooldown still going, show timer
			private _timeString = [tts_cloak_cooldown, "MM:SS"] call BIS_fnc_secondsToString;
			tts_cloak_displayText = (parseText format [_cooldownMessage,_timeString]);
		};
	} else { // player is cloaked, show remaining cloak time
		private _timeRemaining = (player getVariable ["tts_cloak_duration", 0]) - tts_cloak_activeFor;
		private _timeString = [_timeRemaining, "MM:SS"] call BIS_fnc_secondsToString;
		tts_cloak_displayText = (parseText format [_activeMessage, _timeString]);
	};

	_textBox ctrlSetStructuredText tts_cloak_displayText;

	// if the UI is disabled while active, close it
	if (!tts_cloak_useUI || player getVariable ["tts_cloak_cloakDisabled", false]) then {tts_cloak_showDisplay = false;};

	sleep 0.1;
};

_layer cutText ["", "PLAIN", 0];