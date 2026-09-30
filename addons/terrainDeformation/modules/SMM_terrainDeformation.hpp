#include "..\script_component.hpp"
class GVAR(module): Module_F {
	author = "Scofer";
	scope = 2;
	displayName = "Terrain Deformation";
	isGlobal = 0;
	category = "SMM_miscModules";
	icon = "\a3\ui_f\data\igui\rscingameui\rscunitinfo\icon_terrain_ca.paa";
	function = QFUNC(deformerModule);
	functionPriority = 0;
	isTriggerActivated = 1;
	isDisposable = 1;
	is3DEN = 1;

	canSetArea = 1;
	canSetAreaHeight = 0;
	canSetAreaShape = 1;
	class AttributeValues {
		size3[] = {5,5,-1};
		isRectangle = 1;
	};

	class Attributes: AttributesBase {
		class SMM_height: Edit {
			property = "SMM_height";
			displayName = "Height";
			tooltip = "Height of the deformation in metres";
			typeName = "NUMBER";
			defaultValue = 5;
		};
		class SMM_adjustObjects: CheckBox {
			property = "SMM_adjustObjects";
			displayName = "Adjust Objects";
			tooltip = "Adjust object heights with terrain";
			defaultValue = "false";
		};
		class SMM_seaLevel: CheckBox {
			property = "SMM_seaLevel";
			displayName = "From Sea-Level";
			tooltip = "Height adjustment will be made from sea-level (AKA terrainHeight 0/ASL 0). Flat Terrain is always active when this is true";
			defaultValue = "false";
		};
		class SMM_flatten: CheckBox {
			property = "SMM_flatten";
			displayName = "Flat Terrain";
			tooltip = "All deformed terrain will be the same height. Always active when height is from sea-level";
			defaultValue = "false";
		};
		class SMM_copyToClipboard: CheckBox {
			property = "SMM_copyToClipboard";
			displayName = "Copy setTerrainHeight Data";
			tooltip = "Copies the setTerrainHeight parameters to clipboard in 3den";
			defaultValue = "false";
		};

		class ModuleDescription: ModuleDescription{};
	};
	class ModuleDescription: ModuleDescription {
		description[] = {
			"This module is used to deform the terrain in the 3den editor, and in missions.",
			"It has several parameters available to it. Can make some interesting stuff when used in combination with the hide terrain objects module.",
			"I personally recommend having Vertical Mode disabled in 3den when moving these modules around",
			"",
			"Having players start in a deformed area can be weird if the Adjust Objects options isn't enabled.",
			"In some situations having simulated vehicles in deformed areas can lead to a performance loss.",
			"Having multiple deformation modules changing the same area can lead to strange results, the exception to this is when the From Sea-Level option is enabled, and the heights are the same.",
			"Terrain deformation doesn't work outside map boundaries. If part of the module area is outside the map, none of the deformation takes place."
		};
	};
};
