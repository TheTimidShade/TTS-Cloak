// ACHILLES /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) then {
	["TTS Cloaking", "Cloak Unit", 
	{
		params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

		if (isNull _objectUnderCursor || !(_objectUnderCursor isKindOf "CAManBase")) exitWith {
			["Must be placed on a unit!"] call Achilles_fnc_showZeusErrorMessage;
		};

		private _dialogResult = [
			"Cloak Unit",
			[
				["Cloak duration", "", str 30, false]
			]
		] call Ares_fnc_showChooseDialog;

		if (_dialogResult isEqualTo []) exitWith{}; // if dialog was closed exit

		[_objectUnderCursor, parseNumber (_dialogResult#0)] remoteExec ["tts_cloak_fnc_cloakAI", _objectUnderCursor, false];
	}] call Ares_fnc_RegisterCustomModule;
};

// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloaking", "Cloak Unit",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "CAManBase")) exitWith {
			["Must be placed on a unit!"] call zen_common_fnc_showMessage;
		};

		[
			"Cloak Unit", // title
		 	[ // array of controls for dialog
				["EDIT", ["Cloak duration", "Time in seconds to cloak unit for"],
					[ // control args
						str 30, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				]
			],
			{ // code run on dialog closed (only run if OK is clicked)
				params ["_dialogResult", "_args"];
				_args params ["_attachedObject"];
				
				[_attachedObject, parseNumber (_dialogResult#0)] remoteExec ["tts_cloak_fnc_cloakAI", _attachedObject, false];
			}, {}, [_attachedObject] // args
		] call zen_dialog_fnc_create;
	}] call zen_custom_modules_fnc_register;
};