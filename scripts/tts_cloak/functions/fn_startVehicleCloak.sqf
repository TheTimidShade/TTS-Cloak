/*
	Author: Twiznak (Integrated by TheTimidShade)

	Description:
		Starts the cloaking process for given vehicle.

	Parameters:
		0: OBJECT - Vehicle entering cloak.
		1: STRING - Unique identifier used for PIP camera
		
	Returns:
		NOTHING

	Execution:
		Executed internally from other cloak functions. Should be executed where cloaked vehicle is local.
	
	Example:
		[vehicle, "identifier"] remoteExec ["tts_cloak_fnc_startVehicleCloak", vehicle, false];
*/

params [
	["_vehicle", objNull, [objNull]],
	["_identifier", "", [""]]
];

if (isNull _vehicle) exitWith {};
if (!(_vehicle isKindOf "AllVehicles") || _vehicle isKindOf "CAManBase") exitWith {};
if (_identifier == "") exitWith {};

if (!local _vehicle) exitWith {}; // exit if not local

_vehicle setVariable ["tts_cloak_isCloaked", true, true]; // set cloak variable to true
_vehicle setVariable ["tts_cloak_cooldown", (_vehicle getVariable ["tts_cloak_cooldownMax", 300]), true]; // set cooldown to max here to allow early update

// play cloak in sound
if (tts_cloak_playSounds) then {
	private _source = "Land_HelipadEmpty_F" createVehicle [0,0,0]; // create seperate sound source to player 
	_source attachTo [_vehicle, [0,0,1]];

	[_source, "cloak_engage"] remoteExec ["say3D", 0, false];

	[_source] spawn {sleep 10; deleteVehicle (_this#0);}; // wait and delete source
};

// execute PIP camera active camo
[_vehicle, _identifier] remoteExec ["tts_cloak_fnc_vehicleCloakEffect", 0, false];

// start counting how long the cloak has been active
_vehicle setVariable ["tts_cloak_activeFor", 0, true];
[_vehicle] spawn {
	params ["_vehicle"];
	while {alive _vehicle && (_vehicle getVariable ["tts_cloak_isCloaked",false])} do {
		sleep 1;
		_vehicle setVariable ["tts_cloak_activeFor", ((_vehicle getVariable "tts_cloak_activeFor") + 1), true];
	};
};

// while the unit is cloaked, check states for when to end cloak
private _duration = _vehicle getVariable ["tts_cloak_duration", 0];
while {_vehicle getVariable ["tts_cloak_isCloaked",false]} do {
	if ((_vehicle getVariable "tts_cloak_activeFor") >= _duration || !alive _vehicle) then {
		_vehicle setVariable ["tts_cloak_isCloaked", false, true];
	};
	sleep 0.05;
};

// play cloak out sound
if (tts_cloak_playSounds) then {
	private _source = "Land_HelipadEmpty_F" createVehicle [0,0,0]; // create seperate sound source to vehicle
	_source attachTo [_vehicle, [0,0,1]];

	if ((_vehicle getVariable "tts_cloak_activeFor") >= _duration) then {
		[_source, "cloak_disengage_hot"] remoteExec ["say3D", 0, false];
	} else {
		[_source, "cloak_disengage"] remoteExec ["say3D", 0, false];
	};

	[_source] spawn {sleep 10; deleteVehicle (_this#0);}; // wait and delete source
};

// reset cloak timer and start cooldown
_vehicle setVariable ["tts_cloak_activeFor", 0, true];

while {_vehicle getVariable "tts_cloak_cooldown" > 0 && alive _vehicle} do {
	sleep 1;
	_vehicle setVariable ["tts_cloak_cooldown", ((_vehicle getVariable "tts_cloak_cooldown")-1), true];
};