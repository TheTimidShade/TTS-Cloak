/*
	Author: TheTimidShade

	Description:
		Creates cloak pulse effect when entering/exiting cloak state.

	Parameters:
		0: OBJECT - Unit to create particles on.
		
	Returns:
		NOTHING

	Execution:
		Executed internally from other cloak functions. Should be executed on all clients in MP using remoteExec.
	
	Example:
		[unit_1] spawn tts_cloak_fnc_cloakTransition;
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};

if (!hasInterface) exitWith {}; // prevent dedi and HC from running particles

private _source = "Land_HelipadEmpty_F" createVehicleLocal (getPosATL _unit); // create particle source
_source attachTo [_unit, [0,0,0], "pelvis"];

drop [
	["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1],
	"","Billboard",
	1,
	0.5,
	[0, 0, 0],
	[0, 0, 0],
	17,
	10,
	7.9,
	0, 
	[2.8,3,2.8],
	[[0,0,0,0],[0,0,0,1],[0,0,0,0]],
	[0.08],
	1,
	0,
	"",
	"",
	_source
];

deleteVehicle _source;