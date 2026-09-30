#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_rotateCoords

Description:
    Rotates coordinates by an angle around a central position

Execution:
	- Local: Yes
	- Server: Yes
	- Global: Yes

Parameters:
	0: Central Position <Array>
	1: Position to be rotated <Array>
	2: Angle <Number>

Example:

	Rotate position [120,120,0] 50 degrees around position [100,100,0]
	[	
		[100,100,0],
		[120,120,0],
		50
	] call SMM_fnc_rotateCoords;

Returns:
    0: Rotated Coordinate <Array>

Author:
    Scofer
---------------------------------------------------------------------------- */
params [
	["_centralPos",[],[[]]],
	["_rotatePos",[],[[]]],
	["_angle",0,[-1]]
];

if (_centralPos isEqualTo []) exitWith {
	["No Central Position passed to SMM_fnc_rotateCoords"] call BIS_fnc_error;
};

if (_rotatePos isEqualTo []) exitWith {
	["No Position to be Rotated passed to SMM_fnc_rotateCoords"] call BIS_fnc_error;
};

private _x0 = _centralPos#0;
private _y0 = _centralPos#1;

private _x1 = _rotatePos#0;
private _y1 = _rotatePos#1;

private _x2 = _x0 + (_x1 - _x0) * cos(_angle) - (_y1 - _y0) * sin(_angle);
private _y2 = _y0 + (_x1 - _x0) * sin(_angle) + (_y1 - _y0) * cos(_angle);

_rotatePos set [0, _x2];
_rotatePos set [1, _y2];

_rotatePos;
