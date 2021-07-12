// ACHILLES /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) then {
	["TTS Cloaking", "Give Active Camouflage", 
	{
		params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

		if (isNull _objectUnderCursor || !(_objectUnderCursor isKindOf "AllVehicles") || _objectUnderCursor isKindOf "CAManBase") exitWith {
			["Must be placed on a vehicle!"] call Achilles_fnc_showZeusErrorMessage;
		};

		private _dialogResult = [
			"Give Active Camouflage",
			[
				["Unique identifier", "", "", true],
				["Camo max duration", "", str 120, false],
				["Camo cooldown", "", str 300, false]
			]
		] call Ares_fnc_showChooseDialog;

		if (_dialogResult isEqualTo []) exitWith{}; // if dialog was closed exit
		if (_dialogResult#0 == "") exitWith {
			["Identifier must be unique, non-empty string!"] call Achilles_fnc_showZeusErrorMessage;
		};

		[_objectUnderCursor, (_dialogResult#0), parseNumber (_dialogResult#1), parseNumber (_dialogResult#2)] remoteExec ["tts_cloak_fnc_giveVehicleCloak", 2, false];
	}] call Ares_fnc_RegisterCustomModule;
};

// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloaking", "Give Active Camouflage",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "AllVehicles") || _attachedObject isKindOf "CAManBase") exitWith {
			["Must be placed on a vehicle!"] call zen_common_fnc_showMessage;
		};

		[
			"Give Active Camouflage", // title
		 	[ // array of controls for dialog
				["EDIT", ["Unique identifier", "Unique identifier used by script to handle PIP textures"],
					[ // control args
						"", // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["EDIT", ["Camo max duration", "Maximum time vehicle can use active camo before automatic deactivation"],
					[ // control args
						str 120, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				],
				["EDIT", ["Camo cooldown", "Cooldown period required after vehicle deactivates camouflage before it can be used again"],
					[ // control args
						str 300, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				]
			],
			{ // code run on dialog closed (only run if OK is clicked)
				params ["_dialogResult", "_args"];
				_args params ["_attachedObject"];
				
				if (_dialogResult#0 == "") exitWith {
					["Identifier must be unique, non-empty string!"] call zen_common_fnc_showMessage;
				};

				[_attachedObject, (_dialogResult#0), parseNumber (_dialogResult#1), parseNumber (_dialogResult#2)] remoteExec ["tts_cloak_fnc_giveVehicleCloak", 2, false];
			}, {}, [_attachedObject] // args
		] call zen_dialog_fnc_create;
	}] call zen_custom_modules_fnc_register;
};