#include "..\script_component.hpp"
/* ----------------------------------------------------------------------------
Function: SMM_fnc_hideObjectsInit3DEN

Description:
    Initialises the all placed SMM Hide Terrain Object Filter modulss when a mission is loaded in 3DEN

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
    switch (typeOf _x) do {
        case "smm_terrainDeformation_module": {
            ["",[_x]] call SMM_fnc_deformerModule;
        };
        case "smm_hideObjectFilter_module": {
            ["",[_x]] call SMM_fnc_hideObjectsModule;
        };
    };
} forEach allMissionObjects "logic";
