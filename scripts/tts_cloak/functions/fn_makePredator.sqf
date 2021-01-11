/*
	Author: TheTimidShade

	Description:
		Gives the player the ability to intimidate their enemies.

	Parameters:
		0: OBJECT - Player to give the action to.
		
	Returns:
		NOTHING

	Execution:
		Should be executed on the server or on the client the action is being added to.
	
	Example:
		[unit_1] spawn tts_cloak_fnc_makePredator;
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};
if (!(_unit in allPlayers)) exitWith {}; // only run if the unit is a player

_unit setVariable ["tts_cloak_soundActive", false, true];

// set up actions
[_unit, ["<t color='#f5d142'>Intimidate</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	player setVariable ["tts_cloak_soundActive", true, true];

	_sound = selectRandom ["cloak_predator_1", "cloak_predator_2"];
	[player, _sound] remoteExec ["say3D", 0, false];
	
	sleep 5;
	
	player setVariable ["tts_cloak_soundActive", false, true];
},
[], 6, false, true, "", "alive _target && !(player getVariable ['tts_cloak_soundActive', false])", 0, false]] remoteExec ["addAction", _unit, false];