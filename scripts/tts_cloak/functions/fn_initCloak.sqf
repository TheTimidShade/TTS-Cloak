/*
	Author: TheTimidShade

	Description:
		Initialises settings for cloak script.

	Parameters:
		0: ARRAY (OPTIONAL) - Array of uniforms which are considered 'cloaking' uniforms.
		1: BOOL (OPTIONAL) - Whether or not the unit must put away their weapon to cloak.
		2: BOOL (OPTIONAL) - Whether or not the unit will uncloak when firing their weapon or throwing grenades.
		3: BOOL (OPTIONAL) - Whether or not to play sounds when entering/exiting cloak.
		4: BOOL (OPTIONAL) - Whether or not to play 'cloak engaged' voice after activating cloak.
		5: BOOL (OPTIONAL) - Whether or not to use the cloak UI to show cloak time/cooldown.
		
	Returns:
		NOTHING

	Execution:
		Should be executed on all clients + server from 'init.sqf'.
	
	Example:
		[
			["U_O_V_Soldier_Viper_hex_F"], 	// require viper uniform
			true, 							// weapon must be holstered
			true,							// decloaked when firing/throwing grenades
			true,							// play cloak sound effects
			true,							// play 'cloak engaged' voice
			false							// cloak ui is not displayed
		] spawn tts_cloak_fnc_initCloak;
*/

params [
	["_uniforms", [], [[]]],
	["_requireHolstered", true, [true]],
	["_decloakOnFired", true, [true]],
	["_playSounds", true, [true]],
	["_playVoice", true, [true]],
	["_useUI", true, [true]]
];

// cloak uniforms
if (count _uniforms == 0) then {
	tts_cloak_uniforms = [""];
} else {
	tts_cloak_uniforms = _uniforms; 
};

// define settings
tts_cloak_requireHolstered = _requireHolstered;
tts_cloak_decloakOnFired = _decloakOnFired;
tts_cloak_playSounds = _playSounds;
tts_cloak_playVoice = _playVoice;
tts_cloak_useUI = _useUI;

// define variables
tts_cloak_cooldown = 0;
tts_cloak_activeFor = 0;
tts_cloak_showDisplay = false;
tts_cloak_displayText = parseText "CLOAK:";

if (!hasInterface) exitWith {};

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