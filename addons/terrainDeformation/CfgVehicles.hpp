class CfgVehicles {
	class Logic;
	class Module_F: Logic {
        class AttributesBase {
            class Default;
            class Edit; // Default edit box (i.e., text input field)
            class Combo; // Default combo box (i.e., drop-down menu)
            class CheckBox; // Tickbox, returns true/false
            class CheckBoxNumber; // Tickbox, returns 1/0
            class ModuleDescription; // Module description
        };
        class ModuleDescription {
            class Anything;
        };
    };
	#include "modules\SMM_terrainDeformation.hpp"
};
