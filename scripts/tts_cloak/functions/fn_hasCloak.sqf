/*
	Author: TheTimidShade

	Description:
		Checks if the given unit has uniform & headgear required to cloak.
		If the empty string "" is in 'tts_cloak_uniforms' array, no uniform will be required.
		If the empty string "" is in 'tts_cloak_headgear' array, no headgear will be required.

	Parameters:
		0: OBJECT - Unit to check for cloak equipment.
		
	Returns:
		BOOL - true if unit has correct equipment, false if unit does not have correct equipment.

	Execution:
		Can be executed anywhere the check is required.
	
	Example:
		[unit_1] call tts_cloak_fnc_hasCloak;
*/

params [
	["_unit", objNull, [objNull]]
];

private _hasUniform = if ("" in tts_cloak_uniforms) then {
	true
} else {
	if (uniform _unit in tts_cloak_uniforms) then {
		true
	} else {
		false
	};
};

private _hasHeadgear = if ("" in tts_cloak_headgear) then {
	true
} else {
	if (headgear _unit in tts_cloak_headgear) then {
		true
	} else {
		false
	};
};

if (_hasUniform && _hasHeadgear) then {true} else {false};
