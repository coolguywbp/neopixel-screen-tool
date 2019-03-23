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
    println(zoom);
    println(offset);
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
void mouseReleased(){
  cursor(ARROW);
}
void mouseDragged() 
{
  if(currentMode == "drag"){
    cursor(MOVE);
    PVector mouseV = new PVector(mouseX, mouseY);
    PVector drag = mouseV.sub(anchor).normalize();
    offset.add(drag.mult(zoom));
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

public void dragMode(){
  currentMode = "drag";
  dragBtn.setColorBackground(buttonActive);
  drawBtn.setColorBackground(buttonInactive);
}

public void drawMode(){
  currentMode = "draw";
  dragBtn.setColorBackground(buttonInactive);
  drawBtn.setColorBackground(buttonActive);
}

void clear(){
   G.fill(color(0, 0, 0)); 
}

void fill(){
   G.fill(currentColor); 
}
public void createOutput(){
  S.makeOutputFile();
}

public void chooseFile() {
  selectInput("Select a file to process:", "fileSelected", selection);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    println("Loading.......");
    
    G.applyImage(selection);   
  }
}
