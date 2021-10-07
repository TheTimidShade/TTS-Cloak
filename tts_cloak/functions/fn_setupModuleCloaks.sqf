/*
	Author: TheTimidShade

	Description:
		Handles giving units cloak ability when granted via editor module.

	Parameters:
		NONE
		
	Returns:
		NOTHING

	Execution:
		Executed after module initialisation (postInit).
	
	Example:
		[] call tts_cloak_fnc_setupModuleCloak;
*/

private _unitList = missionNamespace getVariable ["tts_cloak_moduleCloakList", []];

if (!hasInterface) exitWith {}; // only run on clients
if (isClass(configFile >> "CfgPatches" >> "tts_effects_aio") && {missionNamespace getVariable ["tts_effects_aio_disable_cloak", false]}) exitWith {};

{
	_x params ["_varName", "_duration", "_cooldown"];
	if (_varName == vehicleVarName player) then {
		[player, _duration, _cooldown] spawn tts_cloak_fnc_giveCloak;
	};
} forEach _unitList;