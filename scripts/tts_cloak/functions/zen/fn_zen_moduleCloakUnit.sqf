["TTS Cloak", "STR_tts_cloak_moduleCloakUnits_title",
{
	params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

	if (isNull _attachedObject || !(_attachedObject isKindOf "CAManBase")) exitWith {
		["STR_tts_cloak_moduleCloakUnits_placeOnUnit"] call zen_common_fnc_showMessage;
	};

	[
		"STR_tts_cloak_moduleCloakUnits_title", // title
		[ // array of controls for dialog
			["EDIT", ["STR_tts_cloak_moduleCloakUnits_duration", "STR_tts_cloak_moduleCloakUnits_duration_desc"],
				[ // control args
					str 30, // default text
					{}, // sanitise function
					1 // edit box height (only for multi line)
				],
				false // force default
			],
			["CHECKBOX", ["STR_tts_cloak_moduleCloakUnits_applyToGroup", "STR_tts_cloak_moduleCloakUnits_applyToGroup_desc"],
				[ // control args
					false // default state
				]
			]
		],
		{ // code run on dialog closed (only run if OK is clicked)
			params ["_dialogResult", "_args"];
			_args params ["_attachedObject"];
			_dialogResult params ["_duration", "_applyToGroup"];
			_duration = parseNumber _duration;

			if (_applyToGroup) then {
				{[_x, _duration] remoteExec ["tts_cloak_fnc_cloakAI", _x, false]} forEach units (group _attachedObject);
			} else {
				[_attachedObject, _duration] remoteExec ["tts_cloak_fnc_cloakAI", _attachedObject, false];
			};
			
		}, {}, [_attachedObject] // args
	] call zen_dialog_fnc_create;
}, "scripts\tts_cloak\icons\cloak_man.paa"] call zen_custom_modules_fnc_register;
