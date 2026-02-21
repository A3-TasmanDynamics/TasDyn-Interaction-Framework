if (!isNil "TasDyn_InteractionMap") exitWith {};

TasDyn_InteractionMap = createHashMap;

addMissionEventHandler ["Draw3D", {
    if !(isNull (findDisplay 85001)) then {
        private _hoveredPos = uiNamespace getVariable ["TasDyn_HoveredPos3D", []];
        private _hoveredLabel = uiNamespace getVariable ["TasDyn_HoveredLabel", ""];
        
        if (_hoveredPos isNotEqualTo []) then {
            drawIcon3D [
                "", [0.2, 0.8, 0.2, 1], _hoveredPos, 0, 0, 0, 
                _hoveredLabel, 2, 0.035, "RobotoCondensed", "center"
            ];
        };
    };
}];

if (is3DENPreview) then { systemChat "[Tasman Dynamics] Interaction Framework Online."; };
