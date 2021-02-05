# Cloak Script
## Overview:
Designed for Arma 3, this script gives player and AI units the ability to turn (almost) invisible by activating a cloaking device. When a unit is cloaked, a blurry predator/crysis style cloak is shown while the unit's model is hidden. Unfortunately, a side effect of hiding an object in Arma 3 is it disables it's collision, so while the cloak is active the cloaked unit is invincible, can clip through other units, objects, buildings, etc and can get stuck when deactivating the cloak inside an object. Short cloak duration and moderate cooldown is recommended for good balance.

## Features:
- Small display to keep track of cloak status
- Cloak activation/deactivation sounds
- AI will not detect cloaked units
- Can cloak AI units (although not recommended)
- Works in MP (Tested on dedicated server)
- Achilles/Zeus Enhanced compatibility

## Setup/Use:
1. Download files from repository.
2. Excluding `README.md`, move files into your mission folder and merge `description.ext` and `init.sqf` with your existing files (if you have them).
3. Configure settings in `init.sqf`.
4. Add cloak abilities to desired units using `[unitName, _duration, _cooldown] spawn tts_cloak_fnc_giveCloak;`. The simplest way of doing this for player units is through `initPlayerLocal.sqf` (See example `initPlayerLocal.sqf`).
5. Optionally, if you want to use the script from Zeus you will need to add `[] spawn tts_cloak_fnc_customZeusModules;` to `initPlayerLocal.sqf` (Also shown in example `initPlayerLocal.sqf`).

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
```

## Changelog
Read below for complete changelog history.

### 05/02/2021
- Adjusted fn_customZeusModules slightly so it should correctly add the modules more reliably.

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
