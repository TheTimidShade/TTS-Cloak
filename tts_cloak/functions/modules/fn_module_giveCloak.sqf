// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloak", "STR_tts_cloak_moduleGiveCloak_title",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !isPlayer _attachedObject) exitWith {
			["STR_tts_cloak_moduleGiveCloak_placeOnPlayer"] call zen_common_fnc_showMessage;
		};

		[
			"STR_tts_cloak_moduleGiveCloak_title", // title
		 	[ // array of controls for dialog
				["EDIT", ["STR_tts_cloak_moduleGiveCloak_maxDuration", "STR_tts_cloak_moduleGiveCloak_maxDuration_desc"],
					[ // control args
						str 30, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				],
				["EDIT", ["STR_tts_cloak_moduleGiveCloak_cooldown", "STR_tts_cloak_moduleGiveCloak_cooldown_desc"],
					[ // control args
						str 60, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				]
			],
			{ // code run on dialog closed (only run if OK is clicked)
				params ["_dialogResult", "_args"];
				_args params ["_attachedObject"];
				
				[_attachedObject, parseNumber (_dialogResult#0), parseNumber (_dialogResult#1)] remoteExec ["tts_cloak_fnc_giveCloak", _attachedObject, false];
			}, {}, [_attachedObject] // args
		] call zen_dialog_fnc_create;
	}, "tts_cloak\icons\cloak_man.paa"] call zen_custom_modules_fnc_register;
};