class TasDyn_InteractiveOverlay {
    idd = 85001; 
    movingEnable = 0; 
    enableSimulation = 1; // Keeps the helicopter flying!
    enableDisplay = 1;

    // Trigger our compiled SQF scripts on mouse input
    onMouseMoving = "_this call TasDyn_fnc_detachedCursorLoop;";
    onMouseButtonDown = "_this call TasDyn_fnc_handleCursorClick;";
    onMouseZChanged = "_this call TasDyn_fnc_handleScrollWheel;";
    onUnload = "uiNamespace setVariable ['TasDyn_HoveredAction', ''];";

    class controlsBackground {
        class TransparentBackground: RscText {
            idc = -1;
            x = "safeZoneX";
            y = "safeZoneY";
            w = "safeZoneW";
            h = "safeZoneH";
            colorBackground[] = {0, 0, 0, 0}; 
        };
    };

    class controls {
        class CustomCursor: RscPicture {
            idc = 85002; 
            // Fallback to vanilla Arma crosshair until the SQF script moves it
            text = "\a3\ui_f\data\igui\cfg\cursors\weapon_ca.paa"; 
            x = -10; // Spawn it off-screen initially
            y = -10; 
            w = 0.03; 
            h = 0.04; 
        };
    };
};
