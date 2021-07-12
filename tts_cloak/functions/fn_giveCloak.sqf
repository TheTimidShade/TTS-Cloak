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
[_unit, ["<t color='#00d615'>Activate cloak</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	if (tts_cloak_requireHolstered) then {
		// holster players weapon
		player action ["SWITCHWEAPON",player,player,-1];
	};
	[player] spawn tts_cloak_fnc_startCloak;
},
[], 6, false, true, "", "alive _target && vehicle player == player && [player] call tts_cloak_fnc_hasCloak && !(player getVariable ['tts_cloak_isCloaked',false]) && tts_cloak_cooldown <= 0 && !(player getVariable ['tts_cloak_cloakDisabled',false])", 0, false]] remoteExec ["addAction", _unit, false];

[_unit, ["<t color='#ff0000'>Deactivate cloak</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	player setVariable ["tts_cloak_isCloaked", false, true];
},
[], 6, false, true, "", "alive _target && (player getVariable ['tts_cloak_isCloaked',false])", 0, false]] remoteExec ["addAction", _unit, false];

[_unit, ["<t color='#f5a442'>Toggle cloak display</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	if (tts_cloak_showDisplay) then {
		tts_cloak_showDisplay = false;
	} else {
		tts_cloak_showDisplay = true;
		[] spawn tts_cloak_fnc_updateCloakDisplay;
	};
},
[], 6, false, true, "", "tts_cloak_useUI && alive _target && [player] call tts_cloak_fnc_hasCloak && !(player getVariable ['tts_cloak_cloakDisabled',false])", 0, false]] remoteExec ["addAction", _unit, false];

_unit setVariable ["tts_cloak_hasActions", true, true];