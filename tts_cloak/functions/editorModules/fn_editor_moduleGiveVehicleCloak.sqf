/*
	Author: TheTimidShade

	Description:
		Module function for Give Vehicle Cloak module. Executed on server.

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
if (isClass(configFile >> "CfgPatches" >> "tts_effects_aio") && {missionNamespace getVariable ["tts_effects_aio_disable_cloak", false]}) exitWith {};

if (_activated) then {

	if (count _units < 1) exitWith {};

	// get values from module
	private _syncedVehicle = _units#0;
	private _identifier = _module getVariable ["Identifier", ""];
	private _cloakDuration = _module getVariable ["Duration", 120];
	private _cloakCooldown = _module getVariable ["Cooldown", 300];

	[_syncedVehicle, _identifier, _cloakDuration, _cloakCooldown] spawn tts_cloak_fnc_giveVehicleCloak;
};
