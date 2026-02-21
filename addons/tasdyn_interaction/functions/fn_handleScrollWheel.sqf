disableSerialization;
params ["_display", "_scrollValue"];

private _activeAction = uiNamespace getVariable ["TasDyn_HoveredAction", ""];
if (_activeAction == "") exitWith { false };

private _vehicle = vehicle player;
private _interactions = TasDyn_InteractionMap getOrDefault [typeOf _vehicle, []];

private _targetInteraction = [];
{ if ((_x select 1) == _activeAction) exitWith { _targetInteraction = _x; }; } forEach _interactions;
if (_targetInteraction isEqualTo []) exitWith { false };

_targetInteraction params ["_memPoint", "_id", "_radius", "_label", "_type", "_animation"];

if (_type != "knob") exitWith { false };

private _currentState = _vehicle animationSourcePhase _animation;
private _step = 0.1;
private _nextState = _currentState;

if (_scrollValue > 0) then { _nextState = (_currentState + _step) min 1; } 
else { _nextState = (_currentState - _step) max 0; };

[_vehicle, _activeAction, _nextState] call TasDyn_fnc_executeAction;
playSound "click";
true;
