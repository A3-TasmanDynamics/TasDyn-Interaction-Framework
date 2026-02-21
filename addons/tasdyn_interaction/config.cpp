#define _ARMA_

class CfgPatches
{
    class tasdyn_interaction {
        name = "Tasman Dynamic - Interaction Framework";
        author = "Tasman Dynamic";
        requiredVersion = 2.14;
        requiredAddons[] = {"A3_UI_F", "A3_Data_F"};
        units[] = {};
        weapons[] = {};
    };
};

class CfgFunctions {
    class TasDyn {
        class Interaction {
            file = "tasdyn\addons\tasdyn_interaction\functions";

            class initInteraction { preInit = 1; };

            class detachedCursorLoop {};
            class handleCursorClick {};
            class handleScrollWheel {};

            class executeAction {};
            class snapToPanel {};
        };
    };
};

class CfgUserActions {
    class TasDyn_Action_ToggleOverlay {
        displayName = "Toggle Clickable Cockpit";
        tooltip = "Tasman Dynamics: Open the interactive cursor overlay.";
        onActivate = "if (dialog) then { closeDialog 0; } else { createDialog 'TasDyn_InteractiveOverlay'; };";
    };

    class TasDyn_Action_BattMain_Toggle {
        displayName = "Toggle BattMain Overlay";
        tooltip = "Tasman Dynamics: Electrical";
        onActivate = "[vehicle player, 'TasDyn_BattMain'] call TasDyn_fnc_executeAction;";
    };
};

class CfgUserActionGroups {
    class TasDyn_ActionGroup {
        displayName = "Tasman Dynamic - Interaction Framework";
        isAddon = 1;
        groups[] = {
            "TasDyn_Action_ToggleOverlay",
            "TasDyn_Action_BattMain_Toggle"
        };
    };
};

class CfgDefaultKeysPreset {
    class Arma2 {
        class Mappings {
            TasDyn_Action_ToggleOverlay[] = {0x2E};
        };
    };
};

#include "ui\defines.hpp"
#include "ui\overlay.hpp"
