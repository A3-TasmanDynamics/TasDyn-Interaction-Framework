disableSerialization;
params ["_display", "_mouseX", "_mouseY"];

private _vehicle = vehicle player;
if (_vehicle == player) exitWith {};

private _cursorCtrl = _display displayCtrl 85002;
_cursorCtrl ctrlSetPosition [_mouseX - 0.015, _mouseY, 0.03, 0.04];
_cursorCtrl ctrlCommit 0;

private _interactions = TasDyn_InteractionMap getOrDefault [typeOf _vehicle, []];
private _nearestPoint = "";
private _closestDist = 999;
private _activeLabel = "";
private _activeID = "";
private _activePos3D = [];

{
    _x params ["_memPoint", "_actionID", "_radius", "_label"];
    private _pos3D = _vehicle modelToWorldVisual (_vehicle selectionPosition _memPoint);
    private _pos2D = worldToScreen _pos3D;
    
    if (_pos2D isNotEqualTo []) then {
        private _dist = [_mouseX, _mouseY] distance2D _pos2D;
        if (_dist < _radius && _dist < _closestDist) then {
            _closestDist = _dist;
            _nearestPoint = _memPoint;
            _activeLabel = _label;
            _activeID = _actionID;
            _activePos3D = _pos3D;
        };
    };
} forEach _interactions;

if (_nearestPoint != "") then {
    _cursorCtrl ctrlSetText "\a3\ui_f\data\igui\cfg\actions\take_ca.paa"; 
    _cursorCtrl ctrlSetTextColor [0, 1, 0, 1]; 
} else {
    _cursorCtrl ctrlSetText "\a3\ui_f\data\igui\cfg\cursors\weapon_ca.paa"; 
    _cursorCtrl ctrlSetTextColor [1, 1, 1, 1]; 
};

uiNamespace setVariable ["TasDyn_HoveredAction", _activeID];
uiNamespace setVariable ["TasDyn_HoveredLabel", _activeLabel];
uiNamespace setVariable ["TasDyn_HoveredPos3D", _activePos3D];
