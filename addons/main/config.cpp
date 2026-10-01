#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_main",
            "cba_xeh"
        };
        author = "Scofer";
        VERSION_CONFIG;
    };
};

class CfgFunctions {
    class SMM {
        class main {
            PATHTO_FNCFOLDER(missionLoad3DEN);
        };
    };
};

class Cfg3DEN {
    class EventHandlers {
        class SMM {
            onMissionLoad = "spawn SMM_fnc_missionLoad3DEN";
        };
    };
};

#include "CfgFactionClasses.hpp"
#include "CfgEventHandlers.hpp"
