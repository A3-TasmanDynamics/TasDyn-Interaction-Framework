disableSerialization;
params ["_control", "_button"];

if (_button != 0) exitWith {};

private _activeAction = uiNamespace getVariable ["TasDyn_HoveredAction", ""];
if (_activeAction == "") exitWith {};

[vehicle player, _activeAction] call TasDyn_fnc_executeAction;
playSound "click";
