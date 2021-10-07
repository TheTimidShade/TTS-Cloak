class tts_cloak
{
	class cloak
	{
		file = "tts_cloak\functions";
		class initCloak {postInit = 1;};
		class hasCloak {};
		class startCloak {};
		class cloakParticles {};
		class cloakTransition {};
		class updateCloakDisplay {};
		class giveCloak {};
		class removeCloak {};
		class cloakAI {};
		class customZeusModules {preInit = 1;};
		class giveVehicleCloak {};
		class startVehicleCloak {};
		class setupPIPcamera {};
		class updateCloakDisplayVehicle {};
		class vehicleCloakEffect {};
		class setupModuleCloaks {postInit = 1;};
	};
	class modules {
		file = "tts_cloak\functions\modules";
		class module_changeSettings {};
		class module_giveCloak {};
		class module_removeCloak {};
		class module_cloakUnit {};
		class module_giveVehicleCloak {};
	};
	class editorModules {
		file = "tts_cloak\functions\editorModules";
		class editor_moduleCloakSettings {};
		class editor_moduleGiveCloak {};
		class editor_moduleGiveCloakV2 {};
		class editor_moduleGiveVehicleCloak {};
	};
};
