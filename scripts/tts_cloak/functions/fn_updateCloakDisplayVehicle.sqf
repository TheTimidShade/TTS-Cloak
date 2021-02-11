/*
	Author: TheTimidShade

	Description:
		Creates and updates the cloak display UI for vehicle camo while it is active.

	Parameters:
		NONE
		
	Returns:
		NOTHING

	Execution:
		Executed internally from other cloak functions. Should be executed locally on client activating UI.
	
	Example:
		[] spawn tts_cloak_fnc_updateCloakDisplayVehicle;
*/

disableSerialization;

#define IDC_CLOAK_UI_CLOAK_DISP_VEHICLE_TEXT	1101

private _readyMessage = "CAMO: <t color='#00d615'>READY</t>";
private _activeMessage = "CAMO: <t color='#f5a442'>ACTIVE</t> (%1)";
private _cooldownMessage = "CAMO: <t color='#ff0000'>COOL</t> (%1)";

private _layer = "tts_cloak_vehicle_layer" cutRsc ["tts_cloak_ui_vehicle", "PLAIN", 0];
private _display = uiNamespace getVariable ["tts_cloak_cloakDisplayVehicle", displayNull];

if (_display isEqualTo displayNull) exitWith {};

private _textBox = _display displayCtrl IDC_CLOAK_UI_CLOAK_DISP_VEHICLE_TEXT;

private _vehicle = vehicle player;

while {tts_cloak_showDisplayVehicle && alive player && alive _vehicle} do {
	if (!(_vehicle getVariable ["tts_cloak_isCloaked", false])) then { // check if vehicle is cloaked or not
		if (_vehicle getVariable ["tts_cloak_cooldown", 0] <= 0) then { // not cloaked and cooldown finished, show 'ready'
			tts_cloak_displayTextVehicle = parseText _readyMessage;
		} else { // not cloaked but cooldown still going, show timer
			private _timeString = [_vehicle getVariable ["tts_cloak_cooldown", 0], "MM:SS"] call BIS_fnc_secondsToString;
			tts_cloak_displayTextVehicle = (parseText format [_cooldownMessage,_timeString]);
		};
	} else { // vehicle is cloaked, show remaining cloak time
		private _timeRemaining = (_vehicle getVariable ["tts_cloak_duration", 0]) - (_vehicle getVariable ["tts_cloak_activeFor", 0]);
		private _timeString = [_timeRemaining, "MM:SS"] call BIS_fnc_secondsToString;
		tts_cloak_displayTextVehicle = (parseText format [_activeMessage, _timeString]);
	};

	_textBox ctrlSetStructuredText tts_cloak_displayTextVehicle;

	// if the UI is disabled while active, close it
	if (!tts_cloak_useUIVehicle || !(_vehicle getVariable ["tts_cloak_vehicleHasCloak", false])) then {tts_cloak_showDisplayVehicle = false;};
	
	// if the player exits the vehicle close the display
	if (vehicle player != _vehicle) then {tts_cloak_showDisplayVehicle = false;};

	sleep 0.1;
};

_layer cutText ["", "PLAIN", 0];