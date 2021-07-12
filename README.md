# Cloak Script
## Overview:
Designed for Arma 3, this script gives player and AI units the ability to turn (almost) invisible by activating a cloaking device. When a unit is cloaked, a blurry predator/crysis style cloak is shown while the unit's model is hidden. Unfortunately, a side effect of hiding an object in Arma 3 is it disables it's collision, so while the cloak is active the cloaked unit is cannot be shot. Short cloak duration and moderate cooldown is recommended for good balance.

You will not be able to use this script from Zeus unless Zeus Enhanced is loaded.

Demo Video: https://youtu.be/Hasma9EI7sM  
Steam Workshop page: https://steamcommunity.com/sharedfiles/filedetails/?id=2388444766  
Zeus Enhanced: https://steamcommunity.com/sharedfiles/filedetails/?id=1779063631  

## Features:
- Small display to keep track of cloak status
- Cloak activation/deactivation sounds
- AI will not detect cloaked units
- Can cloak AI units
- Vehicle active camouflage (Thanks to Twiznak)
- Works in MP (Tested on dedicated server)
- Compatible with Zeus Enhanced.

## Setup/Use:
1. Download files from repository.
2. Excluding `README.md`, move files into your mission folder and merge `description.ext` and `init.sqf` with your existing files (if you have them).
3. Configure settings in `init.sqf`.
4. Add cloak abilities to desired units using `[unitName, _duration, _cooldown] spawn tts_cloak_fnc_giveCloak;`. The simplest way of doing this for player units is through `initPlayerLocal.sqf` (See example `initPlayerLocal.sqf`).
5. Add cloak abilities to desired vehicles using `[vehicleName, "someUniqueString", _duration, _cooldown] spawn tts_cloak_fnc_giveVehicleCloak;`. The simplest way to do this is through `initServer.sqf` or `init.sqf` (See example `init.sqf` from GitHub download). This function needs to be executed on the server to work.

### Settings  
Below is a list of settings that can be changed to suit the way you want to use the cloak script. Place the lines you wish to change in `init.sqf` before the initCloak function.  

If the empty string "" is in the uniforms or headgear array, that equipment will be ignored in the fn_hasCloak check. e.g. 
```sqf 
tts_cloak_uniforms = ["yourUniform"]; tts_cloak_headgear = [""];
```
Only 'yourUniform' will be required in order to cloak, headgear will not matter  
```sqf
tts_cloak_uniforms = [""]; // uniform classnames used as 'cloak' uniforms, can retrieve them from arsenal export
tts_cloak_headgear = [""]; // headgear classnames used as 'cloak' headgear
tts_cloak_requireHolstered = true; // if true, players weapon will be holstered when entering cloak
tts_cloak_decloakOnFired = true; // if true, throwing grenades or shooting will uncloak the player
tts_cloak_playSounds = true; // whether or not to play cloak in/out sounds
tts_cloak_playVoice = true; // whether or not to play 'cloak engaged' voice when entering cloak
tts_cloak_useUI = true; // whether or not to show cloak UI (cloak time/cooldown)
tts_cloak_useUIVehicle = true; // whether or not to show active camo UI (vehicle camo)
```

## Changelog
Read below for complete changelog history.

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
**WARNING:** Adding/removing vehicle cloaks creates/deletes PIP cameras, which can interfere with the Spectator/Zeus camera. Usually this requires the player to close and reopen the Spectator/Zeus camera however it can cause issues for units with forced Zeus interface since they are not able to close and reopen the interface. Use vehicle cloak with caution if using Spectator/Zeus in mission.
- Minor tweaks to hopefully make the script more JIP compatible.
- Cloaking AI now properly prevents them from shooting while they are cloaked by disabling "TARGET" and "AUTOTARGET" AI, will preserve state if the AI had this disabled already before cloaking.
- Fixed a typo in `fn_giveCloak` which would cause issues with interaction menu actions.
- Added a new setting & display to show/hide vehicle camo UI seperately to cloak UI.

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
