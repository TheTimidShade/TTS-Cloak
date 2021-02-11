/*
	Author: TheTimidShade

	Description:
		Initialises settings for cloak script and adds EHs for players

	Parameters:
		NONE
		
	Returns:
		NOTHING

	Execution:
		Should be executed on all clients and server from init.sqf
*/

// set up settings if they are undefined
if (isNil "tts_cloak_uniforms") then {tts_cloak_uniforms = [""];};
if (isNil "tts_cloak_headgear") then {tts_cloak_headgear = [""];};
if (isNil "tts_cloak_requireHolstered") then {tts_cloak_requireHolstered = true;};
if (isNil "tts_cloak_decloakOnFired") then {tts_cloak_decloakOnFired = true;};
if (isNil "tts_cloak_playSounds") then {tts_cloak_playSounds = true;};
if (isNil "tts_cloak_playVoice") then {tts_cloak_playVoice = true;};
if (isNil "tts_cloak_useUI") then {tts_cloak_useUI = true;};

if (isServer) then {{publicVariable _x;} forEach [ // publish server settings to all clients
		"tts_cloak_uniforms",
		"tts_cloak_headgear",
		"tts_cloak_requireHolstered",
		"tts_cloak_decloakOnFired",
		"tts_cloak_playSounds",
		"tts_cloak_playVoice",
		"tts_cloak_useUI"
	];
};

if (!hasInterface) exitWith {};

// define variables
tts_cloak_cooldown = 0;
tts_cloak_activeFor = 0;
tts_cloak_showDisplay = false;
tts_cloak_displayText = parseText "CLOAK:";
tts_cloak_showDisplayVehicle = false;
tts_cloak_displayTextVehicle = parseText "CAMO:";

waitUntil {!(isNull player)};

// add fired EH to decloak players if enabled
if (!(player getVariable ["tts_cloak_hasFiredEH", false])) then {
	// if ACE is enabled use ACE EH, otherwise use vanilla
	if (isClass(configFile >> "CfgPatches" >> "ace_main")) then {
		["ace_firedPlayer", {
			if (tts_cloak_decloakOnFired) then {player setVariable ['tts_cloak_isCloaked',false, true];};
		}] call CBA_fnc_addEventHandler;
	} else {
		player addEventHandler ["Fired", {
			if (tts_cloak_decloakOnFired) then {player setVariable ['tts_cloak_isCloaked',false, true];};
		}];
	};
	player setVariable ["tts_cloak_hasFiredEH", true, true];
};

// add respawn EH to reset cloak state on respawn
if (!(player getVariable ["tts_cloak_hasRespawnEH", false])) then {
	player addEventHandler ["Respawn", {
		params ["_unit", "_corpse"];
		tts_cloak_cooldown = 0; // reset cooldown
		[_unit, false] remoteExec ["hideObjectGlobal", 2, false]; // make sure the unit is visible
		_unit setCaptive false; // make sure unit is not captive
		player setVariable ["tts_cloak_hasActions", false, true]; // player doesn't have cloak actions anymore
	}];
	player setVariable ["tts_cloak_hasRespawnEH", true, true];
};