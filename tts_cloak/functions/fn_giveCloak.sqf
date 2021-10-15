/*
	Author: TheTimidShade

	Description:
		Gives the provided player access to cloak actions (activate, deactivate, show/hide ui).

	Parameters:
		0: OBJECT - Player to give cloak actions to.
		1: NUMBER (OPTIONAL) - Maximum duration of cloak state. (Default 60s)
		2: NUMBER (OPTIONAL) - Cloak cooldown time after cloak is deactivated.
		
	Returns:
		NOTHING

	Execution:
		Should be executed on the server or on the client the actions are being added to.
	
	Example:
		[unit_1] spawn tts_cloak_fnc_giveCloak;
*/

params [
	["_unit", objNull, [objNull]],
	["_duration", 30, [0]],
	["_cooldown", 60, [0]]
];

if (isNull _unit) exitWith {};
if (!isPlayer _unit) exitWith {}; // only run if the unit is a player

// round to nearest integer
_duration = round _duration;
_cooldown = round _cooldown;

waitUntil {!isNil "tts_cloak_cooldown"}; // wait until cloak has been initialised

_unit setVariable ["tts_cloak_isCloaked", false, true];
_unit setVariable ["tts_cloak_cloakDisabled", false, true]; // used to prevent use of cloak
_unit setVariable ["tts_cloak_duration", _duration, true];
_unit setVariable ["tts_cloak_cooldown", _cooldown, true];

if (_unit getVariable ["tts_cloak_hasActions",false]) exitWith {}; // don't add actions if player already has them

// set up actions
[_unit] remoteExec ["tts_cloak_fnc_addCloakActions", _unit, false];

_unit setVariable ["tts_cloak_hasActions", true, true];