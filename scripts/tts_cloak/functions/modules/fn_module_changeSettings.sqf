// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloak", "STR_tts_cloak_moduleChangeSettings_title",
	{
		params [["_position", [0,0,0], [[]], 3], ["_attachedObject", objNull, [objNull]]];

		// set up settings if they are undefined
		if (isNil "tts_cloak_uniforms") then {tts_cloak_uniforms = [""];};
		if (isNil "tts_cloak_headgear") then {tts_cloak_headgear = [""];};
		if (isNil "tts_cloak_requireHolstered") then {tts_cloak_requireHolstered = true;};
		if (isNil "tts_cloak_decloakOnFired") then {tts_cloak_decloakOnFired = true;};
		if (isNil "tts_cloak_playSounds") then {tts_cloak_playSounds = true;};
		if (isNil "tts_cloak_playVoice") then {tts_cloak_playVoice = true;};
		if (isNil "tts_cloak_useUI") then {tts_cloak_useUI = true;};
		if (isNil "tts_cloak_useUIVehicle") then {tts_cloak_useUIVehicle = true;};

		[
			"STR_tts_cloak_moduleChangeSettings_heading", // title
		 	[ // array of controls for dialog
				["EDIT", ["STR_tts_cloak_moduleChangeSettings_uniform", "STR_tts_cloak_moduleChangeSettings_uniform_desc"],
					[ // control args
						str tts_cloak_uniforms, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["EDIT", ["STR_tts_cloak_moduleChangeSettings_headgear", "STR_tts_cloak_moduleChangeSettings_headgear_desc"],
					[ // control args
						str tts_cloak_headgear, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["COMBO", ["STR_tts_cloak_moduleChangeSettings_requireHolstered", "STR_tts_cloak_moduleChangeSettings_requireHolstered_desc"],
					[ // control args
						[true, false], // return values
						["STR_tts_cloak_true", "STR_tts_cloak_false"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["STR_tts_cloak_moduleChangeSettings_decloakOnFire", "STR_tts_cloak_moduleChangeSettings_decloakOnFire_desc"],
					[ // control args
						[true, false], // return values
						["STR_tts_cloak_true", "STR_tts_cloak_false"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["STR_tts_cloak_moduleChangeSettings_playSounds", "STR_tts_cloak_moduleChangeSettings_playSounds_desc"],
					[ // control args
						[true, false], // return values
						["STR_tts_cloak_true", "STR_tts_cloak_false"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["STR_tts_cloak_moduleChangeSettings_playVoice", "STR_tts_cloak_moduleChangeSettings_playVoice_desc"],
					[ // control args
						[true, false], // return values
						["STR_tts_cloak_true", "STR_tts_cloak_false"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["STR_tts_cloak_moduleChangeSettings_useUI", "STR_tts_cloak_moduleChangeSettings_useUI_desc"],
					[ // control args
						[true, false], // return values
						["STR_tts_cloak_true", "STR_tts_cloak_false"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["STR_tts_cloak_moduleChangeSettings_useVehicleUI", "STR_tts_cloak_moduleChangeSettings_useVehicleUI_desc"],
					[ // control args
						[true, false], // return values
						["STR_tts_cloak_true", "STR_tts_cloak_false"], // labels
						0 // element 0 is default selected
					]
				]
			],
			{ // code run on dialog closed (only run if OK is clicked)
				params ["_dialogResult", "_args"];
				
				tts_cloak_uniforms = parseSimpleArray (_dialogResult#0);
				tts_cloak_headgear = parseSimpleArray (_dialogResult#1);
				tts_cloak_requireHolstered = _dialogResult#2;
				tts_cloak_decloakOnFired = _dialogResult#3;
				tts_cloak_playSounds = _dialogResult#4;
				tts_cloak_playVoice = _dialogResult#5;
				tts_cloak_useUI = _dialogResult#6;
				tts_cloak_useUIVehicle = _dialogResult#7;

				{publicVariable _x;} forEach [ // publish settings to all clients
					"tts_cloak_uniforms",
					"tts_cloak_headgear",
					"tts_cloak_requireHolstered",
					"tts_cloak_decloakOnFired",
					"tts_cloak_playSounds",
					"tts_cloak_playVoice",
					"tts_cloak_useUI",
					"tts_cloak_useUIVehicle"
				];
			}, {}, [] // args
		] call zen_dialog_fnc_create;
	}, "scripts\tts_cloak\icons\tts_settings.paa"] call zen_custom_modules_fnc_register;
};