// GRID
class Grid
{
  int xNum, yNum;
  float size;
  Pixel[] Pixels;
  
  Grid(int x, int y, int s){
    xNum = x;
    yNum = y;
    size = s;   
    Pixels = new Pixel[xNum*yNum];    
    
    int index = 0;
    for(int i = 0; i < xNum; i++){
      for(int j = 0; j < yNum; j++){ 
        Pixels[index++] = new Pixel(size*i*zoom + offset.x, size*j*zoom + offset.y, size*zoom); 
      }
    } 
  }
  
  void update(){    
    int index = 0;
    for(int i = 0; i < xNum; i++){
      for(int j = 0; j < yNum; j++){ 
        Pixels[index++].update(size*i*zoom+offset.x, size*j*zoom+offset.y, size*zoom); 
      }
    }    
  }
  
  void colorPixelAt(int x, int y, color c){
    for(Pixel p : Pixels){        
        if(p.xpos > x-p.size){
          if(p.xpos <= x){            
            if(p.ypos > y-p.size){
              if(p.ypos <= y){                
                p.setColor(c);
              }
            }
          }
        }
    }
  }
  
  Pixel getPixel(int x, int y){    
    return Pixels[x+y*yNum];       
  }
  
  void applyImage(File f){    
    PImage img = loadImage(f.getAbsolutePath());
    img.resize(xNum, yNum);    
    loadPixels();
    for (int y = 0; y < yNum; y++){
      for (int x = 0; x < xNum; x++){
       int loc1 = x + y * xNum;
       int loc2 = y + x * yNum;
       Pixels[loc2].setColor(img.pixels[loc1]);    
      }  
    }
  }
  
  void fill(color c){
    for(Pixel p : Pixels){
      p.setColor(c);
    }  
  }
  void render(){ 
    for(Pixel p : Pixels){
      p.display();
    }  
  }
}
