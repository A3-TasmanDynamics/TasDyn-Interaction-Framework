params ["_vehicle", "_actionID", ["_absoluteState", -1]];

private _interactions = TasDyn_InteractionMap getOrDefault [typeOf _vehicle, []];
if (_interactions isEqualTo []) exitWith {};

private _targetInteraction = [];
{ if ((_x select 1) == _actionID) exitWith { _targetInteraction = _x; }; } forEach _interactions;
if (_targetInteraction isEqualTo []) exitWith {};

_targetInteraction params ["_memPoint", "_id", "_radius", "_label", "_type", "_animation"];

private _currentState = _vehicle animationSourcePhase _animation;
private _nextState = 0;

switch (_type) do {
    case "toggle": {
        if (_absoluteState != -1) then { _nextState = _absoluteState; } 
        else { _nextState = parseNumber (_currentState > 0.5); };
    };
    case "button": {
        _nextState = 1;
        [_vehicle, _animation] spawn {
            params ["_v", "_anim"];
            sleep 0.1;
            _v animateSource [_anim, 0, true];
        };
    };
    case "knob": {
        if (_absoluteState != -1) then { _nextState = _absoluteState; }
        else { _nextState = if (_currentState >= 1) then { 0 } else { _currentState + 0.25 }; };
    };
};

_vehicle animateSource [_animation, _nextState, true];

// Broadcast this state change to your proprietary Tasman Dynamics systems
// Create this function in your core mod to handle the actual engine logic!
private _sysFunc = missionNamespace getVariable ["TasDyn_fnc_onSystemStateChanged", {}];
[_vehicle, _actionID, _nextState] call _sysFunc;
