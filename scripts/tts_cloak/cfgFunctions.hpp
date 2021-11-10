class tts_cloak
{
	class cloak
	{
		file = "scripts\tts_cloak\functions";
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
		class addCloakActions {};
		class addVehicleCloakActions {};
	};
	class zen {
		file = "scripts\tts_cloak\functions\zen";
		class initCustomModules {};
		class zen_moduleChangeSettings {};
		class zen_moduleGiveCloak {};
		class zen_moduleRemoveCloak {};
		class zen_moduleCloakUnit {};
		class zen_moduleGiveVehicleCloak {};
	};
};
