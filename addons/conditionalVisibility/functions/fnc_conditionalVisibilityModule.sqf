#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_conditionalVisibilityModule

Description:
    Parses data from the passed SMM Conditional Visibility module module to be passed to SMM_fnc_conditionalVisibility
	If you're wanting to do this via script rather than module call SMM_fnc_conditionalVisibility directly

Execution:
	- Local: No
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

private _objects = synchronizedObjects _module;
_objects = _objects select {!(typeOf _x in ["EmptyDetector","EmptyDetectorArea10x10","EmptyDetectorAreaR50","EmptyDetectorAreaR250"])};

if (_objects isEqualTo []) exitWith {
	format ["No objects synchronised to %1 for use in SMM_fnc_conditionalVisibilityModule",_module] call BIS_fnc_error;
};

private _visibilityCondition = _module getVariable ["SMM_visibilityCondition","thermals"];
private _customHiddenCondition = compile(_module getVariable ["SMM_customHiddenCondition",""]);
private _customShownCondition = compile(_module getVariable ["SMM_customShownCondition",""]);

if (_visibilityCondition == "custom" && {_customHiddenCondition isEqualTo {} || _customShownCondition isEqualTo {}}) exitWith {
	format ["Missing custom condition in %1 for use in SMM_fnc_conditionalVisibilityModule",_module] call BIS_fnc_error;
};

private _affectedSides = [];
if (_module getVariable "SMM_affectBlufor") then {
	_affectedSides pushBack BLUFOR;
};

if (_module getVariable "SMM_affectOpfor") then {
	_affectedSides pushBack EAST;
};

if (_module getVariable "SMM_affectIndfor") then {
	_affectedSides pushBack INDEPENDENT;
};

if (_module getVariable "SMM_affectCiv") then {
	_affectedSides pushBack CIVILIAN;
};


[
	_objects,
	_visibilityCondition,
	_affectedSides,
	_customHiddenCondition,
	_customShownCondition
] call FUNC(conditionalVisibility);

deleteVehicle _module;
