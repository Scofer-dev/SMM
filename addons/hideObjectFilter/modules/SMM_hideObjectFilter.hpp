#include "..\script_component.hpp"
class GVAR(module): Module_F {
	author = "Scofer";
	scope = 2;
	displayName = "Hide Terrain Object Filter";
	isGlobal = 0;
	category = "SMM_miscModules";
	icon = "\a3\modules_f\data\hideterrainobjects\icon32_ca.paa";
	function = QFUNC(hideObjectsModule);
	functionPriority = 0;
	isTriggerActivated = 1;
	isDisposable = 1;
	is3DEN = 1;

	canSetArea = 1;
	canSetAreaHeight = 0;
	canSetAreaShape = 1;
	class AttributeValues {
		size3[] = {10,10,-1};
		isRectangle = 1;
	};

	class Attributes: AttributesBase {
		class SMM_objectModels: Edit {
			property = "SMM_objectModels";
			displayName = "Model Names";
			tooltip = "Model names of objects to be hidden. Must be comma seperated";
			typeName = "STRING";
			defaultValue = "[]";
		};
		class SMM_hideLocally: CheckBox {
			property = "SMM_hideLocally";
			displayName = "Hide Locally";
			tooltip = "If enabled the objects will be hidden by each client individually. Recommended if hiding a very large number of objects over a large area";
			typeName = "BOOL";
			defaultValue = "false";
		};
		class SMM_copyToClipboard: CheckBox {
			property = "SMM_copyToClipboard";
			displayName = "Copy Object Array";
			tooltip = "Copies the found objects to clipboard in 3den for use in other things";
			defaultValue = "false";
		};

		class ModuleDescription: ModuleDescription{};
	};
	class ModuleDescription: ModuleDescription {
		description[] = {
			"This module is an alternative to the base game Hide Terrain Objects module, allowing you to input exactly which objects will be hidden, rather than the arbitrary categories of buildings, walls, vegetation, and other",
			"As this involves terrain objects, the module requires you to put the model names of objects.",
			"For a guide on how to find the model name of objects on the map, please consult the documentation, linked on the Steam page.",
			"If hiding a very large number of objects over a large area, it may be recommended to enable the Hide Locally parameter, which will make each client in MP hide objects individually, rather than having the server do it, and synchronising with each client and JIP"
		};
	};
};