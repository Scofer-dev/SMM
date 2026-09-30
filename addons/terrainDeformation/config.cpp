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
        class terrainDeformation {
            PATHTO_FNCFOLDER(deformerModule);
            PATHTO_FNCFOLDER(rotateCoords);
        };
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
