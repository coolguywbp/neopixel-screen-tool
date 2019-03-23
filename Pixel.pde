//PIXEL
class Pixel
{
  float xpos, ypos, size;
  boolean active = false;
  color Color = color(0, 0, 0);
  
  Pixel(float x, float y, float s){
    xpos = x;
    ypos = y;
    size = s;
  }
  
  void display(){
    strokeWeight(1);
    stroke(0);      
    
    if(active){    
      if(Color == color(0, 0, 0)){
        fill(color(255,255,255));
      }else{      
        fill(Color);
      }
    }else{
      fill(pixelInactiveColor);
    }
    rect(xpos, ypos, size, size);
  }
  
  void update(float x, float y, float s){
    xpos = x;
    ypos = y;
    size = s;
  }
  
  void setColor(color c){
    if(active){
      Color = c;
    }
  }
  void setActive(boolean b){
    active = b;
  }
}
