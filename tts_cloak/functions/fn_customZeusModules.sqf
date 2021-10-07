/*
	Author: TheTimidShade

	Description:
		Initialises custom modules for Achilles & ZEN if enabled

	Parameters:
		NONE
		
	Returns:
		NONE
*/

[] spawn {

if (isClass(configFile >> "CfgPatches" >> "tts_effects_aio") && {missionNamespace getVariable ["tts_effects_aio_disable_cloak", false]}) exitWith {};
waitUntil {sleep 1; player == player && !isNull getAssignedCuratorLogic player};

[] call tts_cloak_fnc_module_changeSettings;
[] call tts_cloak_fnc_module_giveCloak;
[] call tts_cloak_fnc_module_removeCloak;
[] call tts_cloak_fnc_module_cloakUnit;
[] call tts_cloak_fnc_module_giveVehicleCloak;

};