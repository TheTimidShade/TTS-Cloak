/*
	Author: TheTimidShade

	Description:
		Initialises custom modules for ZEN if enabled

	Parameters:
		NONE
		
	Returns:
		NONE
*/

if (!isClass (configFile >> "CfgPatches" >> "zen_main")) exitWith {};

[] call tts_cloak_fnc_zen_moduleChangeSettings;
[] call tts_cloak_fnc_zen_moduleGiveCloak;
[] call tts_cloak_fnc_zen_moduleRemoveCloak;
[] call tts_cloak_fnc_zen_moduleCloakUnit;
[] call tts_cloak_fnc_zen_moduleGiveVehicleCloak;
