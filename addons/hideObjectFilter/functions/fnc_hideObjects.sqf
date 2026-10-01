#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_hideObjects

Description:
	Hides the passed objects
	Intended for use by SMM_fnc_hideObjectModule for remoteExec to all machines

Execution:
	- Local: Yes
	- Server: Yes
	- Global: Yes

Parameters:
	0: Objects <Array>

Example:
	N/A

Returns:
    Nothing

Author:
    Scofer
---------------------------------------------------------------------------- */
params [
	["_objects",[],[[]]]
];

if (_objects isEqualTo []) exitWith {
	["No objects passed to SMM_fnc_hideObjects"] call BIS_fnc_error;
};

if (isServer) then {
	//If local client is the server hide the objects and disable their damage, damage can only be disabled on client objects are local to
	{
		_x hideObject true;
	} forEach _hideInArea;
} else {
	{
		_x hideObject true;
	} forEach _hideInArea;
};
