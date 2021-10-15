/*
	Author: TheTimidShade

	Description:
		Used to locally add actions to vehicle when giving vehicle cloak via tts_cloak_fnc_giveVehicleCloak.

	Parameters:
		0: OBJECT - Vehicle cloak is being added to
		1: STRING - Unique string passed to cloak script
		
	Returns:
		NOTHING

*/

params [
	["_vehicle", objNull, [objNull]],
	["_identifier", "", [""]]
];

if (isNull _vehicle) exitWith {};
if (_identifier == "") exitWith {}; // can't have no identifier 

_vehicle addAction ["<t color='#00d615'>" + localize "STR_tts_cloak_action_activateVehicleCamo" + "</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_identifier"];

	[_target, _identifier] spawn tts_cloak_fnc_startVehicleCloak;
},
[_identifier], 6, false, true, "", "alive _target && (driver _target == player || commander _target == player || gunner _target == player) && !(_target getVariable ['tts_cloak_isCloaked',false]) && _target getVariable ['tts_cloak_cooldown',false] <= 0 && (_target getVariable ['tts_cloak_vehicleHasCloak',false])", 10, false];

_vehicle addAction ["<t color='#ff0000'>" + localize "STR_tts_cloak_action_deactivateVehicleCamo" + "</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	_target setVariable ["tts_cloak_isCloaked", false, true];
},
[], 6, false, true, "", "alive _target && (driver _target == player || commander _target == player || gunner _target == player) && (_target getVariable ['tts_cloak_isCloaked',false])", 10, false];

_vehicle addAction ["<t color='#f5a442'>" + localize "STR_tts_cloak_action_toggleVehicleCamoDisplay" + "</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	if (tts_cloak_showDisplayVehicle) then {
		tts_cloak_showDisplayVehicle = false;
	} else {
		tts_cloak_showDisplayVehicle = true;
		[] spawn tts_cloak_fnc_updateCloakDisplayVehicle;
	};
},
[], 6, false, true, "", "tts_cloak_useUIVehicle && alive _target && (driver _target == player || commander _target == player || gunner _target == player) && (_target getVariable ['tts_cloak_vehicleHasCloak',false])", 0, false];