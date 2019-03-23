import controlP5.*;

ControlP5 cp5;
int controlWidth = 300;

int cols = 45;
int rows = 51;
int size = 10;

String currentMode = "draw";

float zoom = 1;
float zoomstep = 0.05;
float zoomMin = 0.5;
float zoomMax = 5;
int dragSteps = 0;
PVector anchor = new PVector();
PVector offset = new PVector();

color currentColor = color(0,160,70);
color pixelInactiveColor = color(169,169,169);
Grid G;
Screen S;


File selection;

Button dragBtn, drawBtn;

color buttonActive = color(0,160,70);
color buttonInactive = color(0,70,160);

int[][] screenScheme = {{13, 1},{21, 0},{25, 1},{29, 0},{31, 1},{33, 0},{35, 1},{37, 0},{39, 1},
{41, 0},{41, 1},{43, 0},{43, 1},{45, 0},{45, 1},{47, 0},{47, 1},{49, 0},{49, 1},{49, 0},{49, 1},
{49, 0},{49, 1},{49, 0},{47, 1},{47, 0},{45, 1},{45, 0},{43, 1},{43, 0},{41, 1},{41, 0},{39, 1},
{37, 0},{35, 1},{33, 0},{31, 1},{29, 0},{25, 1},{21, 0},{13, 1}};

void setup() {
  size(1000, 600); // Size must be the first statement
  stroke(255); // Set line drawing color to white
  G = new Grid(cols, rows, size);
  S = new Screen(screenScheme, G);
  
  S.render();
  offset.set(controlWidth + (width-controlWidth - cols*size)/2, (height - rows*size)/2);
  
  selection = new File(dataPath("") + "//*.jpg");
  
  cp5 = new ControlP5(this);  
  
  int modeButtonSize = 100;  
  
  
  cp5.addBackground("abc").
        setSize(controlWidth, height)
        ;
  dragBtn = cp5.addButton("dragMode")
       .setValue(0)
       .setPosition(controlWidth/2 + (controlWidth/2 - modeButtonSize)/2, height - 15 - modeButtonSize)
       .setSize(modeButtonSize,modeButtonSize)
       .setColorBackground(buttonInactive)
       ;
  drawBtn = cp5.addButton("drawMode")
       .setValue(0)
       .setPosition((controlWidth/2 - modeButtonSize)/2, height - 15 - modeButtonSize)
       .setSize(modeButtonSize,modeButtonSize)
       .setColorBackground(buttonActive)
       ;
         
  cp5.addButton("createOutput")
       .setValue(0)
       .setPosition(15, 15)
       .setSize(controlWidth - 30, modeButtonSize)
       .setColorBackground(buttonInactive)
       ;
       
  cp5.addButton("chooseFile")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(15, modeButtonSize + 30)
       .setSize(controlWidth - 30, modeButtonSize)
       .setBroadcast(true)
       ;
  cp5.addColorWheel("currentColor", 15, modeButtonSize*2 + 55, controlWidth - 100 ).setRGB(color(128,0,255));
  
  cp5.addButton("clear")
       .setValue(0)
       .setPosition(controlWidth - 70, height - 325)
       .setSize(50,50)       
       ;
       
  cp5.addButton("fill")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(controlWidth - 70, height - 225)
       .setSize(50,50)       
       .setBroadcast(true)
       ;
}
void draw() {    
  background(200, 200, 200);  
  G.update();
  G.render();
} 
