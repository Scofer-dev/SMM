#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {
            QGVARMAIN(vehicleRespawn)
        };
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"smm_main"};
        author = "Scofer";
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class SMM {
        class vehicleRespawn {
            PATHTO_FNCFOLDER(vehicleRespawnModule);
            PATHTO_FNCFOLDER(vehicleRespawn);
            PATHTO_FNCFOLDER(vehicleRespawnEvent);
        };
    };
};


#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
