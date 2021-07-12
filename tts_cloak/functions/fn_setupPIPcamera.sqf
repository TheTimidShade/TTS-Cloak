/*
	Author: Twiznak (Integrated by TheTimidShade)

	Description:
		Handles creation of PIP camera for vehicle active camo

	Parameters:
		0: OBJECT - Vehicle to give cloak to.
		1: STRING - Unique identifier used for PIP render target
		
	Returns:
		NOTHING

	Execution:
		Should be executed on each client as they join the game
	
	Example:
		[vehicle, "identifier"] remoteExec ["tts_cloak_fnc_setupPIPcamera", 0, true];
*/

params [
	["_vehicle", objNull, [objNull]],
	["_identifier", "", [""]]
];

if (!hasInterface) exitWith {}; // don't run on dedi or HC
if (!alive _vehicle) exitWith {};

private _renderSurfaceID = format ["tts_cloak_render_%1", _identifier];

// create PIP camera for cloak effect
private _pipCamera = "camera" camCreate [0,0,0];
_pipCamera camSetFov 0.3;
_pipCamera cameraEffect ["Internal", "BACK", _renderSurfaceID];
_pipCamera attachTo [_vehicle, [0,10,20]];

// air vehicles should camouflage using sky not ground
if (_vehicle isKindOf "AIR") then {
	_pipCamera setVectorUp [0,0.99,-0.01];
} else {
	_pipCamera setVectorUp [0,0.99,0.01];
};
_pipCamera camCommit 0;

_vehicle setVariable ["tts_cloak_attachedCamera", _pipCamera]; // value is not broadcast since camera is local

// wait until destroyed or deleted or cloak is removed
waitUntil {sleep 0.05; !alive _vehicle || !(_vehicle getVariable ["tts_cloak_vehicleHasCloak", false])};

_pipCamera cameraEffect ["Terminate", "BACK", _renderSurfaceID];
camDestroy _pipCamera;