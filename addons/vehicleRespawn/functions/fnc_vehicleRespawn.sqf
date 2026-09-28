#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_vehicleRespawn

Description:
    Adds event to passed vehicles to have them respawn when destroyed

Execution:
	- Local: No
	- Server: Yes
	- Global: No

Parameters:
    0: Vehicles <Object/Array>	Default: []
	1: Respawn Delay <Number>	Default: 0
	2: Vehicle Init <Code>		Default: {}
	3: Delete Wreck <Bool>		Default: false
	4: Disable NVG <Bool>		Default: false
	5: Disable Thermals <Bool>	Default: false
	6: Save Inventroy <Bool>	Default: false
	7: Add To Zeus <Bool>		Default: true

Example:
	[
		[vehicleOne,vehicleTwo],
		10,
		{_newVehicle setDamage 0.25},
		false,
		true,
		true,
		false
	] call SMM_fnc_vehicleRespawn;

	[
		[vehicleOne,vehicleTwo],
		10,
		{_newVehicle setDamage 0.25},
		false,
		true,
		true,
		false
	] remoteExec ["SMM_fnc_vehicleRespawn",2];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

params [
	["_vehicles",[],[[],objNull]],
	["_respawnDelay",0,[-1]],
	["_vehicleInit",{},[{}]],
	["_deleteWreck",false,[false]],
	["_disableNVG",false,[false]],
	["_disableThermals",false,[false]],
	["_saveInventory",false,[false]],
	["_addToZeus",true,[true]]
];

if (typeName _vehicles isEqualTo "OBJECT") then {
	_vehicles = [_vehicles];
};

if (_vehicles isEqualTo []) exitWith {
	["No vehicles passed to SMM_fnc_vehicleRespawn"] call BIS_fnc_error;
};

{
	private _vehicle = _x;
	private _vehicleClass = typeOf _vehicle;

	private _simulation = toLower getText (configFile >> "CfgVehicles" >> _vehicleClass >> "simulation");
	if !(_simulation in ["car","carx","tank","tankx","helicopter","helicopterx","helicopterrtd","airplane","airplanex","ship","shipx","submarinex"]) exitwith {
		format ["Invalid object: %1, passed to SMM_fnc_vehicleRespawn. Must only pass vehicles",_vehicleClass] call BIS_fnc_error;
	};
	
	private _vehicleComponents = [_vehicle] call BIS_fnc_getVehicleCustomization;
	private _pylons = getPylonMagazines _vehicle;

	private _vehiclePos = getPosATL _vehicle;
	private _vehicleDir = getDir _vehicle;

	private _equipmentArray = [];
	if (_saveInventory) then {
		_equipmentArray = [weaponCargo _vehicle,magazineCargo _vehicle,itemCargo _vehicle,backPackCargo _vehicle];
	};

	_vehicle setVariable ["SMM_respawnVariables",[
		_vehicleClass,
		_vehicleComponents,
		_pylons,
		_vehiclePos,
		_vehicleDir,
		_respawnDelay,
		_vehicleInit,
		_deleteWreck,
		_disableNVG,
		_disableThermals,
		_equipmentArray,
		_addToZeus
	],true];

	_vehicle addMPEventHandler ["MPKilled",{
		if !(isServer) exitWith {};
		params ["_vehicle"];

		[_vehicle] spawn FUNC(vehicleRespawnEvent);
	}];
} forEach _vehicles;
