#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_vehicleRespawnEvent

Description:
    Handles vehicle respawning

Execution:
	- Local: No
	- Server: Yes
	- Global: No

Parameters:
    0: Vehicle <Object>     Default: objNull

Example:
	[myCar] spawn SMM_fnc_vehicleRespawnEvent;

	[myCar] remoteExec ["SMM_fnc_vehicleRespawnEvent",2];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

params [
    ["_vehicle",objNull,[objNull]]
];

if !(canSuspend) exitWith {
    [_vehicle] spawn FUNC(vehicleRespawnEvent);
};

if (isNull _vehicle) exitWith {
    ["No vehicle passed to SMM_fnc_vehicleRespawnEvent"] call BIS_fnc_error;
};

private _respawnVariables = _vehicle getVariable "SMM_respawnVariables";

_respawnVariables params [
    "_vehicleClass",
    "_vehicleComponents",
    "_pylons",
    "_spawnPos",
    "_spawnDir",
    "_respawnDelay",
    "_vehicleInit",
    "_deleteWreck",
    "_disableNVG",
    "_disableThermals",
    "_equipmentArray",
    "_addToZeus"
];

private _destroyedTime = CBA_missionTime;
waitUntil {sleep 0.5; CBA_missionTime >= (_destroyedTime + _respawnDelay)};

if (_deleteWreck) then {
    deleteVehicle _vehicle;
};

private _newVehicle = _vehicleClass createVehicle _spawnPos;
_newVehicle setDir _spawnDir;

_vehicleComponents params [
    "_vehicleTextures",
    "_vehicleAnimations"
];

[_newVehicle,_vehicleTextures,_vehicleAnimations] call BIS_fnc_initVehicle;

{
    _x params [
        "_index",
        "_name",
        "_turret",
        "_magazine"
    ];

    _newVehicle setPylonLoadout [_name,_magazine,true,_turret];
} forEach _pylons;

_newVehicle call _vehicleInit;

if (_disableNVG) then {
    _newVehicle disableNVGEquipment true;
};
if (_disableThermals) then {
    _newVehicle disableTIEquipment true;
};

if (_equipmentArray isNotEqualTo []) then {
    clearWeaponCargoGlobal _newVehicle;
    clearMagazineCargoGlobal _newVehicle;
    clearItemCargoGlobal _newVehicle;
    clearBackpackCargoGlobal _newVehicle;
    
    _equipmentArray params [
        "_weaponArray",
        "_magazineArray",
        "_itemArray",
        "_backPackArray"
    ];

    {
        _newVehicle addWeaponCargoGlobal [_x,1];
    } forEach _weaponArray;
    {
        _newVehicle addMagazineCargoGlobal [_x,1];
    } forEach _magazineArray;
    {
        _newVehicle addItemCargoGlobal [_x,1];
    } forEach _itemArray;
    {
        _newVehicle addBackpackCargoGlobal [_x,1];
    } forEach _backPackArray;
};

if (_addToZeus) then {
    {
        _x addCuratorEditableObjects [[_newVehicle],true];
    } forEach allCurators;
};


_newVehicle setVariable ["SMM_respawnVariables",_respawnVariables,true];

private _respawnVariables = _vehicle getVariable "SMM_respawnVariables";


_newVehicle addMPEventHandler ["MPKilled",{
    if !(isServer) exitWith {};
    params ["_vehicle"];

	[_vehicle] spawn FUNC(vehicleRespawnEvent);
}];
