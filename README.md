# TTS Cloak Script
Cloak script for Arma 3, allows player and AI units to use a Predator/Crysis style cloaking device that distorts the world behind them. Also includes a vehicle active camo ability thanks to Twiznak.

A [mod version](https://steamcommunity.com/sharedfiles/filedetails/?id=2544778197) is also available on the Steam Workshop.

### **FEATURES:**
- Configurable settings so you can use the script how you like
- Small display to keep track of cloak status
- Cloak activation/deactivation sounds
- AI will not detect cloaked units
- Can cloak AI units
- Vehicle active camouflage (Thanks to Twiznak)
- Designed for multiplayer and tested on dedicated server
- Compatible with Zeus Enhanced
- Editor modules to simplify usage (*Mod version only!*)

[Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631) is required to use the module from Zeus.

You can see the script in action in this [demo video](https://www.youtube.com/watch?v=Hasma9EI7sM) or try out the [demo mission](https://steamcommunity.com/sharedfiles/filedetails/?id=2388444766) yourself.

___

### **INTALLATION INSTRUCTIONS:**
1. Download the script files via the green 'Code' button in the top right. Extract the ZIP file somewhere easily accessible.
2. Open your mission folder. You can do this from the 3den Editor using (Scenario > Open Scenario Folder).
3. Copy the 'scripts' folder into your mission folder.
4. If you do not already have an `init.sqf` file in your mission, copy it into your mission folder. If you already have one, copy the contents of my `init.sqf` into yours.
5. If you do not already have a `description.ext` file in your mission, copy it into your mission folder. If you already have one, copy the contents of my `description.ext` into yours. Any 'CfgSomething' classes need to be merged together into one.
e.g.
```cpp
// from TTS Cloak
class CfgFunctions
{
    #include "scripts\tts_cloak\cfgFunctions.hpp"
}
```
and
```cpp
// from TTS Beam Laser
class CfgFunctions
{
    #include "scripts\tts_beam\cfgFunctions.hpp"
}
```
should become
```cpp
// what CfgFunctions should look like when using both
class CfgFunctions
{
    #include "scripts\tts_cloak\cfgFunctions.hpp"
    #include "scripts\tts_beam\cfgFunctions.hpp"
}
```
6. If you do not already have a `stringtable.xml` file in your mission, copy it into your mission folder. If you already have one, copy everything EXCEPT THE FIRST LINE from my `stringtable.xml` into yours.
7. Set up the settings in your `init.sqf` file how you would like (more info on individual settings below)
8. Done! You can now grant a player unit the ability to cloak using 
```sqf
[unit, maxDuration, cooldown] spawn tts_cloak_fnc_giveCloak;
```
Vehicles can be given active camouflage using
```sqf
[vehicle, "uniqueString", maxDuration, cooldown] spawn tts_cloak_fnc_giveVehicleCloak;
```
Alternatively, if you are using Zeus Enhanced you can do this via Zeus modules.

*IMPORTANT*: `tts_cloak_fnc_giveCloak` should be executed on the machine of the player the cloak is being given to and `tts_cloak_fnc_giveVehicleCloak` should only be executed on the server. If you don't know how to do this, see below for some examples you can copy paste!

___

### **SETTINGS:**
Default settings:
```sqf
tts_cloak_uniforms = ["U_O_CombatUniform_oucamo"];
tts_cloak_headgear = ["H_HelmetLeaderO_oucamo"];
tts_cloak_requireHolstered = true;
tts_cloak_decloakOnFired = true;
tts_cloak_playSounds = true;
tts_cloak_playVoice = true;
tts_cloak_useUI = true;
tts_cloak_useUIVehicle = true;
```
**tts_cloak_uniforms/tts_cloak_headgear**  
An array of uniform/headgear classnames. In order to cloak, a player unit must be wearing one of the uniforms/headgear in the array AND been granted the ability to cloak via `tts_cloak_fnc_giveCloak`. If the array contains the empty string (""), that piece of equipment is not required.  
e.g.
```sqf
// Defaults (CSAT uniform/helmet)
tts_cloak_uniforms = ["U_O_CombatUniform_oucamo"];
tts_cloak_headgear = ["H_HelmetLeaderO_oucamo"];
```
```sqf
// Don't require helmet
tts_cloak_uniforms = ["U_O_CombatUniform_oucamo"];
tts_cloak_headgear = [""];
```
```sqf
// Don't require uniform
tts_cloak_uniforms = [""];
tts_cloak_headgear = ["H_HelmetLeaderO_oucamo"];
```

**tts_cloak_requireHolstered**  
If this is true, the player must have all weapons holstered to activate the cloak so activating the 'Activate Cloak' action will holster the player's weapon. False means the player can have an active weapon while cloaked. Default value is true.

**tts_cloak_decloakOnFired**  
If this is true, the player will have their cloak deactivated when they fire their weapon or throw grenades. Default value is true.

**tts_cloak_playSounds**  
If this is true, cloak sounds will be played when cloaking, uncloaking and cloak overheating (same as uncloaking but cloak duration runs out). Default value is true.

**tts_cloak_playVoice**  
If this is true, the 'Cloak Activated' voice sound effect will play when activating the cloak. Default value is true.

**tts_cloak_useUI**  
If this is true, an action will be available that shows/hides a small display in the bottom left corner which shows the cloak status and remaining duration or remaining cooldown. Default value is true.

**tts_cloak_useUIVehicle**  
If this is true, an action will be available that shows/hides a small display in the bottom left corner which shows the active camo status and remaining duration or remaining cooldown of the current vehicle. The action is only shown when in a vehicle that has active camouflage ability granted via `tts_cloak_fnc_giveVehicleCloak`. Default value is true.

___

### **EXAMPLES:**  
*NOTE:* If using these examples in a trigger, the trigger must NOT be server only!  
Give cloak to all players:
```sqf
// put in initPlayerLocal.sqf or trigger 'On Activation' box
// gives all players 30 seconds of cloaking with a 60 second cooldown
// NOTE: player must still have the correct equipment to cloak
[player, 30, 60] spawn tts_cloak_fnc_giveCloak;
```
Give cloak to a subset of players:
```sqf
// put in initPlayerLocal.sqf or trigger 'On Activation' box
// only player slots with variable names 'sf_1', 'sf_2' and 'sf_3' have cloak ability
private _cloakPlayers = ["sf_1", "sf_2", "sf_3"];
if (vehicleVarName player in _cloakPlayers) then {
    [player, 30, 60] spawn tts_cloak_fnc_giveCloak;
};
```
*NOTE:* I don't recommend giving/removing a vehicle's active camouflage ability mid-mission. It seems to cause some strange behaviour, but the option is still available if you need to.

Give active camo to vehicle:
```sqf
// put in init.sqf or trigger 'On Activation' box
// gives 'cloakVic' 2 minutes of active camouflage with a 5 minute cooldown
[cloakVic, "cloakVic", 120, 300] spawn tts_cloak_fnc_giveVehicleCloak;
```
___

### **OTHER FUNCTIONS:**  
*NOTE:* Be careful when using these functions, incorrect use may cause strange behaviour! These are used internally by the scripts/modules but you can use them yourself if you want to.

**tts_cloak_fnc_cloakAI**  
Despite the name this can be used to manually cloak a player or AI unit for a certain duration. If used on a player that has cloak ability, they will be able to disable it before the duration is over. This is used by the 'Cloak Unit' ZEN module.
```
Parameters:  
  0: OBJECT - Unit to cloak  
  1: NUMBER (OPTIONAL) - Duration to cloak unit for in seconds. Default: 30s
Returns:  
  Nothing
```
Example:
```sqf
// remoteExec used to execute where '_unit' is local
[_unit, 30] remoteExec ["tts_cloak_fnc_cloakAI", _unit, false];
```

<br/>**tts_cloak_fnc_hasCloak**  
Tests if the given unit has the required equipment to cloak based on the `tts_cloak_uniforms` and `tts_cloak_headgear` arrays defined in `init.sqf`.
```
Parameters:  
  0: OBJECT - Unit to check for cloak equipment
Returns:  
  BOOL - True if unit has proper equipment, false if not
```
Example:
```sqf
private _canCloak = [_unit] call tts_cloak_fnc_hasCloak;
```

<br/>**tts_cloak_fnc_removeCloak**  
Removes cloak/active camouflage ability from the given unit/vehicle. If used on a unit cloaked via `tts_cloak_fnc_cloakAI` it will uncloak the unit.
```
Parameters:  
  0: OBJECT - Unit/vehicle to remove cloak/active camo from
Returns:  
  Nothing
```
Example:
```sqf
// remoteExec used to execute where '_unit' is local
[_unit] remoteExec ["tts_cloak_fnc_removeCloak", _unit, false];
```

___

## Changelog
Read below for complete changelog history.

### 10/11/2021
- Updated ZEN functions to be consistent with other TTS scripts.
- When ACE is enabled the cloak actions will now use ACE actions instead.

### 13/10/2021
- Added stringtable support to allow the script to be translated. If you are willing to help translate the script into another language, contact me in my Discord!
- Added 2 new functions, `fn_addCloakActions` and `fn_addVehicleCloakActions`. These are executed locally on players to allow localisation of the action text.

### 13/10/2021
- Cleaned up README file, improved instructions, added some more examples and documentation for the different functions.

### 13/08/2021
- Fixed bug that caused cloaked players to remain invisible to the host player after uncloaking in locally hosted multiplayer games.

### 22/07/2021
- 'Cloak Unit' ZEN module has been renamed to 'Cloak Unit(s)' and now has a second parameter that will apply the cloak effect to the unit's group if enabled.

### 12/07/2021
- Added custom ZEN icons.

### 23/04/2021
- Implemented Majestic Iranian Kebab's collision fix (NOTE: Local player's character will no longer be hidden when in third person).

### 12/04/2021
- Removed need to execute `fn_initCloak` and `fn_customZeusModules` manually.
- Removed Achilles compatibility (no longer supported).

### 11/02/2021
- Added Twiznak's active camouflage functionality for vehicles using PIP cameras.
- Added 'Give Active Camouflage' module to allow dynamic adding of vehicle active camo.  
- Added ability to remove vehicle active camo using 'Remove Cloak' module.  
- Minor tweaks to hopefully make the script more JIP compatible.
- Cloaking AI now properly prevents them from shooting while they are cloaked by disabling "TARGET" and "AUTOTARGET" AI, will preserve state if the AI had this disabled already before cloaking.
- Fixed a typo in `fn_giveCloak` which would cause issues with interaction menu actions.
- Added a new setting and display to show/hide vehicle camo UI seperately to cloak UI.

### 08/02/2021
- Tweaked particles slightly to decrease unit visibility.

### 05/02/2021
- Adjusted `fn_customZeusModules` slightly so it should correctly add the modules more reliably.

### 04/02/2021
- Fixed positioning and size of some particle drop points.
- Made parameters global variables instead of parameters for init so they can be changed on the fly easier.
- Added compatibility for Achilles/ZEN.

### 25/01/2021
- Added possibility to use headgear as cloak requirement as well.

### 22/01/2021
- Fixed sound sources not being created at correct position when units were not near terrain.
- Adjusted cloak in/out transition to be created at centre of mass instead of feet.

### 11/01/2021
- Initial upload to GitHub.
