/*
	Author: TheTimidShade

	Description:
		Module function for Cloak Settings module.

	Parameters:
		0: OBJECT - Placed module.
		1: ARRAY - Objects that can be affected by the module.
		2: BOOL - Whether module is activated (synced triggers are active)
		
	Returns:
		NONE
*/

params [
	["_module", objNull, [objNull]],
	["_units", [], [[]]],
	["_activated", true, [true]]
];

if (!isServer) exitWith {};

if (_activated) then {
	private _uniforms = (_module getVariable ["Uniforms", ""]) splitString ",";
	private _headgear = (_module getVariable ["Headgear", ""]) splitString ",";
	private _requireHolstered = _module getVariable ["RequireHolstered", true];
	private _decloakOnFired = _module getVariable ["DecloakOnFired", true];
	private _playSounds = _module getVariable ["PlaySounds", true];
	private _playVoice = _module getVariable ["PlayVoice", true];
	private _useUI = _module getVariable ["UseUI", true];
	private _useVehicleUI = _module getVariable ["UseVehicleUI", true];

	tts_cloak_uniforms = if (count _uniforms < 1) then {[""]} else {_uniforms}; 	publicVariable "tts_cloak_uniforms";
	tts_cloak_headgear = if (count _headgear < 1) then {[""]} else {_headgear}; 	publicVariable "tts_cloak_headgear";
	tts_cloak_requireHolstered = _requireHolstered; 								publicVariable "tts_cloak_requireHolstered";
	tts_cloak_decloakOnFired = _decloakOnFired; 									publicVariable "tts_cloak_decloakOnFired";
	tts_cloak_playSounds = _playSounds; 											publicVariable "tts_cloak_playSounds";
	tts_cloak_playVoice = _playVoice; 												publicVariable "tts_cloak_playVoice";
	tts_cloak_useUI = _useUI; 														publicVariable "tts_cloak_useUI";
	tts_cloak_useUIVehicle = _useVehicleUI; 										publicVariable "tts_cloak_useUIVehicle";
};
