// ACHILLES /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) then {
	["TTS Cloaking", "Remove Cloak", 
	{
		params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

		if (isNull _objectUnderCursor || !(_objectUnderCursor isKindOf "CAManBase")) exitWith {
			["Must be placed on a unit!"] call Achilles_fnc_showZeusErrorMessage;
		};

		[_objectUnderCursor] remoteExec ["tts_cloak_fnc_removeCloak", _objectUnderCursor, false];
	}] call Ares_fnc_RegisterCustomModule;
};

// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloaking", "Remove Cloak",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "CAManBase")) exitWith {
			["Must be placed on a unit!"] call zen_common_fnc_showMessage;
		};

		[_attachedObject] remoteExec ["tts_cloak_fnc_removeCloak", _attachedObject, false];
	}] call zen_custom_modules_fnc_register;
};