class tts_cloak
{
	class cloak
	{
		file = "scripts\tts_cloak\functions";
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
		class addCloakActions {};
		class addVehicleCloakActions {};
	};
	class modules {
		file = "scripts\tts_cloak\functions\modules";
		class module_changeSettings {};
		class module_giveCloak {};
		class module_removeCloak {};
		class module_cloakUnit {};
		class module_giveVehicleCloak {};
	};
};
