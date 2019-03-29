import controlP5.*;
import processing.video.*;
import hypermedia.net.*;

Capture cam;
Movie mov;

ControlP5 cp5;
UDP udp;

int streamFrameRate = 10; //packets per second
int lastPacket;
int port = 9000;
String screenIP = "192.168.5.11";

int cols = 47;
int rows = 51;
int size = 10;

String currentMode = "draw";
Boolean captureOn = false;
Boolean streamingOn = false;
Boolean videoOn = false;

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
String currentFilename;

int controlWidth = 300;

int ctrl = 65535;

color recC = color(255,0,70);
color defaultC = color(0,70,160);
color hoverC = color(0,150,160);


int[][] screenScheme = {{13, 1},{21, 0},{25, 1},{29, 0},{31, 1},{33, 0},{35, 1},{37, 0},{39, 1},
{41, 0},{41, 1},{43, 0},{43, 1},{45, 0},{45, 1},{47, 0},{47, 1},{47, 0},{49, 1},{49, 0},{49, 1},{49, 0},
{49, 1},{49, 0},{49, 1},{47, 0},{47, 1},{47, 0},{45, 1},{45, 0},{43, 1},{43, 0},{41, 1},{41, 0},{39, 1},
{37, 0},{35, 1},{33, 0},{31, 1},{29, 0},{25, 1},{21, 0},{13, 1}};

void setup() {
  size(1000, 600); // Size must be the first statement
  stroke(255); // Set line drawing color to white
  G = new Grid(cols, rows, size);
  S = new Screen(screenScheme, G);
  udp = new UDP(this, port);
  udp.listen(true);
  
  colorMode(RGB, 255, 255, 255);
  offset.set(controlWidth + (width-controlWidth - cols*size)/2, (height - rows*size)/2);
  
  selection = new File(dataPath("") + "//*");
  
  cp5 = new ControlP5(this);  
  
  int modeButtonSize = 100;  
  
  
  cp5.addBackground("abc").
        setSize(controlWidth, height)
        ;
  
         
  cp5.addButton("createOutputFile")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(15, 15)
       .setSize(controlWidth - 30, modeButtonSize/2)
       .setColorBackground(defaultC)       
       .setColorForeground(defaultC) 
       .setBroadcast(true)
       ;
       
  cp5.addButton("chooseFile")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(15, 70)
       .setSize(controlWidth - 30, modeButtonSize/2)
       .setColorBackground(defaultC)       
       .setColorForeground(defaultC) 
       .setBroadcast(true)
       ;
   cp5.addButton("capture")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(15, 125)
       .setSize(controlWidth - 30, modeButtonSize/2)
       .setColorBackground(defaultC)       
       .setColorForeground(defaultC) 
       .setBroadcast(true)
       ;
  cp5.addButton("stream")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(15, 180)
       .setSize(controlWidth - 30, modeButtonSize/2)
       .setColorBackground(defaultC)       
       .setColorForeground(defaultC) 
       .setBroadcast(true)
       ;
  cp5.addButton("send")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(15, 235)
       .setSize(controlWidth - 30, modeButtonSize/2)
       .setColorBackground(defaultC)       
       .setColorForeground(defaultC) 
       .setBroadcast(true)
       ;
  cp5.addColorWheel("currentColor", 15, 350, controlWidth - 100 ).setRGB(color(128,0,255));
  
  cp5.addButton("clear")
       .setValue(0)
       .setPosition(controlWidth - 70, 350)
       .setSize(50,50)       
       ;
       
  cp5.addButton("fill")
       .setBroadcast(false)
       .setValue(0)
       .setPosition(controlWidth - 70, 400)
       .setSize(50,50)       
       .setBroadcast(true)
       ;
  
  String[] cameras = Capture.list();  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cols, rows);
    cam.start();     
  }     
    
}

void draw() {    
  background(51);  
  S.update();
} 
