#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_vehicleRespawnModule

Description:
	Parses data from the passed SMM Vehicle Respawn module to be passed to SMM_fnc_vehicleRespawn
	If you're wanting to do this via script rather than module call SMM_fnc_vehicleRespawn directly

Execution:
	- Local: Yes
	- Server: Yes
	- Global: No

Parameters:
	0: Logic (Object)

	Logical Parameters - Must be applied to associated object with "setVariable" before calling this function. Will use default if unset
		- Respawn Delay <Number>	Default: 0
			logic setVariable ["SMM_delay", value];
		- Vehicle Init <String>		Default: ""
			logic setVariable ["SMM_init", value];
		- Delete Wreck <Bool>		Default: false
			logic setVariable ["SMM_deleteWreck", value];
		- Disable NVGs <Bool>		Default: false
			logic setVariable ["SMM_disableNVG", value];
		- Disable Thermals <Bool>	Default: false
			logic setVariable ["SMM_disableThermals", value];
		- Save Inventory <Bool>		Default: false
			logic setVariable ["SMM_customEquipment", value];
		- Add to Zeus <Bool>		Default: true
			logic setVariable ["SMM_addToZeus", value];

	Synchronised Parameters
		- 1 or more vehicles synchronised to Logic, their current position will be where they respawn

Example:
	[Logic] call SMM_fnc_vehicleRespawnModule;

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

private _module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};

private _respawnDelay = _module getVariable ["SMM_delay",0];
private _vehicleInit = compile(_module getVariable ["SMM_init",""]);
private _deleteWreck = _module getVariable ["SMM_deleteWreck",false];
private _disableNVG = _module getVariable ["SMM_disableNVG",false];
private _disableThermals = _module getVariable ["SMM_disableThermals",false];
private _saveInventory = _module getVariable ["SMM_customEquipment",false];
private _addToZeus = _module getVariable ["SMM_addToZeus",true];


private _vehicleSync = synchronizedObjects _module;

_vehicleSync = _vehicleSync select {!(typeOf _x in ["EmptyDetector","EmptyDetectorArea10x10","EmptyDetectorAreaR50","EmptyDetectorAreaR250"])};

if (_vehicleSync isEqualTo []) exitWith {
	format ["No vehicles synchronised to %1 for use in SMM_fnc_vehicleRespawnModule",_module] call BIS_fnc_error;
};

{
	private _vehicle = _x;
	private _vehicleClass = typeOf _vehicle;

	private _simulation = toLower getText (configFile >> "CfgVehicles" >> _vehicleClass >> "simulation");
	if !(_simulation in ["car","carx","tank","tankx","helicopter","helicopterx","helicopterrtd","airplane","airplanex","ship","shipx","submarinex"]) exitwith {
		format ["Invalid object: %1, synced to SMM Vehicle Respawn Module. Must only synchronise vehicles",_vehicleClass] call BIS_fnc_error;
	};

	
} forEach _vehicleSync;

[
	_vehicleSync,
	_respawnDelay,
	_vehicleInit,
	_deleteWreck,
	_disableNVG,
	_disableThermals,
	_saveInventory,
	_addToZeus
] call FUNC(vehicleRespawn);

deleteVehicle _module;
