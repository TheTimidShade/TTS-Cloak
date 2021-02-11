/*
	Author: TheTimidShade

	Description:
		Puts an AI unit in cloaked state for the given number of seconds.

	Parameters:
		0: OBJECT - Unit to be cloaked.
		1: (OPTIONAL) NUMBER - Duration of cloak state in seconds. (Default 30s)
		
	Returns:
		NOTHING

	Execution:
		Should be executed on server or host player but can be executed from any client in MP game.
	
	Example:
		[unit_1, 10] spawn tts_cloak_fnc_cloakAI;
*/

params [
	["_unit", objNull, [objNull]],
	["_duration", 30, [0]]
];

if (isNull _unit) exitWith {};
if (!(_unit isKindOf "CAManBase")) exitWith {};

if (_unit getVariable ["tts_cloak_isCloaked", false]) exitWith {}; // if the unit is already cloaked exit

_unit setVariable ["tts_cloak_isCloaked", true, true]; // set cloak variable to true
[_unit, true] remoteExec ["hideObjectGlobal", 2, false]; // make the unit invisible
_unit setCaptive true; // prevent AI from targeting invisible unit

private ["_targetAIEnabled", "_autotargetAIEnabled"];
if (!isPlayer _unit) then { // prevent AI units from shooting enemies while cloaked
	_targetAIEnabled = _unit checkAIFeature "TARGET";
	_autotargetAIEnabled = _unit checkAIFeature "AUTOTARGET";
	if (_targetAIEnabled) then {_unit disableAI "TARGET"};
	if (_autotargetAIEnabled) then {_unit disableAI "AUTOTARGET"};
	_unit doWatch objNull; // reset the units target
};

// play cloak in sound
if (tts_cloak_playSounds) then {
	private _source = "Land_HelipadEmpty_F" createVehicle [0,0,0]; // create seperate sound source
	_source attachTo [_unit, [0,0,1]];
	[_source, "cloak_engage"] remoteExec ["say3D", 0, false];
	_source spawn {sleep 10; deleteVehicle _this;}; // wait and delete source
};

// create cloak transition particles
[_unit] remoteExec ["tts_cloak_fnc_cloakTransition", 0, false];

// create cloak particles
[_unit] remoteExec ["tts_cloak_fnc_cloakParticles", 0, false];

private _cloakTime = 0;
waitUntil {sleep 0.1; _cloakTime = _cloakTime + 0.1; _cloakTime > _duration || !(_unit getVariable ["tts_cloak_isCloaked", false])};

_unit setVariable ["tts_cloak_isCloaked", false, true]; // decloak unit

// create cloak transition particles
[_unit] remoteExec ["tts_cloak_fnc_cloakTransition", 0, false];

// play cloak out sound
if (tts_cloak_playSounds) then {
	private _source = "Land_HelipadEmpty_F" createVehicle [0,0,0]; // create seperate sound source
	_source attachTo [_unit, [0,0,1]];
	[_source, "cloak_disengage_hot"] remoteExec ["say3D", 0, false];
	_source spawn {sleep 10; deleteVehicle _this;}; // wait and delete source
};

[_unit, false] remoteExec ["hideObjectGlobal", 2, false]; // make the unit visible
_unit setCaptive false; // allow AI targeting again

if (!isPlayer _unit) then { // re-enable AI features if they were enabled on cloak start
	if (_targetAIEnabled) then {_unit enableAI "TARGET"};
	if (_autotargetAIEnabled) then {_unit enableAI "AUTOTARGET"};
};