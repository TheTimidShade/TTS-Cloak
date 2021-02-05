/*
	Author: TheTimidShade

	Description:
		Removes access to cloak actions from provided player.

	Parameters:
		0: OBJECT - Player to remove cloak actions from.
		
	Returns:
		NOTHING

	Execution:
		Should be executed on the server or on the client the actions are being removed from.
	
	Example:
		[unit_1] call tts_cloak_fnc_removeCloak;
*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};

_unit setVariable ["tts_cloak_isCloaked", false, true]; // uncloak the unit

if (isPlayer _unit) then {
	_unit setVariable ["tts_cloak_cloakDisabled", true, true]; // prevent use of cloak actions on player units
	tts_cloak_showDisplay = false; // hide display if it is visible
};