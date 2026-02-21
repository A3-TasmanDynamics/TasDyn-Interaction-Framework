// Standard Arma 3 UI Constants
#define CT_STATIC 0
#define ST_LEFT 0x00
#define ST_PICTURE 0x30

class RscText {
    access = 0;
    type = CT_STATIC;
    idc = -1;
    style = ST_LEFT;
    colorBackground[] = {0, 0, 0, 0}; // 100% Transparent
    colorText[] = {1, 1, 1, 1};
    text = "";
    fixedWidth = 0;
    x = 0; 
    y = 0; 
    h = 0.037; 
    w = 0.3;
    font = "RobotoCondensed";
    sizeEx = 0.04;
    shadow = 1;
    linespacing = 1;
};

class RscPicture {
    access = 0;
    type = CT_STATIC;
    idc = -1;
    style = ST_PICTURE;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "RobotoCondensed";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0; 
    y = 0; 
    w = 0.2; 
    h = 0.15;
};
