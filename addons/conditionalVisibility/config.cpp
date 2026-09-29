#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVARMAIN(conditionalVisibility)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"smm_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class SMM {
        class conditionalVisibility {
            PATHTO_FNCFOLDER(conditionalVisibilityModule);
            PATHTO_FNCFOLDER(conditionalVisibility);
            PATHTO_FNCFOLDER(visibilityStatemachine);
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
