#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_deformerModule

Description:
	Adjusts the height of terrain within the area of the module in 3den and mission
	Around 90 lines shorter and ~3x faster than previous version

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

params [
	["_mode","",[""]],
	["_input",[],[[]]]
];

if (_mode isEqualTo "dragged3DEN" && {!GVARMAIN(liveUpdate)}) exitWith {};

private _module = _input select 0;

if (_mode isEqualTo "unregisteredFromWorld3DEN") exitWith {
	private _areaStartPosHeight = _module getVariable ["SMM_areaStartPosHeight",[]];
	if (_areaStartPosHeight isNotEqualTo []) then {
		setTerrainHeight _areaStartPosHeight;
	};
};

private [
	"_sizeA",
	"_sizeB",
	"_isRectangle"
];

if (is3DEN) then {
	private _moduleArea = (_module get3DENAttribute "Size3") select 0;

	_sizeA = _moduleArea select 0;
	_sizeB = _moduleArea select 1;
	_isRectangle = (_module get3DENAttribute "isRectangle") select 0;

	private _areaStartPosHeight = _module getVariable ["SMM_areaStartPosHeight",[]];
	if (_areaStartPosHeight isNotEqualTo []) then {
		setTerrainHeight _areaStartPosHeight;
	};
} else {
	private _moduleArea = _module getVariable "objectArea";

	_sizeA = _moduleArea select 0;
	_sizeB = _moduleArea select 1;
	_isRectangle = _moduleArea select 3;
};

private _centralPos = getPos _module;
private _size = _sizeA max _sizeB;
private _curAreaPos = [];
for "_xStep" from -_size to _size do {
	for "_yStep" from -_size to _size do {
		_curAreaPos pushBack (_centralPos vectorAdd [_xStep,_yStep,0]);
	};
};

private _angle = getDir _module;
_curAreaPos = _curAreaPos inAreaArray [_centralPos,_sizeA,_sizeB,_angle,_isRectangle,-1,false];

private _height = _module getVariable ["SMM_height",10];
private _seaLevel = _module getVariable ["SMM_seaLevel",false];
private _flatten = _module getVariable ["SMM_flatten",false];
private _areaStartPosHeight = [];
private _areaEndPosHeight = [];
{
	private _startPosHeight = _x;
	private _currentHeight = getTerrainHeight _startPosHeight;
	_startPosHeight set [2,_currentHeight];
	_areaStartPosHeight pushBack _startPosHeight;

	private _newHeight = 0;
	switch true do {
		case (!_seaLevel && {_flatten}): {
			_newHeight = getTerrainHeight _centralPos + _height;
		};
		case (!_seaLevel && {!_flatten}): {
			_newHeight = _currentHeight + _height;
		};
		default {
			_newHeight = _height
		};
	};

	private _newPosHeight = +_startPosHeight;
	_newPosHeight set [2,_newHeight];
	_areaEndPosHeight pushBack _newPosHeight;
} forEach _curAreaPos;

private _adjustObjects = _module getVariable ["SMM_adjustObjects",false];
_module setVariable ["SMM_areaStartPosHeight",[_areaStartPosHeight,_adjustObjects]];
setTerrainHeight [_areaEndPosHeight,_adjustObjects];

private _copyToClipboard = _module getVariable ["SMM_copyToClipboard",false];
if (_copyToClipboard && {is3DEN}) then {
	copyToClipboard str(_areaEndPosHeight);
};

if (_mode == "init" && {!is3DEN}) exitWith {
	deleteVehicle _module;
};

true;
