#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_deformerInit3DEN

Description:
    Initialises the SMM Terrain Deformation moduls when a mission is loaded in 3DEN

Execution:
	3DEN

Parameters:
	N/A

Example:
    N/A

Returns:
    N/A

Author:
    Scofer
---------------------------------------------------------------------------- */
if !(is3DEN) exitWith {};

{
    if (typeOf _x isEqualTo "smm_terrainDeformation_module") then {
        ["onMissionLoad",[_x]] call SMM_fnc_deformerModule;
    };
} forEach allMissionObjects "logic";
