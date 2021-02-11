//--- CLOAK_UI
#define IDC_CLOAK_UI_CLOAK_DISP_TEXT			1100
#define IDC_CLOAK_UI_CLOAK_DISP_VEHICLE_TEXT	1101

class tts_cloak_ui
{
	idd = 2646;
	duration = 9999999999999;
	fadein = 0;
	fadeout = 0;
	movingEnable = false;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['tts_cloak_cloakDisplay', _this#0]";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by TheTimidShade, v1.063, #Wazogo)
		////////////////////////////////////////////////////////

		class CLOAK_DISP_TEXT: RscCloakStructuredText
		{
			idc = IDC_CLOAK_UI_CLOAK_DISP_TEXT;
			text = "CLOAK:"; //--- ToDo: Localize;
			x = 0.025625 * safezoneW + safezoneX;
			y = 0.929 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};

class tts_cloak_ui_vehicle
{
	idd = 2647;
	duration = 9999999999999;
	fadein = 0;
	fadeout = 0;
	movingEnable = false;
	enableSimulation = 1;
	onLoad = "uiNamespace setVariable ['tts_cloak_cloakDisplayVehicle', _this#0]";
	class controls
	{
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by TheTimidShade, v1.063, #Wazogo)
		////////////////////////////////////////////////////////

		class CLOAK_DISP_VEHICLE_TEXT: RscCloakStructuredText
		{
			idc = IDC_CLOAK_UI_CLOAK_DISP_VEHICLE_TEXT;
			text = "CAMO:"; //--- ToDo: Localize;
			x = 0.025625 * safezoneW + safezoneX;
			y = 0.906652 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.022 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
