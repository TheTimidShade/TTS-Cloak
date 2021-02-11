/*
	Author: Twiznak (Integrated by TheTimidShade)

	Description:
		Assigns a cloaking device to a vehicle (not unit)

	Parameters:
		0: OBJECT - Vehicle to give cloak to.
		1: STRING - Unique identifier used for PIP cam creation
		2: NUMBER - Maximum cloak duration before shutdown
		3: NUMBER - Cooldown period after cloak shutdown
		
	Returns:
		NOTHING

	Execution:
		Should be executed on server or host player.
	
	Example:
		[myVehicle, "myVehicle", 120, 300] remoteExec ["tts_cloak_fnc_giveVehicleCloak", 2, false];
*/

params [
	["_vehicle", objNull, [objNull]],
	["_identifier", "", [""]],
	["_duration", 120, [0]],
	["_cooldown", 300, [0]]
];

if (!isServer) exitWith {};

if (isNull _vehicle) exitWith {};
if (!(_vehicle isKindOf "AllVehicles") || _vehicle isKindOf "CAManBase") exitWith {["Invalid vehicle type provided for tts_cloak_fnc_giveVehicleCloak"] remoteExec ["systemChat", 0, false];};
if (_identifier == "") exitWith {["Vehicle must have a unique identifier for tts_cloak_fnc_giveVehicleCloak"] remoteExec ["systemChat", 0, false];};

if (isNil {_vehicle getVariable "tts_cloak_hiddenSelections"}) then { // save hidden selection textures to restore later
	private _hiddenSelections = getArray (configfile >> "CfgVehicles" >> typeOf _vehicle >> "hiddenSelectionsTextures");
	_vehicle setVariable ["tts_cloak_hiddenSelections", _hiddenSelections, true];
};

_vehicle setVariable ["tts_cloak_vehicleHasCloak", true, true];
_vehicle setVariable ["tts_cloak_vehicleIdentifier", _identifier, true];

_vehicle setVariable ["tts_cloak_duration", _duration, true];
_vehicle setVariable ["tts_cloak_cooldownMax", _cooldown, true];
_vehicle setVariable ["tts_cloak_cooldown", 0, true];

private _JIPmessageID = "";

// set up PIP cam
private _JIPmessageID = format ["%1_pipSetup", _identifier];
[_vehicle, _identifier] remoteExec ["tts_cloak_fnc_setupPIPcamera", 0, _JIPmessageID];

if (_vehicle getVariable ["tts_cloak_hasActions",false]) exitWith {}; // don't add actions if vehicle already has them

// set up actions
_JIPmessageID = format ["%1_activateAction", _identifier];
[_vehicle, ["<t color='#00d615'>Activate vehicle camo</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];
	_arguments params ["_identifier"];

	[_target, _identifier] spawn tts_cloak_fnc_startVehicleCloak;
},
[_identifier], 6, false, true, "", "alive _target && (driver _target == player || commander _target == player || gunner _target == player) && !(_target getVariable ['tts_cloak_isCloaked',false]) && _target getVariable ['tts_cloak_cooldown',false] <= 0 && (_target getVariable ['tts_cloak_vehicleHasCloak',false])", 10, false]] remoteExec ["addAction", 0, _JIPmessageID];

_JIPmessageID = format ["%1_deactivateAction", _identifier];
[_vehicle, ["<t color='#ff0000'>Deactivate camo</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	_target setVariable ["tts_cloak_isCloaked", false, true];
},
[], 6, false, true, "", "alive _target && (driver _target == player || commander _target == player || gunner _target == player) && (_target getVariable ['tts_cloak_isCloaked',false])", 10, false]] remoteExec ["addAction", 0, _JIPmessageID];

_JIPmessageID = format ["%1_toggleDispAction", _identifier];
[_vehicle, ["<t color='#f5a442'>Toggle camo display</t>", {
	params ["_target", "_caller", "_actionId", "_arguments"];

	if (tts_cloak_showDisplayVehicle) then {
		tts_cloak_showDisplayVehicle = false;
	} else {
		tts_cloak_showDisplayVehicle = true;
		[] spawn tts_cloak_fnc_updateCloakDisplayVehicle;
	};
},
[], 6, false, true, "", "tts_cloak_useUIVehicle && alive _target && (driver _target == player || commander _target == player || gunner _target == player) && (_target getVariable ['tts_cloak_vehicleHasCloak',false])", 0, false]] remoteExec ["addAction", 0, _JIPmessageID];

_vehicle setVariable ["tts_cloak_hasActions",true, true];
