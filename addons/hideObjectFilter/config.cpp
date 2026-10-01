#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVAR(module)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"smm_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class SMM {
        class hideObjectFilter {
            PATHTO_FNCFOLDER(hideObjectsModule);
            PATHTO_FNCFOLDER(hideObjects);
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
