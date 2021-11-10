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

if (isClass(configFile >> "CfgPatches" >> "ace_main")) then
{
	// initialise ACE actions
	private _category = ["tts_cloak_actions", "TTS Cloak", "\tts_cloak\icons\cloak_man.paa",
		// statement
		{}, 
		// condition
		{
			alive _target
			&& vehicle _player == _player
			&& [_player] call tts_cloak_fnc_hasCloak
			&& !(_player getVariable ['tts_cloak_cloakDisabled',false])
		} 
	] call ace_interact_menu_fnc_createAction;

	private _activateAction = ["ActivateCloak", localize "STR_tts_cloak_action_activateCloak", "\tts_cloak\icons\cloak_man.paa",
		// statement
		{
			if (tts_cloak_requireHolstered) then {
				// holster players weapon
				player action ["SWITCHWEAPON",player,player,-1];
			};
			[player] spawn tts_cloak_fnc_startCloak;
		}, 
		// condition
		{
			alive _target
			&& vehicle _player == _player
			&& [_player] call tts_cloak_fnc_hasCloak
			&& !(_player getVariable ['tts_cloak_isCloaked',false])
			&& tts_cloak_cooldown <= 0
			&& !(_player getVariable ['tts_cloak_cloakDisabled',false])
		} 
	] call ace_interact_menu_fnc_createAction;

	private _deactivateAction = ["DeactivateCloak", localize "STR_tts_cloak_action_deactivateCloak", "\tts_cloak\icons\cloak_remove.paa",
		// statement
		{
			player setVariable ["tts_cloak_isCloaked", false, true];
		}, 
		// condition
		{
			alive _target
			&& (player getVariable ['tts_cloak_isCloaked',false])
		} 
	] call ace_interact_menu_fnc_createAction;

	private _toggleDisplayAction = ["ToggleCloakDisplay", localize "STR_tts_cloak_action_toggleCloakDisplay", "",
		// statement
		{
			if (tts_cloak_showDisplay) then {
				tts_cloak_showDisplay = false;
			} else {
				tts_cloak_showDisplay = true;
				[] spawn tts_cloak_fnc_updateCloakDisplay;
			};
		}, 
		// condition
		{
			tts_cloak_useUI
			&& alive _target
			&& [player] call tts_cloak_fnc_hasCloak
			&& !(player getVariable ['tts_cloak_cloakDisabled',false])
		} 
	] call ace_interact_menu_fnc_createAction;

	[player, 1, ["ACE_SelfActions"], _category] call ace_interact_menu_fnc_addActionToObject; 
	{
		[player, 1, ["ACE_SelfActions", "tts_cloak_actions"], _x] call ace_interact_menu_fnc_addActionToObject; 
	} forEach [_activateAction, _deactivateAction, _toggleDisplayAction];
}
else
{
	// initialise vanilla actions
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
};
