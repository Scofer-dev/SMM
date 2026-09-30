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
	N/A

Example:
	N/A

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
