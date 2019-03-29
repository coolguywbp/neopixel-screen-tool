void mouseWheel(MouseEvent event) {
  if(currentMode == "drag"){
    float e = event.getCount();  
    if(e < 0 && zoom <= zoomMax){
      zoom+= zoomstep;  
    }else if(zoom >= zoomMin){
      zoom-= zoomstep;
    }
    offset.x = mouseX - size*rows*zoom/2;
    offset.y = mouseY - size*cols*zoom/2;  
  }
}

void mouseClicked(){
  if(currentMode == "draw"){    
    G.colorPixelAt(mouseX, mouseY, currentColor);    
  }
}
void mousePressed(){
  anchor.x = mouseX;
  anchor.y = mouseY;
}

void mouseDragged() 
{
  if(currentMode == "drag"){
    
    PVector mouseV = new PVector(mouseX, mouseY);
    PVector drag = mouseV.sub(anchor).normalize();
    offset.add(drag.mult(zoom*2.5));
    dragSteps++;
    
    if(dragSteps <= 5){
      anchor.x = mouseX;
      anchor.y = mouseY;  
    }else{
      dragSteps = 0;
    }
  }else if(currentMode == "draw"){
    G.colorPixelAt(mouseX, mouseY, currentColor);
  }
}

void keyPressed() {
  if(int(key)==ctrl){
    currentMode = "drag";
    cursor(MOVE);
  }
}

void keyReleased(){
  if(int(key)==ctrl){
    cursor(ARROW);
    currentMode = "draw";
  }
}

void controlEvent(ControlEvent theEvent) {
  if(theEvent.isController()){
    
    Controller c = theEvent.getController();
    
    if(c.getName() == "capture"){
      if(captureOn){
        c.setColorBackground(recC);
        c.setColorForeground(recC);
      }else{
        c.setColorBackground(defaultC);
        c.setColorForeground(defaultC);      
      }
    }else if(c.getName() == "stream"){
      if(streamingOn){
        c.setColorBackground(recC);
        c.setColorForeground(recC);
      }else{
        c.setColorBackground(defaultC);
        c.setColorForeground(defaultC);      
      }
    }
  }
}

void clear(){
   G.fill(color(0, 0, 0)); 
}

void fill(){
   G.fill(currentColor); 
}
public void createOutputFile(){
  S.makeOutputFile();
}

public void chooseFile() {
  selectInput("Select a file to process:", "fileSelected", selection);
}

public void capture(){
  captureOn = !captureOn;
}

public void stream(){
  streamingOn = !streamingOn;
}

public void send(){
  S.streamUDP();
}


void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    currentFilename = selection.getName();
    String fileName = selection.getAbsolutePath();
    println("User selected " + fileName);
    println("Loading.......");
    
    if(isImage(fileName)){
      PImage img = loadImage(fileName);
      G.applyImage(img);
    }else if(isVideo(fileName)){
      mov = new Movie(this, fileName);
      mov.volume(0);
      mov.play();
      videoOn = true;
    }
      
  }
}

boolean isImage(String loadPath) {
return (
   loadPath.endsWith(".jpg") ||
   loadPath.endsWith(".jpeg") ||
   loadPath.endsWith(".png")  ) ;
}

boolean isVideo(String loadPath) {
return (
   loadPath.endsWith(".mov") ||
   loadPath.endsWith(".avi")
   ) ;
}
