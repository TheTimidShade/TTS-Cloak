// ACHILLES /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "achilles_modules_f_achilles")) then {
	["TTS Cloaking", "Change Settings", 
	{
		params [["_position", [0,0,0], [[]], 3], ["_objectUnderCursor", objNull, [objNull]]];

		// set up settings if they are undefined
		if (isNil "tts_cloak_uniforms") then {tts_cloak_uniforms = [""];};
		if (isNil "tts_cloak_headgear") then {tts_cloak_headgear = [""];};
		if (isNil "tts_cloak_requireHolstered") then {tts_cloak_requireHolstered = true;};
		if (isNil "tts_cloak_decloakOnFired") then {tts_cloak_decloakOnFired = true;};
		if (isNil "tts_cloak_playSounds") then {tts_cloak_playSounds = true;};
		if (isNil "tts_cloak_playVoice") then {tts_cloak_playVoice = true;};
		if (isNil "tts_cloak_useUI") then {tts_cloak_useUI = true;};
		if (isNil "tts_cloak_useUIVehicle") then {tts_cloak_useUIVehicle = true;};

		private _dialogResult = [
			"Configure Cloak Settings",
			[
				["Cloak uniforms", "", str tts_cloak_uniforms, true],
				["Cloak headgear", "", str tts_cloak_headgear, true],
				["Require holstered", ["True", "False"], 0],
				["Decloak when firing", ["True", "False"], 0],
				["Play sounds", ["True", "False"], 0],
				["Play voice", ["True", "False"], 0],
				["Use UI", ["True", "False"], 0],
				["Use vehicle UI", ["True", "False"], 0]
			]
		] call Ares_fnc_showChooseDialog;

		if (_dialogResult isEqualTo []) exitWith{}; // if dialog was closed exit

		private _fnc_indexToBool = {if (_this == 0) then {true} else {false}};

		tts_cloak_uniforms = parseSimpleArray (_dialogResult#0);
		tts_cloak_headgear = parseSimpleArray (_dialogResult#1);
		tts_cloak_requireHolstered = (_dialogResult#2) call _fnc_indexToBool;
		tts_cloak_decloakOnFired = (_dialogResult#3) call _fnc_indexToBool;
		tts_cloak_playSounds = (_dialogResult#4) call _fnc_indexToBool;
		tts_cloak_playVoice = (_dialogResult#5) call _fnc_indexToBool;
		tts_cloak_useUI = (_dialogResult#6) call _fnc_indexToBool;
		tts_cloak_useUIVehicle = (_dialogResult#7) call _fnc_indexToBool;

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
	}] call Ares_fnc_RegisterCustomModule;
};

// ZEUS ENHANCED ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (isClass (configFile >> "CfgPatches" >> "zen_main")) then {
	["TTS Cloaking", "Change Settings",
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
			"Configure Cloak Settings", // title
		 	[ // array of controls for dialog
				["EDIT", ["Cloak uniforms", "Uniforms considered 'cloaking' uniforms"],
					[ // control args
						str tts_cloak_uniforms, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["EDIT", ["Cloak headgear", "Headgear considered 'cloaking' headgear"],
					[ // control args
						str tts_cloak_headgear, // default text
						{}, // sanitise function
						1 // edit box height (only for multi line)
					],
					true // force default
				],
				["COMBO", ["Require holstered", "Does the player need to put their gun away to cloak?"],
					[ // control args
						[true, false], // return values
						["True", "False"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["Decloak when firing", "Does the cloak automatically shut down when a weapon is used?"],
					[ // control args
						[true, false], // return values
						["True", "False"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["Play sounds", "Should cloak in/out sound effects be used?"],
					[ // control args
						[true, false], // return values
						["True", "False"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["Play voice", "Should 'cloak engaged' voice play on entering cloak?"],
					[ // control args
						[true, false], // return values
						["True", "False"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["Use UI", "Should the cloak UI be available to players?"],
					[ // control args
						[true, false], // return values
						["True", "False"], // labels
						0 // element 0 is default selected
					]
				],
				["COMBO", ["Use vehicle UI", "Should the active camo UI be available to players?"],
					[ // control args
						[true, false], // return values
						["True", "False"], // labels
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
	}] call zen_custom_modules_fnc_register;
};