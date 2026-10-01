#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_hideObjectsModule

Description:
	Hides the passed terrain object types within the area of the module in 3den and mission

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

if (_mode isEqualTo "dragged3DEN" && {!GVAR(liveUpdate)}) exitWith {};

private _module = _input select 0;

if (_mode isEqualTo "unregisteredFromWorld3DEN") exitWith {
	private _hiddenObjects = _module getVariable ["SMM_hiddenObjects",[]];
	if (_hiddenObjects isNotEqualTo []) then {
		{
			_x hideObject false;
		} forEach _hiddenObjects;
	};
};

private _modelNames = _module getVariable ["SMM_objectModels",""];
//Convert modelName string array into an actual array, will error if the string array inputted by the player isn't formatted properly
if (_modelNames isEqualType "") then {	//W
	_modelNames = parseSimpleArray _modelNames;
};
if (_modelNames isEqualTo []) exitWith {};

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

	private _hiddenObjects = _module getVariable ["SMM_hiddenObjects",[]];
	if (_hiddenObjects isNotEqualTo []) then {
		{
			_x hideObject false;
		} forEach _hiddenObjects;
	};
} else {
	private _moduleArea = _module getVariable "objectArea";

	_sizeA = _moduleArea select 0;
	_sizeB = _moduleArea select 1;
	_isRectangle = _moduleArea select 3;
};

private _radius = (_sizeA max _sizeB) * 1.42;
private _foundObjects = nearestTerrainObjects [_module,[],_radius,false,true];

private _toHide = [];
{
	if ((getModelInfo _x select 0) in _modelNames) then {
		_toHide pushBack _x;
	};
} forEach _foundObjects;

private _angle = getDir _module;
private _area = [getPos _module,_sizeA,_sizeB,_angle,_isRectangle, -1];
private _hideInArea = _toHide inAreaArray _area;
_module setVariable ["SMM_hiddenObjects",_hideInArea];

private _hideLocally = _module getVariable ["SMM_hideLocally",false];
if (_hideLocally) then {
	[_hideInArea] remoteExec [QFUNC(hideObjects),0,true];
} else {
	{
		_x hideObjectGlobal true;
	} forEach _hideInArea;
};

private _copyToClipboard = _module getVariable ["SMM_copyToClipboard",false];
if (_copyToClipboard && {is3DEN}) then {
	copyToClipboard str(_areaEndPosHeight);
};

if (_mode == "init" && {!is3DEN}) exitWith {
	deleteVehicle _module;
};

true;
