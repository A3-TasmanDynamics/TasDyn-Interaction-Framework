params ["_vehicle", "_panelMemoryPoint"];

if (player getVariable ["TasDyn_InPanelView", false]) exitWith {
    player cameraEffect ["terminate", "back"];
    camDestroy TasDyn_ActiveCamera;
    player setVariable ["TasDyn_InPanelView", false];
};

private _camPos = positionCameraToWorld [0,0,0];
TasDyn_ActiveCamera = "camera" camCreate _camPos;
TasDyn_ActiveCamera cameraEffect ["internal", "BACK"];
TasDyn_ActiveCamera attachTo [_vehicle, [0,0,0], _panelMemoryPoint];
TasDyn_ActiveCamera camSetFov 0.7; 
TasDyn_ActiveCamera camSetTarget (_vehicle modelToWorld (_vehicle selectionPosition _panelMemoryPoint));
TasDyn_ActiveCamera camCommit 0.4;

player setVariable ["TasDyn_InPanelView", true];
