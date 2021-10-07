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
		displayName = "Cloak Settings";
		icon = "tts_cloak\icons\tts_settings.paa";
		category = "tts_cloak_modules";
		function = "tts_cloak_fnc_editor_moduleCloakSettings";
		
		class Attributes : AttributesBase {
			class Uniforms : Edit {
				property = "tts_cloak_moduleCloakSettings_Uniforms";
				displayName = "Cloak uniforms";
				tooltip = "Uniforms considered 'cloaking' uniforms seperated by commas (without spaces)";
				typeName = "STRING";
				defaultValue = """""";
			};
			class Headgear : Edit {
				property = "tts_cloak_moduleCloakSettings_Headgear";
				displayName = "Cloak headgear";
				tooltip = "Headgear considered 'cloaking' headgear seperated by commas (without spaces)";
				typeName = "STRING";
				defaultValue = """""";
			};
			class RequireHolstered : Checkbox {
				property = "tts_cloak_moduleCloakSettings_RequireHolstered";
				displayName = "Require holstered";
				tooltip = "Does the player need to put their gun away to cloak?";
				defaultValue = "1";
			};
			class DecloakOnFired : Checkbox {
				property = "tts_cloak_moduleCloakSettings_DecloakOnFired";
				displayName = "Decloak when firing";
				tooltip = "Does the cloak automatically shut down when a weapon is used?";
				defaultValue = "1";
			};
			class PlaySounds : Checkbox {
				property = "tts_cloak_moduleCloakSettings_PlaySounds";
				displayName = "Play sounds";
				tooltip = "Should cloak in/out sound effects be used?";
				defaultValue = "1";
			};
			class PlayVoice : Checkbox {
				property = "tts_cloak_moduleCloakSettings_PlayVoice";
				displayName = "Play voice";
				tooltip = "Should 'cloak engaged' voice play on entering cloak?";
				defaultValue = "1";
			};
			class UseUI : Checkbox {
				property = "tts_cloak_moduleCloakSettings_UseUI";
				displayName = "Use UI";
				tooltip = "Should the cloak UI be available to players?";
				defaultValue = "1";
			};
			class UseVehicleUI : Checkbox {
				property = "tts_cloak_moduleCloakSettings_UseVehicleUI";
				displayName = "Use vehicle UI";
				tooltip = "Should the active camo UI be available to players?";
				defaultValue = "1";
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Configures settings for TTS Cloak script."; // Short description, will be formatted as structured text
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
		function = "tts_cloak_fnc_editor_moduleGiveCloak";
		
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
		isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		displayName = "Give Cloak";
		icon = "tts_cloak\icons\cloak_man.paa";
		category = "tts_cloak_modules";
		function = "tts_cloak_fnc_editor_moduleGiveCloakV2";
		
		class Attributes : AttributesBase {
			class Duration : Edit {
				property = "tts_cloak_moduleGiveCloakV2_Duration";
				displayName = "Cloak duration";
				tooltip = "Maximum duration unit can remain cloaked before automatically uncloaking";
				typeName = "NUMBER";
				defaultValue = "30";
			};
			class Cooldown : Edit {
				property = "tts_cloak_moduleGiveCloakV2_Cooldown";
				displayName = "Cloak cooldown";
				tooltip = "Cloak cooldown ";
				typeName = "NUMBER";
				defaultValue = "60";
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Gives player units the ability to cloak.";
		};
	};

	class tts_cloak_moduleGiveVehicleCloak : tts_cloak_module {
		scope = 2;
		scopeCurator = 0; // module is not available in Zeus
		isDisposable = 1; // 1 if modules is to be disabled once it's activated (i.e., repeated trigger activation won't work)
		isGlobal = 0; // 0 for server only execution, 1 for global execution, 2 for persistent global execution
		isTriggerActivated = 0;
		displayName = "Give Vehicle Cloak";
		category = "tts_cloak_modules";
		icon = "tts_cloak\icons\cloak_vehicle.paa";
		function = "tts_cloak_fnc_editor_moduleGiveVehicleCloak";
		
		class Attributes : AttributesBase {
			class Identifier: Edit
			{
				property = "tts_cloak_moduleGiveVehicleCloak_Identifier";
				displayName = "Unique Identifier";
				tooltip = "Unique string used to manage PIP textures, having 2 cloak vehicles with the same identifier may cause strange behaviour";
				typeName = "STRING";
				defaultValue = """uniqueString""";
			};
			class Duration : Edit {
				property = "tts_cloak_moduleGiveVehicleCloak_Duration";
				displayName = "Cloak duration";
				tooltip = "Maximum duration vehicle can remain cloaked before automatically uncloaking";
				typeName = "NUMBER";
				defaultValue = "30";
			};
			class Cooldown : Edit {
				property = "tts_cloak_moduleGiveVehicleCloak_Cooldown";
				displayName = "Cloak cooldown";
				tooltip = "Cloak cooldown ";
				typeName = "NUMBER";
				defaultValue = "60";
			};
			class ModuleDescription: ModuleDescription{};
		};

		class ModuleDescription: ModuleDescription
		{
			description = "Gives vehicle the ability to cloak. Only one vehicle can be synced per module."; // Short description, will be formatted as structured text
			sync[] = {"AllVehicles"};

			class AnyVehicle
			{
				description[] = {
					"Vehicle cloak is assigned to"
				};
				position = 0;
				direction = 0; 
				optional = 0; 
				duplicate = 0;
				synced[] = {"AnyVehicle"};
			};
		};
	};

}