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

if (isClass(configFile >> "CfgPatches" >> "ace_main")) then
{
	// initialise ACE actions
	private _category = ["tts_cloak_actions", "TTS Active Camo", "scripts\tts_cloak\icons\cloak_vehicle.paa",
		// statement
		{}, 
		// condition
		{
			alive _target
			&& (driver _target == player || commander _target == player || gunner _target == player)
			&& (_target getVariable ['tts_cloak_vehicleHasCloak',false])
		} 
	] call ace_interact_menu_fnc_createAction;

	private _activateAction = ["ActivateCloak", localize "STR_tts_cloak_action_activateVehicleCamo", "scripts\tts_cloak\icons\cloak_vehicle.paa",
		// statement
		{
			params ["_target", "_player", "_params"];
			_params params ["_identifier"];

			[_target, _identifier] spawn tts_cloak_fnc_startVehicleCloak;
		}, 
		// condition
		{
			alive _target
			&& (driver _target == player || commander _target == player || gunner _target == player)
			&& !(_target getVariable ['tts_cloak_isCloaked',false])
			&& _target getVariable ['tts_cloak_cooldown',false] <= 0
			&& (_target getVariable ['tts_cloak_vehicleHasCloak',false])
		}, {}, [_identifier]
	] call ace_interact_menu_fnc_createAction;

	private _deactivateAction = ["DeactivateCloak", localize "STR_tts_cloak_action_deactivateVehicleCamo", "scripts\tts_cloak\icons\cloak_vehicle.paa",
		// statement
		{
			_target setVariable ["tts_cloak_isCloaked", false, true];
		}, 
		// condition
		{
			alive _target
			&& (driver _target == player || commander _target == player || gunner _target == player)
			&& (_target getVariable ['tts_cloak_isCloaked',false])
		} 
	] call ace_interact_menu_fnc_createAction;

	private _toggleDisplayAction = ["ToggleCloakDisplay", localize "STR_tts_cloak_action_toggleVehicleCamoDisplay", "",
		// statement
		{
			if (tts_cloak_showDisplayVehicle) then {
				tts_cloak_showDisplayVehicle = false;
			} else {
				tts_cloak_showDisplayVehicle = true;
				[] spawn tts_cloak_fnc_updateCloakDisplayVehicle;
			};
		}, 
		// condition
		{
			tts_cloak_useUIVehicle
			&& alive _target
			&& (driver _target == player || commander _target == player || gunner _target == player)
			&& (_target getVariable ['tts_cloak_vehicleHasCloak',false])
		} 
	] call ace_interact_menu_fnc_createAction;

	[_vehicle, 1, ["ACE_SelfActions"], _category] call ace_interact_menu_fnc_addActionToObject; 
	{
		[_vehicle, 1, ["ACE_SelfActions", "tts_cloak_actions"], _x] call ace_interact_menu_fnc_addActionToObject; 
	} forEach [_activateAction, _deactivateAction, _toggleDisplayAction];
}
else
{
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
};
