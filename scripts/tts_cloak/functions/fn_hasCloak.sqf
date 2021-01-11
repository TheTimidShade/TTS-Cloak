/*
	Author: TheTimidShade

	Description:
		Checks if the given unit has uniform required to cloak.
		If the empty string "" is in 'tts_cloak_uniforms' array, no uniform will be required.

	Parameters:
		0: OBJECT - Unit to check for cloak uniform.
		
	Returns:
		BOOL - true if unit has correct uniform, false if unit does not have correct uniform.

	Execution:
		Can be executed anywhere the check is required.
	
	Example:
		[unit_1] call tts_cloak_fnc_hasCloak;
*/

params [
	["_unit", objNull, [objNull]]
];

if ("" in tts_cloak_uniforms) then {
	true
} else {
	if (uniform _unit in tts_cloak_uniforms) then {
		true
	} else {
		false
	};
};