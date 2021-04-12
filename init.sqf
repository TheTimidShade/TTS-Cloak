// set up settings
tts_cloak_uniforms = ["U_O_CombatUniform_oucamo"];
tts_cloak_headgear = ["H_HelmetLeaderO_oucamo"];
tts_cloak_requireHolstered = true;
tts_cloak_decloakOnFired = true;
tts_cloak_playSounds = true;
tts_cloak_playVoice = true;
tts_cloak_useUI = true;
tts_cloak_useUIVehicle = true;

// vehicle cloaking example
/*
if (isServer) then {
	[vehicle1, "vehicle1", 30, 5] spawn tts_cloak_fnc_giveVehicleCloak;
	[vehicle2, "vehicle2", 30, 5] spawn tts_cloak_fnc_giveVehicleCloak;
};
*/