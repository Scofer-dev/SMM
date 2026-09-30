#include "script_component.hpp"

#include "XEH_PREP.hpp"

#include "addonSettings.sqf"

add3DENEventHandler ["OnMissionLoad", {
	{
		if (typeOf _x == "smm_terrainDeformation_module") then {
			["onMissionLoad",[_x]] call SMM_fnc_deformerModule;
		};
	} forEach allMissionObjects "logic";
}];
