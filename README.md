# TTS Cloak
This is a cloaking script I made for another mission maker. This script replicates a Crysis/Predator style cloaking device where the area around/behind the unit is distorted by the cloak so they are still slightly visible. Player units can be granted the cloak and will be able to activate it through the action menu (ACE self interaction if using ACE) if they are wearing the required equipment. AI units cannot cloak themselves but can be cloaked using functions provided on the GitHub or via Zeus Enhanced modules. Cloaked units cannot be damaged by bullets due to the collision being disabled when the player model is hidden but will still take damage from most other damage sources.

This also contains an 'Active Camouflage' script made by Twiznak which allows certain vehicles to have their hidden selection textures changed to a PIP texture generated based on the surrounding terrain. Currently this is only aesthetic and does nothing to hide the vehicle from AI.

You can see the script in action in this [demo video](https://www.youtube.com/watch?v=Hasma9EI7sM) or if you'd like to test the script for yourself, you can try out the [demo mission](https://steamcommunity.com/sharedfiles/filedetails/?id=2388444766).

This is the script version, a [mod version](https://steamcommunity.com/sharedfiles/filedetails/?id=2544778197) is also available on the Steam Workshop.

### **Features:**
- Configurable settings so you can use the script how you like
- Display to keep track of cloak status
- Cloak activation/deactivation sounds
- AI will not detect cloaked units
- Can cloak AI units
- Vehicle active camouflage (Thanks to Twiznak)
- Designed for multiplayer and tested on dedicated server
- Compatible with ACE
- Useable from Zeus via [Zeus Enhanced](https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631)
- Editor modules to simplify usage (*Mod version only!*)

**ZEN Modules**:
- Change Settings
- Cloak Unit(s)
- Give Cloak
- Give Active Camo
- Remove Cloak

**Editor Modules (MOD VERSION ONLY):**
- Cloak Settings
- Give Cloak
- Give Active Camo

**For help with troubleshooting, questions or feedback, join my [Discord](https://discord.gg/8Y2ENWQMpK)**

___

### **More information:**
- [Script version install instructions](https://github.com/TheTimidShade/TTS-Cloak/wiki/Script-version-install-instructions)
- [Available settings](https://github.com/TheTimidShade/TTS-Cloak/wiki/Available-settings)
- [Function documentation](https://github.com/TheTimidShade/TTS-Cloak/wiki/Function-documentation)

### **License:**
This script is licensed under [Arma Public License Share Alike (APL-SA)](https://www.bohemia.net/community/licenses/arma-public-license-share-alike).

### **Supported Languages:**  
- English
- Polish (Translation by honger)

If you'd like to translate the script into a different language, contact me via my Discord or create a pull request.

### **Credits:**
- Players of the [Task Force Dingo](taskforcedingo.com) community who helped bulk test the script during a weekly mission night.
- Twiznak, for providing the code necessary for the vehicle active camo functionality. You should check out his [workshop items](https://steamcommunity.com/profiles/76561198009924789/myworkshopfiles/).
- Majestic Iranian Kebab, for providing the code tweaks necessary for collision to work.

___

### **Examples:**  
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
private _maxDuration = 30; // Maximum cloak duration in seconds
private _cooldown = 5; // Cooldown time in seconds
private _cloakUnits = ["unit_1", "unit_2", "unit_3"]; // List of unit varnames that have cloaking devices
if (vehicleVarName player in _cloakUnits) then {
    [player, _maxDuration, _cooldown] spawn tts_cloak_fnc_giveCloak;
};
```
*NOTE:* I don't recommend giving/removing a vehicle's active camouflage ability mid-mission since it interferes with Zeus/Spectator. The option is still available if you need to.

Give active camo to vehicle:
```sqf
// put in init.sqf or trigger 'On Activation' box
// gives 'cloakVic' 2 minutes of active camouflage with a 5 minute cooldown
[cloakVic, "cloakVic", 120, 300] spawn tts_cloak_fnc_giveVehicleCloak;
```

___

## Changelog
Read below for complete changelog history.

### 15/12/2021
- Added Polish translation by honger.

### 12/12/2021
- Fixed duplicate ACE actions being created when respawning.

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
