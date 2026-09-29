#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_conditionalVisibility

Description:
    Creates Visiblity Statemachine for each passed side

Execution:
	- Local: No
	- Server: Yes
	- Global: No

Parameters:
	0: Objects <Object/Array>				Default: []
	1: Visibility Condition Mode <String>	Default: "thermals"
	3: Affected Sides <Array>				Default: [WEST,EAST,INDEPENDENT,CIVILIAN]
	4: Custom Hidden Condition <Code>		Default: {}	Only used if Visibility Condition Mode is "custom", objects hidden when this returns true
	5: Custom Shown Condition <Code>		Default: {}	Only used if Visibility Condition Mode is "custom", objects shown when this returns true

Example:
	[
		[objectOne,objectTwo],
		"thermals",
		[WEST,INDEPENDENT]
	] call SMM_fnc_conditionalVisibility;

	[
		[objectOne,objectTwo],
		"custom",
		[EAST],
		{currentWeapon player != "binocular" || {cameraView != "Gunner"}},
		{currentWeapon player == "binocular" && {cameraView == "Gunner"}}
	] remoteExec ["SMM_fnc_conditionalVisibility",2];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(isServer) exitWith {};

params [
	["_objects",[],[[],objNull]],
	["_visibilityConditionMode","thermals",[""]],
	["_affectedSides",[WEST,EAST,INDEPENDENT,CIVILIAN],[[],WEST]],
	["_customHiddenCondition",{},[{}]],
	["_customShownCondition",{},[{}]]
];

if (typeName _objects isEqualTo "OBJECT") then {
	_objects = [_objects];
};

if (_objects isEqualTo []) exitWith {
	["No objects passed to SMM_fnc_conditionalVisibility"] call BIS_fnc_error;
};

if (typeName _affectedSides isEqualTo "SIDE") then {
	_affectedSides = [_affectedSides];
};

_affectedSides = _affectedSides select {typeName _x isEqualTo "SIDE"};
if (_affectedSides isEqualTo []) exitWith {
	["No sides passed to SMM_fnc_conditionalVisibility"] call BIS_fnc_error;
};


private _hiddenCondition = {};
private _shownCondition = {};
switch _visibilityConditionMode do {
	case "thermals": {
		_hiddenCondition = {currentVisionMode player != 2};
		_shownCondition = {currentVisionMode player == 2};
	};
	case "nightvision": {
		_hiddenCondition = {currentVisionMode player != 1};
		_shownCondition = {currentVisionMode player == 1};
	};
	default {
		if (_customHiddenCondition isEqualTo {} || {_customShownCondition isEqualTo {}}) exitWith {
			["Missing custom condition passed to SMM_fnc_conditionalVisibility"] call BIS_fnc_error;
		};

		_hiddenCondition = _customHiddenCondition;
		_shownCondition = _customShownCondition;
	};
};


if (_hiddenCondition isEqualTo {} || {_shownCondition isEqualTo {}}) exitWith {
	["Missing condition in SMM_fnc_conditionalVisibility"] call BIS_fnc_error;
};

{
	[_objects,_hiddenCondition,_shownCondition] remoteExec [QFUNC(visibilityStatemachine),_x,true];
} forEach _affectedSides;
