#include "\x\cba\addons\main\script_macros_common.hpp"

// #define DISABLE_COMPILE_CACHE

#ifdef DISABLE_COMPILE_CACHE
    #define PREPFOLDER(fncName) DFUNC(fncName) = compileScript [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)]
#else
    #define PREPFOLDER(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define PATHTO_FNCFOLDER(func) class func {\
    file = QPATHTOF(functions\DOUBLES(fnc,func).sqf);\
    CFGFUNCTION_HEADER;\
    RECOMPILE;\
}
