#include "..\script_component.hpp"
class GVARMAIN(vehicleRespawn): Module_F {
	author = "Scofer";
	scope = 2;
	displayName = "Vehicle Respawn";
	isGlobal = 0;
	category = "SMM_logisticsModules";
	icon = "\a3\Modules_f\data\iconRespawn_ca.paa";
	function = QFUNC(vehicleRespawnModule);
	functionPriority = 1;
	isTriggerActivated = 1;
	isDisposable = 1;

	class Attributes: AttributesBase {
		class SMM_delay: Edit {
			property = "SMM_delay";
			displayName = "Delay";
			tooltip = "Seconds between vehicle death and vehicle respawn";
			typeName = "NUMBER";
			defaultValue = "0";
		};
		class SMM_init: Edit {
			property = "SMM_init";
			displayName = "Init";
			tooltip = "Code executed on the vehicle on respawn. Use _this to reference the vehicle";
			typeName = "STRING";
		};
		class SMM_deleteWreck: CheckBox {
			property = "SMM_deleteWreck";
			displayName = "Delete Wreck";
			tooltip = "Delete the wreck of a vehicle once it respawns";
			typeName = "BOOL";
		};
		class SMM_disableNVG: CheckBox {
			property = "SMM_disableNVG";
			displayName = "Disable NVGs";
			tooltip = "Disable Nightvision for this vehicle when it respawns";
			typeName = "BOOL";	
		};
		class SMM_disableThermals: CheckBox {
			property = "SMM_disableThermals";
			displayName = "Disable Thermals";
			tooltip = "Disable Thermal vision for this vehicle when it respawns";
			typeName = "BOOL";
		};
		class SMM_customEquipment: CheckBox {
			property = "SMM_customEquipment";
			displayName = "Save Inventory";
			tooltip = "Vehicle will respawn with the equipment stored inside it at time of module execution, otherwise will keep default equipment on respawn";
			typeName = "BOOL";
		};
		class SMM_addToZeus: CheckBox {
			property = "SMM_addToZeus";
			displayName = "Add to Zeus";
			tooltip = "Automatically add the vehicle to Zeus control on respawn. Can be disabled if you don't want to Zeus to see or have control of the vehicle";
			typeName = "BOOL";
			defaultValue = "true";
		};
		class ModuleDescription: ModuleDescription{};
	};
	class ModuleDescription: ModuleDescription {
		description = "Synchronise this module to vehicle(s) that you want to have respawn on their original position after destruction";
	};
};
