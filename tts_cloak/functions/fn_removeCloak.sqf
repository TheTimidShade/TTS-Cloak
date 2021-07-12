/*
	Author: TheTimidShade

	Description:
		Removes access to cloak actions from provided player.

	Parameters:
		0: OBJECT - Player to remove cloak actions from.
		
	Returns:
		NOTHING

	Execution:
		Should be executed where the unit the cloak is being removed from is local
	
	Example:
		[_unit] remoteExec ["tts_cloak_fnc_removeCloak", _unit, false];
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};
if (isNil {_unit getVariable "tts_cloak_isCloaked"}) exitWith {}; // do nothing if unit does not have cloak

_unit setVariable ["tts_cloak_isCloaked", false, true]; // uncloak the unit

if (_unit isKindOf "CAManBase") then {
	if (isPlayer _unit) then {
		_unit setVariable ["tts_cloak_cloakDisabled", true, true]; // prevent use of cloak actions on player units
		tts_cloak_showDisplay = false; // hide display if it is visible
	};
} else {
	_unit setVariable ["tts_cloak_vehicleHasCloak", false, true];
	private _identifier = _unit getVariable ["tts_cloak_vehicleIdentifier", ""];
	
	remoteExec ["", format ["%1_pipSetup", _identifier]]; // clear pip setup from JIP queue
};