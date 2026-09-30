#include "..\script_component.hpp"
class GVARMAIN(conditionalVisibility): Module_F {
	author = "Scofer";
	scope = 2;
	displayName = "Conditional Visibility";
	isGlobal = 0;
	category = "SMM_miscModules";
	icon = "\a3\3den\data\displays\display3den\toolbar\vision_normal_ca.paa";
	function = QFUNC(conditionalVisibilityModule);
	functionPriority = 1;
	isTriggerActivated = 1;
	isDisposable = 1;

	class Attributes: AttributesBase {
		class SMM_visibilityCondition: Combo {
			property = "SMM_visibilityCondition";
			displayName = "Condition Mode";
			tooltip = "Condition under which the objects will appear";
			typeName = "STRING";
			defaultValue = """thermals""";
			class Values {
				class nightvision {
					name = "Nightvision Mode";
					value = "nightvision";
				};
				class thermals {
					name = "Thermal Vision Mode";
					value = "thermals";
				};
				class custom {
					name = "Custom Condition";
					value = "custom";
				};
			};
		};

		class SMM_customConditionUsedSubCat {
			property = "SMM_customConditionUsedSubCat";
			title = "Custom Conditions - Only use on Custom Condition Mode";
			control = "SubCategory";
			//condition = "script";
			//conditionScript = "_this get3DENAttribute 'SMM_visibilityCondition' select 0 isEqualTo 'custom'";
		};
		/*
		class SMM_customConditionNotUsedSubCat {
			property = "SMM_customConditionNotUsedSubCat";
			title = "Custom Conditions not in use";
			control = "SubCategory";
			condition = "script";
			conditionScript = "_this get3DENAttribute 'SMM_visibilityCondition' select 0 isNotEqualTo 'custom'";
		};
		*/
		class SMM_customHiddenCondition: Edit {
			property = "SMM_customHiddenCondition";
			displayName = "Custom Hidden Condition";
			tooltip = "Custom condition under which objects will be hidden. Condition is evaluated locally to each player";
			typeName = "STRING";
			//condition = "script";
			//conditionScript = "_this get3DENAttribute 'SMM_visibilityCondition' select 0 isEqualTo 'custom'";
		};
		class SMM_customShownCondition: Edit {
			property = "SMM_customShownCondition";
			displayName = "Custom Shown Condition";
			tooltip = "Custom condition under which objects will be shown. Condition is evaluated locally to each player";
			typeName = "STRING";
			//condition = "script";
			//conditionScript = "_this get3DENAttribute 'SMM_visibilityCondition' select 0 isEqualTo 'custom'";
		};

		class SMM_affectedSidesSubCat {
			property = "SMM_affectedSidesSubCat";
			title = "Affected Player Sides";
			control = "SubCategory";
		};
		class SMM_affectBlufor: CheckBox {
			property = "SMM_affectBlufor";
			displayName = "Blufor";
			tooltip = "Conditionally hide objects for BLUFOR players";
			defaultValue = "true";
		};
		class SMM_affectOpfor: CheckBox {
			property = "SMM_affectOpfor";
			displayName = "Opfor";
			tooltip = "Conditionally hide objects for OPFOR players";
			defaultValue = "true";
		};
		class SMM_affectIndfor: CheckBox {
			property = "SMM_affectIndfor";
			displayName = "Indfor";
			tooltip = "Conditionally hide objects for INDFOR players";
			defaultValue = "true";
		};
		class SMM_affectCiv: CheckBox {
			property = "SMM_affectCiv";
			displayName = "Civilian";
			tooltip = "Conditionally hide objects for CIVILIAN players";
			defaultValue = "true";
		};
		class ModuleDescription: ModuleDescription{};
	};
	class ModuleDescription: ModuleDescription {
		description[] = {
			"Synchronise this module to objects that you want it to apply with, select a preset condition or create your own, and decide which players it applies to.",	
			"In the mission the object will be hidden until the preset/custom shown condition is true. This is evaluated locally to each player."
		};
	};
};
