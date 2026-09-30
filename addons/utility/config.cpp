#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"smm_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class SMM {
        class utility {
            PATHTO_FNCFOLDER(rotateCoords);
        };
    };
};

#include "CfgEventHandlers.hpp"
