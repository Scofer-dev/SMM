#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_visibilityStatemachine

Description:
    Creates CBA Statemachine for the passed objects with the passed hidden and shown conditions

Execution:
	- Local: Yes
	- Server: No
	- Global: Yes

Parameters:
	0: Objects <Object/Array>		Default: []
	1: Hidden Condition <Code>		Default: {}		Objects are hidden when this returns true
	2: Shown Condition <Code>		Default: {}		Objects are shown when this returns true

Example:
	[
		[objectOne,objectTwo],
		{currentWeapon player != "binocular" || {cameraView != "Gunner"}},
		{currentWeapon player == "binocular" && {cameraView == "Gunner"}}
	] call SMM_fnc_visibilityStatemachine;

	[
		[objectOne,objectTwo],
		{currentWeapon player != "binocular" || {cameraView != "Gunner"}},
		{currentWeapon player == "binocular" && {cameraView == "Gunner"}}
	] remoteExec ["SMM_fnc_visibilityStatemachine",WEST,true];

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(hasInterface) exitWith {};

params [
	["_objects",[],[[],objNull]],
	["_hiddenCondition",{},[{}]],
	["_shownCondition",{},[{}]]
];

if (typeName _objects isEqualTo "OBJECT") then {
	_objects = [_objects];
};

if (_objects isEqualTo []) exitWith {
	["No objects passed to SMM_fnc_visibilityStatemachine"] call BIS_fnc_error;
};

if (_hiddenCondition isEqualTo {} || {_shownCondition isEqualTo {}}) exitWith {
	["Missing condition in SMM_fnc_visibilityStatemachine"] call BIS_fnc_error;
};


private _visibilityStateMachine = [_objects,true] call CBA_stateMachine_fnc_create;

[_visibilityStateMachine, {}, {}, {}, "Initial"] call CBA_stateMachine_fnc_addState;
[_visibilityStateMachine, {_this hideObject true}, {}, {}, "Hidden"] call CBA_stateMachine_fnc_addState;
[_visibilityStateMachine, {_this hideObject false}, {}, {}, "Shown"] call CBA_stateMachine_fnc_addState;

[_visibilityStateMachine, "Initial", "Hidden", _hiddenCondition, {}] call CBA_stateMachine_fnc_addTransition;
[_visibilityStateMachine, "Initial", "Shown", _shownCondition, {}] call CBA_stateMachine_fnc_addTransition;
[_visibilityStateMachine, "Shown", "Hidden", _hiddenCondition, {}] call CBA_stateMachine_fnc_addTransition;
[_visibilityStateMachine, "Hidden", "Shown", _shownCondition, {}] call CBA_stateMachine_fnc_addTransition;
