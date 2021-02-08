/*
	Author: TheTimidShade

	Description:
		Creates cloak particles on the given unit until they uncloak.
		Cloak particles are only visible up to 100m before they are deleted since they flicker in and out at long distance.

	Parameters:
		0: OBJECT - Unit to create particles on.
		
	Returns:
		NOTHING

	Execution:
		Executed internally from other cloak functions. Should be executed on all clients in MP using remoteExec.
	
	Example:
		[unit_1] spawn tts_cloak_fnc_cloakParticles;
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};

if (!hasInterface) exitWith {}; // prevent dedi and HC from running particles

// get list of points and particle sizes
private _dropPoints = [
	["head", 0.6, [0,0,0]],
	["spine3", 0.8, [0,0,0]],
	["pelvis", 0.6, [0,0,0]],
	["leftforearm", 0.5, [0,0,0]],
	["leftforearmroll", 0.4, [0,0,0]],
	["rightforearm", 0.5, [0,0,0]],
	["rightforearmroll", 0.4, [0,0,0]],
	["leftleg", 0.6, [0,0,0]],
	["leftfoot", 0.5, [0,0,0]],
	["rightleg", 0.6, [0,0,0]],
	["rightfoot", 0.5, [0,0,0]]
];

/*private _sphere = "Sign_Sphere25cm_F" createVehicleLocal (getPos _unit);
_sphere attachTo [_unit, [0,0,0], "spine3"];*/

while {_unit getVariable ["tts_cloak_isCloaked", false] && alive _unit} do {
	// create emitters
	private _emitterArray = [];
	{
		_x params ["_memPoint", "_size", "_offset"];

		private _distort = "#particlesource" createVehicleLocal (getPosATL _unit);
		_distort attachTo [_unit, _offset, _memPoint];

		_distort setParticleParams [
			["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1],
			"","Billboard",
			1,
			0.12, // 0.12
			[0, 0, 0],
			[0, 0, 0],
			17,
			10,
			7.9,
			0, 
			[_size],
			[[0,0,0,0.7]],
			[0.08],
			1,
			0,
			"",
			"",
			_distort
		];
		_distort setParticleRandom [0,[0,0,0],[0,0,0],0,0,[0, 0, 0, 0],1,0];
		_distort setParticleCircle [0,[0, 0, 0]];
		_distort setDropInterval 0.04; //0.08

		_emitterArray pushBackUnique _distort;
	} forEach _dropPoints;
	waitUntil {player distance _unit > 100 || !(_unit getVariable ["tts_cloak_isCloaked", false])}; // wait until player is too far away

	// delete emitters
	{
		deleteVehicle _x;
	} forEach _emitterArray;

	private _source = "Land_HelipadEmpty_F" createVehicleLocal (getPosATL _unit); 
	_source attachTo [_unit, [0,0,0], "pelvis"];
	
	while {player distance _unit > 100 && (_unit getVariable ["tts_cloak_isCloaked", false])} do {
		if (player distance _unit < 1000) then {
			drop [
				["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1],
				"","Billboard",
				1,
				0.2,
				[0, 0, 0],
				[0, 0, 0],
				17,
				10,
				7.9,
				0, 
				[1.3],
				[[0,0,0,0.7]],
				[0.08],
				1,
				0,
				"",
				"",
				_source
			];
		};
		sleep 0.1;
	};

	deleteVehicle _source;
};

