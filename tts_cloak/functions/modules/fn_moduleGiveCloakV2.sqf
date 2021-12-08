/*
	Author: TheTimidShade

	Description:
		Module function for Give Cloak module. Executed on all clients including JIP.

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

if (!(missionNamespace getVariable ["tts_effects_aio_cloak_enabled", true])) exitWith {};

if (_activated) then {
	// get values from module
	private _cloakDuration = _module getVariable ["Duration", 30];
	private _cloakCooldown = _module getVariable ["Cooldown", 60];

	if (player in _units) then
	{
		[player, _cloakDuration, _cloakCooldown] spawn tts_cloak_fnc_giveCloak;
	};
};
