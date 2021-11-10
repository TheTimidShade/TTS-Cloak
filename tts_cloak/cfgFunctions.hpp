class tts_cloak
{
	class cloak
	{
		file = "tts_cloak\functions";
		class init { postInit = 1; };
		class initCloak {};
		class hasCloak {};
		class startCloak {};
		class cloakParticles {};
		class cloakTransition {};
		class updateCloakDisplay {};
		class giveCloak {};
		class removeCloak {};
		class cloakAI {};
		class giveVehicleCloak {};
		class startVehicleCloak {};
		class setupPIPcamera {};
		class updateCloakDisplayVehicle {};
		class vehicleCloakEffect {};
		class setupModuleCloaks {postInit = 1;};
		class addCloakActions {};
		class addVehicleCloakActions {};
	};
	class zen
	{
		file = "tts_cloak\functions\zen";
		class initCustomModules {};
		class zen_moduleChangeSettings {};
		class zen_moduleGiveCloak {};
		class zen_moduleRemoveCloak {};
		class zen_moduleCloakUnit {};
		class zen_moduleGiveVehicleCloak {};
	};
	class modules
	{
		file = "tts_cloak\functions\modules";
		class moduleCloakSettings {};
		class moduleGiveCloak {};
		class moduleGiveCloakV2 {};
		class moduleGiveVehicleCloak {};
	};
};
