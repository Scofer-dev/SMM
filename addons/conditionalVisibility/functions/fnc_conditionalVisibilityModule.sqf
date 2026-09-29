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
	0: Logic (Object)

	Logical Parameters - Must be applied to associated object with "setVariable" before calling this function. Will use default if unset
		- Visibility Condition Mode <String>	Default: "thermals"		Options: "thermals", "nightvision", "custom"
			logic setVariable ["SMM_visibilityCondition", value];
		- Custom Hidden Condition <String>		Default: ""		Only used if condition mode is set to "custom", objects hidden when this returns true
			logic setVariable ["SMM_customHiddenCondition", value];
		- Custom Shown Condition <String>		Default: ""		Only used if condition mode is set to "custom", objects revealed when this returns true
			logic setVariable ["SMM_customShownCondition", value];
		- Affect BLUFOR Players <Bool>			Default: true;
			logic setVariable ["SMM_affectBlufor", value];
		- Affect OPFOR Player <Bool>			Default: true;
			logic setVariable ["SMM_affectOpfor", value];
		- Affect INDFOR Players <Bool>			Default: true;
			logic setVariable ["SMM_affectIndfor", value];
		- Affect Civilian Players <Bool>		Default: true;
			logic setVariable ["SMM_affectCiv", value];

	Synchronised Parameters
		- 1 or more objects synchronised to Logic to be added to the Visibility Statemachine

Example:
	[Logic] call SMM_fnc_conditionalVisibility;

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
