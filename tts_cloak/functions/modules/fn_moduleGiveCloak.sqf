/*
	Author: TheTimidShade

	Description:
		Module function for Give Cloak module. Executed on server.

	Parameters:
		0: OBJECT - Placed module.
		1: ARRAY - Objects that can be affected by the module.
		2: BOOL - Whether module is activated (synced triggers are active)
		
	Returns:
		NONE
*/

params [
	["_module", objNull, [objNull]],
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!isServer) exitWith {};
if (!(missionNamespace getVariable ["tts_effects_aio_beam_enabled", true])) exitWith {};

if (_activated) then {
	// get values from module
	private _cloakUnits = (_module getVariable ["CloakUnits", ""]) splitString ",";
	private _cloakDuration = _module getVariable ["Duration", 30];
	private _cloakCooldown = _module getVariable ["Cooldown", 60];

	// retrieve current module list if it exists
	private _tmpList = missionNamespace getVariable ["tts_cloak_moduleCloakList", []];

	// add units to cloak list
	{
		_tmpList pushBackUnique [_x, _cloakDuration, _cloakCooldown];
	} forEach _cloakUnits;

	tts_cloak_moduleCloakList = _tmpList; publicVariable "tts_cloak_moduleCloakList";
};
