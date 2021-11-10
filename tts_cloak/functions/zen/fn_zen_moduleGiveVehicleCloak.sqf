["TTS Cloak", "STR_tts_cloak_moduleGiveVehicleCloak_title",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	if (isNull _attachedObject || !(_attachedObject isKindOf "AllVehicles") || _attachedObject isKindOf "CAManBase") exitWith {
		["STR_tts_cloak_moduleGiveVehicleCloak_placeOnVehicle"] call zen_common_fnc_showMessage;
	};

	[
		"STR_tts_cloak_moduleGiveVehicleCloak_title", // title
		[ // array of controls for dialog
			["EDIT", ["STR_tts_cloak_moduleGiveVehicleCloak_identifier", "STR_tts_cloak_moduleGiveVehicleCloak_identifier_desc"],
				[ // control args
					"", // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				true // force default
			],
			["EDIT", ["STR_tts_cloak_moduleGiveVehicleCloak_maxDuration", "STR_tts_cloak_moduleGiveVehicleCloak_maxDuration_desc"],
				[ // control args
					str 120, // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				false // force default
			],
			["EDIT", ["STR_tts_cloak_moduleGiveVehicleCloak_cooldown", "STR_tts_cloak_moduleGiveVehicleCloak_cooldown_desc"],
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
				["STR_tts_cloak_moduleGiveVehicleCloak_identifier_warning"] call zen_common_fnc_showMessage;
			};

			[_attachedObject, (_dialogResult#0), parseNumber (_dialogResult#1), parseNumber (_dialogResult#2)] remoteExec ["tts_cloak_fnc_giveVehicleCloak", 2, false];
		}, {}, [_attachedObject] // args
	] call zen_dialog_fnc_create;
}, "\tts_cloak\icons\cloak_vehicle.paa"] call zen_custom_modules_fnc_register;
