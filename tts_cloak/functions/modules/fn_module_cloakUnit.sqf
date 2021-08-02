// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloaking", "Cloak Unit(s)",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		if (isNull _attachedObject || !(_attachedObject isKindOf "CAManBase")) exitWith {
			["Must be placed on a unit!"] call zen_common_fnc_showMessage;
		};

		[
			"Cloak Unit(s)", // title
		 	[ // array of controls for dialog
				["EDIT", ["Cloak duration", "Time in seconds to cloak unit for"],
					[ // control args
						str 30, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					false // force default
				],
				["CHECKBOX", ["Apply to group", "If checked, all members in the unit's group will be cloaked"],
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
	}, "tts_cloak\icons\cloak_man.paa"] call zen_custom_modules_fnc_register;
};