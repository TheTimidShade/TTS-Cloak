class CfgVehicles {
	class Logic;
	class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
			class CheckboxNumber;
			class ModuleDescription;
			class Units;
		};
		class ModuleDescription;
	};
	
	class tts_cloak_module : Module_F {
		author = "TheTimidShade";
		scope = 1;
		scopeCurator = 1;
		is3DEN = 0;
		displayName = "TheTimidShade's Module";
		vehicleClass = "Modules";
		category = "tts_cloak_modules";
	};
	
	class tts_cloak_moduleCloakSettings : tts_cloak_module {
		scope = 2;
		scopeCurator = 0; // module is not available in Zeus
		isDisposable = 1; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isGlobal = 1; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		displayName = "$STR_tts_cloak_moduleChangeSettings_title_alt";
		icon = "tts_cloak\icons\tts_settings.paa";
		category = "tts_cloak_modules";
		function = "tts_cloak_fnc_moduleCloakSettings";
		functionPriority = 1;
		
		class Attributes : AttributesBase {
			class Uniforms : Edit {
				property = "tts_cloak_moduleCloakSettings_Uniforms";
				displayName = "$STR_tts_cloak_moduleChangeSettings_uniform";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_uniform_desc";
				typeName = "STRING";
				defaultValue = """""";
			};
			class Headgear : Edit {
				property = "tts_cloak_moduleCloakSettings_Headgear";
				displayName = "$STR_tts_cloak_moduleChangeSettings_headgear";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_headgear_desc";
				typeName = "STRING";
				defaultValue = """""";
			};
			class RequireHolstered : Checkbox {
				property = "tts_cloak_moduleCloakSettings_RequireHolstered";
				displayName = "$STR_tts_cloak_moduleChangeSettings_requireHolstered";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_requireHolstered_desc";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class DecloakOnFired : Checkbox {
				property = "tts_cloak_moduleCloakSettings_DecloakOnFired";
				displayName = "$STR_tts_cloak_moduleChangeSettings_decloakOnFire";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_decloakOnFire_desc";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class PlaySounds : Checkbox {
				property = "tts_cloak_moduleCloakSettings_PlaySounds";
				displayName = "$STR_tts_cloak_moduleChangeSettings_playSounds";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_playSounds_desc";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class PlayVoice : Checkbox {
				property = "tts_cloak_moduleCloakSettings_PlayVoice";
				displayName = "$STR_tts_cloak_moduleChangeSettings_playVoice";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_playVoice_desc";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class UseUI : Checkbox {
				property = "tts_cloak_moduleCloakSettings_UseUI";
				displayName = "$STR_tts_cloak_moduleChangeSettings_useUI";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_useUI_desc";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class UseVehicleUI : Checkbox {
				property = "tts_cloak_moduleCloakSettings_UseVehicleUI";
				displayName = "$STR_tts_cloak_moduleChangeSettings_useVehicleUI";
				tooltip = "$STR_tts_cloak_moduleChangeSettings_useVehicleUI_desc";
				typeName = "BOOL";
				defaultValue = "true";
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "$STR_tts_cloak_moduleChangeSettings_desc"; // Short description, will be formatted as structured text
		};
	};

	class tts_cloak_moduleGiveCloak : tts_cloak_module {
		scope = 1;
		scopeCurator = 0; // module is not available in Zeus
		isDisposable = 1; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		displayName = "Give Cloak (OLD)";
		icon = "tts_cloak\icons\cloak_man.paa";
		category = "tts_cloak_modules";
		function = "tts_cloak_fnc_moduleGiveCloak";
		functionPriority = 2;
		
		class Attributes : AttributesBase {
			class CloakUnits: Edit
			{
				property = "tts_cloak_moduleGiveCloak_CloakUnits";
				displayName = "Units";
				tooltip = "Variable names of units to give cloak abilities to seperated by commas (without spaces)";
				typeName = "STRING";
				defaultValue = """unit1,unit2""";
			};
			class Duration : Edit {
				property = "tts_cloak_moduleGiveCloak_Duration";
				displayName = "Cloak duration";
				tooltip = "Maximum duration unit can remain cloaked before automatically uncloaking";
				typeName = "NUMBER";
				defaultValue = "30";
			};
			class Cooldown : Edit {
				property = "tts_cloak_moduleGiveCloak_Cooldown";
				displayName = "Cloak cooldown";
				tooltip = "Cloak cooldown ";
				typeName = "NUMBER";
				defaultValue = "60";
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Gives units the ability to cloak.";
		};
	};

	class tts_cloak_moduleGiveCloakV2 : tts_cloak_module {
		scope = 2;
		scopeCurator = 0; // module is not available in Zeus
		isDisposable = 1; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isGlobal = 2; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		displayName = "$STR_tts_cloak_moduleGiveCloak_title";
		icon = "tts_cloak\icons\cloak_man.paa";
		category = "tts_cloak_modules";
		function = "tts_cloak_fnc_moduleGiveCloakV2";
		functionPriority = 2;
		
		class Attributes : AttributesBase {
			class Duration : Edit {
				property = "tts_cloak_moduleGiveCloakV2_Duration";
				displayName = "$STR_tts_cloak_moduleGiveCloak_maxDuration";
				tooltip = "$STR_tts_cloak_moduleGiveCloak_maxDuration_desc";
				typeName = "NUMBER";
				defaultValue = "30";
			};
			class Cooldown : Edit {
				property = "tts_cloak_moduleGiveCloakV2_Cooldown";
				displayName = "$STR_tts_cloak_moduleGiveCloak_cooldown";
				tooltip = "$STR_tts_cloak_moduleGiveCloak_cooldown_desc";
				typeName = "NUMBER";
				defaultValue = "60";
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "$STR_tts_cloak_moduleGiveCloak_desc";
		};
	};

	class tts_cloak_moduleGiveVehicleCloak : tts_cloak_module {
		scope = 2;
		scopeCurator = 0; // module is not available in Zeus
		isDisposable = 1; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		displayName = "$STR_tts_cloak_moduleGiveVehicleCloak_title";
		category = "tts_cloak_modules";
		icon = "tts_cloak\icons\cloak_vehicle.paa";
		function = "tts_cloak_fnc_moduleGiveVehicleCloak";
		functionPriority = 2;
		
		class Attributes : AttributesBase {
			class Identifier: Edit
			{
				property = "tts_cloak_moduleGiveVehicleCloak_Identifier";
				displayName = "$STR_tts_cloak_moduleGiveVehicleCloak_identifier";
				tooltip = "$STR_tts_cloak_moduleGiveVehicleCloak_identifier_desc";
				typeName = "STRING";
				defaultValue = """uniqueString""";
			};
			class Duration : Edit {
				property = "tts_cloak_moduleGiveVehicleCloak_Duration";
				displayName = "$STR_tts_cloak_moduleGiveVehicleCloak_maxDuration";
				tooltip = "$STR_tts_cloak_moduleGiveVehicleCloak_maxDuration_desc";
				typeName = "NUMBER";
				defaultValue = "30";
			};
			class Cooldown : Edit {
				property = "tts_cloak_moduleGiveVehicleCloak_Cooldown";
				displayName = "$STR_tts_cloak_moduleGiveVehicleCloak_cooldown";
				tooltip = "$STR_tts_cloak_moduleGiveVehicleCloak_cooldown_desc";
				typeName = "NUMBER";
				defaultValue = "60";
			};
			class ModuleDescription: ModuleDescription {};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "$STR_tts_cloak_moduleGiveVehicleCloak_desc"; // Short description, will be formatted as structured text
		};
	};

}