/*
	Author: TheTimidShade

	Description:
		Starts the cloaking process for given player unit.

	Parameters:
		0: OBJECT - Player unit entering cloak.
		
	Returns:
		NOTHING

	Execution:
		Executed internally from other cloak functions. Should be executed locally on client entering cloak.
	
	Example:
		[player] spawn tts_cloak_fnc_startCloak;
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};
if (isNil "tts_cloak_cooldown") exitWith {}; // don't run unless cloak has been initialised
if (!(_unit in allPlayers)) exitWith {}; // only run if the unit is a player

_unit setVariable ["tts_cloak_isCloaked", true, true]; // set cloak variable to true
[_unit, true] remoteExec ["hideObjectGlobal", 2, false]; // make the unit invisible
_unit setCaptive true; // prevent AI from targeting invisible unit

// play cloak in sound
if (tts_cloak_playSounds) then {
	private _source = "Land_HelipadEmpty_F" createVehicle [0,0,0]; // create seperate sound source to player 
	_source attachTo [_unit, [0,0,1]];

	[_source, "cloak_engage"] remoteExec ["say3D", 0, false];

	[_source] spawn {sleep 10; deleteVehicle (_this#0);}; // wait and delete source
};

// play cloak engaged voice
if (tts_cloak_playVoice) then {
	[] spawn {sleep 1; playSound "cloak_engage_voice";};
};

// create cloak transition particles
[_unit] remoteExec ["tts_cloak_fnc_cloakTransition", 0, false];

// create cloak particles
[_unit] remoteExec ["tts_cloak_fnc_cloakParticles", 0, false];

// start counting how long the cloak has been active
[_unit] spawn {
	params ["_unit"];
	while {alive _unit && (_unit getVariable ['tts_cloak_isCloaked',false])} do {
		sleep 1;
		tts_cloak_activeFor = tts_cloak_activeFor + 1;
	};
};

// while the unit is cloaked, check states for when to end cloak
private _duration = _unit getVariable ["tts_cloak_duration", 0];
while {_unit getVariable ['tts_cloak_isCloaked',false]} do {
	if (tts_cloak_activeFor >= _duration || vehicle _unit != _unit || (tts_cloak_requireHolstered && currentWeapon _unit != "") || !(_unit call tts_cloak_fnc_hasCloak) || !alive _unit) then {
		_unit setVariable ["tts_cloak_isCloaked", false, true];
	};
	sleep 0.05;
};

// create cloak transition particles
[_unit] remoteExec ["tts_cloak_fnc_cloakTransition", 0, false];

// play cloak out sound
if (tts_cloak_playSounds) then {
	private _source = "Land_HelipadEmpty_F" createVehicle [0,0,0]; // create seperate sound source to player
	_source attachTo [_unit, [0,0,1]];

	if (tts_cloak_activeFor >= _duration) then {
		[_source, "cloak_disengage_hot"] remoteExec ["say3D", 0, false];
	} else {
		[_source, "cloak_disengage"] remoteExec ["say3D", 0, false];
	};

	[_source] spawn {sleep 10; deleteVehicle (_this#0);}; // wait and delete source
};

[_unit, false] remoteExec ["hideObjectGlobal", 2, false]; // make the unit visible
_unit setCaptive false; // allow AI targeting again

// reset cloak timer and start cooldown
tts_cloak_activeFor = 0;
tts_cloak_cooldown = _unit getVariable ["tts_cloak_cooldown", 0];

while {tts_cloak_cooldown > 0 && alive _unit} do {
	sleep 1;
	tts_cloak_cooldown = tts_cloak_cooldown - 1;
};