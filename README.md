# Timid's Cloak Script
## Overview:
Designed for Arma 3, this script gives player and AI units the ability to turn (almost) invisible by activating a cloaking device. When a unit is cloaked, a blurry predator/crysis style cloak is shown while the unit's model is hidden. Unfortunately, a side effect of hiding an object in Arma 3 is it disables it's collision, so while the cloak is active the cloaked unit can clip through other units, objects, buildings, etc and can get stuck when deactivating the cloak inside an object.

## Features:
- Small display to keep track of cloak status
- Cloak activation/deactivation sounds
- AI will not detect cloaked units
- Can cloak AI units (although not recommended)
- Works in MP (Tested on dedicated server)
- Optional predator noises for extra intimidation factor

## Setup/Use:
1. Download files from repository.
2. Excluding `README.md`, move files into your mission folder and merge `description.ext` and `init.sqf` with your existing files (if you have them).
3. Configure settings in `init.sqf`.
4. Add cloak abilities to desired units using `[unitName, _duration, _cooldown] spawn tts_cloak_fnc_giveCloak;`. The simplest way of doing this for player units is through `initPlayerLocal.sqf` (See example `initPlayerLocal.sqf`).

## Useful functions and parameters
### tts_cloak_fnc_initCloak
This function initialises the cloak settings for all clients and the server. These settings can be changed on the fly if necessary but have to be updated on all clients and the server for consistent results.

**Parameters**  
0: _uniforms - List of uniform classnames considered 'cloaking' uniforms.  
1: _requireHolstered - If true, unit must put away their weapon to cloak and will decloak if a weapon is pulled out.  
2: _decloakOnFired - Whether or not the unit is decloaked when shooting or throwing grenades.  
3: _playSounds - If false, no sounds will be played on cloak/decloak.  
4: _playVoice - If false, 'cloak engaged' voice will not be played on cloak start.  
5: _useUI - If false, the option to toggle the cloak display will not be visible (don't need it if you have unlimited cloak)

**Execution**  
Should be executed from `init.sqf` to ensure consistent settings on all clients and server.

### tts_cloak_fnc_giveCloak
This function adds actions to the given player unit so they can active/deactivate their cloak. Does not work for AI units.

**Parameters**  
0: _unit - Player unit to give cloak abilities to.  
1: _duration - Maximum duration in seconds the unit can cloak for before they will be forced to decloak.  
2: _cooldown - Number of seconds before unit can cloak again after decloaking.  

**Execution**  
Should be executed from server or client having actions added.

### tts_cloak_fnc_cloakAI
This function will cloak the given AI unit for the provided number of seconds. Also works for player units, but the player has no control over the cloak status. Note that cloaked AI units will still target enemy units and are invulnerable while the cloak is active so use carefully. 

**Parameters**  
0: _unit - Unit to cloak.  
1: _duration - Duration of cloak state.  

**Execution**  
Should be executed from the server or host player.

## Changelog
Read below for complete changelog history.

### 25/01/2021
- Added possibility to use headgear as cloak requirement as well.

### 22/01/2021
- Fixed sound sources not being created at correct position when units were not near terrain.
- Adjusted cloak in/out transition to be created at centre of mass instead of feet.

### 11/01/2021
- Initial upload to GitHub.