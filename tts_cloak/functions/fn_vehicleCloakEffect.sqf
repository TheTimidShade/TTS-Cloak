/*
	Author: Twiznak (Integrated by TheTimidShade)

	Description:
		Handles PIP cloak effect for vehicles

	Parameters:
		0: OBJECT - Vehicle to cloak.
		1: STRING - Unique identifier used for PIP render target
		
	Returns:
		NOTHING

	Execution:
		Should be remote executed on all connected clients
	
	Example:
		[vehicle, "identifier"] remoteExec ["tts_cloak_fnc_vehiceCloakEffect", 0, false];
*/

params [
	["_vehicle", objNull, [objNull]],
	["_identifier", "", [""]]
];

private _renderSurfaceID = format ["tts_cloak_render_%1", _identifier];
private _pipCamera = _vehicle getVariable ["tts_cloak_attachedCamera", objNull];

if (isNull _pipCamera) exitWith {};

// get vehicle selections and apply PIP render to texture
private _hiddenSelections = _vehicle getVariable ["tts_cloak_hiddenSelections", []];
{
	private _renderSurface = format ["#(argb,256,256,1)r2t(%1,1)", _renderSurfaceID];
	_vehicle setObjectTextureGlobal [_forEachIndex, _renderSurface];
} forEach _hiddenSelections;

// handle spectator and zeus (restores PIP texture after exiting zeus/spectator)
// zeus
[_vehicle, _pipCamera, _renderSurfaceID] spawn {
	params ["_vehicle", "_pipCamera", "_renderSurfaceID"];
	while {_vehicle getVariable ["tts_cloak_isCloaked", false] && alive _vehicle} do {
		waitUntil {sleep 0.5; isNull curatorCamera};
		sleep 0.1;
		_pipCamera cameraEffect ['INTERNAL', 'BACK', _renderSurfaceID];
		_pipCamera camCommit 0;	
		waitUntil {sleep 0.5; !isNull curatorCamera};
	};
};

// spectator
[_vehicle, _pipCamera, _renderSurfaceID] spawn {
	params ["_vehicle", "_pipCamera", "_renderSurfaceID"];
	while {_vehicle getVariable ["tts_cloak_isCloaked", false] && alive _vehicle} do {
		waitUntil {sleep 0.5; isNull (findDisplay 60492)};
		sleep 0.1;
		_pipCamera cameraEffect ['INTERNAL', 'BACK', _renderSurfaceID];
		_pipCamera camCommit 0;	
		waitUntil {sleep 0.5; !isNull (findDisplay 60492)};
	};
};

// wait until vehicle becomes uncloaked or destroyed
waitUntil {sleep 0.05; !(_vehicle getVariable ["tts_cloak_isCloaked", false]) || !alive _vehicle};

// restore original textures
{
	_vehicle setObjectTextureGlobal [_forEachIndex, _x];
} forEach _hiddenSelections;