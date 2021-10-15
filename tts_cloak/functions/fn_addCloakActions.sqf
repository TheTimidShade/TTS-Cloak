/*
	Author: TheTimidShade

	Description:
		Used to locally add actions to player when giving cloak via tts_cloak_fnc_giveCloak.

	Parameters:
		0: OBJECT - Unit (player) cloak is being added to
		
	Returns:
		NOTHING

*/

params [
	["_unit", objNull, [objNull]]
];

if (isNull _unit) exitWith {};
if (!isPlayer _unit) exitWith {};

_unit addAction ["<t color='#00d615'>" + localize "STR_tts_cloak_action_activateCloak" + "</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	if (tts_cloak_requireHolstered) then {
		// holster players weapon
		player action ["SWITCHWEAPON",player,player,-1];
	};
	[player] spawn tts_cloak_fnc_startCloak;
},
[], 6, false, true, "", "alive _target && vehicle player == player && [player] call tts_cloak_fnc_hasCloak && !(player getVariable ['tts_cloak_isCloaked',false]) && tts_cloak_cooldown <= 0 && !(player getVariable ['tts_cloak_cloakDisabled',false])", 0, false];

_unit addAction ["<t color='#ff0000'>" + localize "STR_tts_cloak_action_deactivateCloak" + "</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	player setVariable ["tts_cloak_isCloaked", false, true];
},
[], 6, false, true, "", "alive _target && (player getVariable ['tts_cloak_isCloaked',false])", 0, false];

_unit addAction ["<t color='#f5a442'>" + localize "STR_tts_cloak_action_toggleCloakDisplay" + "</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	if (tts_cloak_showDisplay) then {
		tts_cloak_showDisplay = false;
	} else {
		tts_cloak_showDisplay = true;
		[] spawn tts_cloak_fnc_updateCloakDisplay;
	};
},
[], 6, false, true, "", "tts_cloak_useUI && alive _target && [player] call tts_cloak_fnc_hasCloak && !(player getVariable ['tts_cloak_cloakDisabled',false])", 0, false];