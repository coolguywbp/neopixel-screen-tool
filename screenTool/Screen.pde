//SCREEN

class Screen
{
  Grid grid;
  Pixel[] leds;
  int ledsLength = 0;
  int[][] scheme;  
  int colsNum;  
  int startCol;
  
  Screen(int[][] s, Grid g){
    grid = g;
    scheme = s;   
    colsNum = screenScheme.length;    
    startCol = (g.xNum - colsNum)/2;
     
    //Считаем длину массива leds
    for(int[] col:scheme){
      ledsLength+=col[0];      
    }
    
    leds = new Pixel[ledsLength];
    
    //Находим пиксели в гриде, заносим их в массив учитывая конфигурацию схемы и активируем
    
    int index = 0;
    //Прогоняем по количеству столбцов в схеме
    for(int j = 0; j < colsNum; j++){
      //Определяем количество пикселей в столбце и направление
      int num = scheme[j][0];
      int directionForward = scheme[j][1];
      
      //Прогоняем столбец в гриде, располагаем пиксели в середине
      for(int i = 0; i < grid.yNum; i++){        
        if(i >= (grid.yNum - num)/2 && i < grid.yNum - (grid.yNum - num)/2){  
          Pixel p;
          //Учитываем направление
          if(directionForward == 1){
            p = grid.getPixel(i, startCol+j); 
          }else{
            p = grid.getPixel(grid.yNum  - i - 1, startCol+j);
          }
          //Добавляем и активируем
          leds[index++] = p;
          p.setActive(true);
                    
        }
      }      
    }
  }
  
  void update(){
    grid.update();
    grid.render();
    
    if(streamingOn == true){
      if(millis() - lastPacket >= 1000/streamFrameRate){
        streamUDP();
      }
    }
  }   
  
  
  void makeOutputFile(){
    
    
    String filename = "output/" + currentFilename+ ".txt";    
    println("Making output file: " + filename);
    PrintWriter outputFile = createWriter(filename);
    String hex;
    outputFile.print("{");
    for(int i = 0; i < ledsLength; i++){
      hex = hex(leds[i].Color);
      hex = setCharAt(hex, 0 , char(48));
      hex = setCharAt(hex, 1 , char(120));
      outputFile.print(hex);
      outputFile.print(",");
    }
    outputFile.print("},");
    outputFile.flush(); // Writes the remaining data to the file
    outputFile.close();
    println("Output file saved");
  }
  
  void streamUDP(){    
    int packetSize = 3;
    int limit = ledsLength;
    
    byte[] data  = new byte[limit * packetSize];
    //println(data.length);
    
    for(int i = 0; i < limit; i++){
      data[i*3] = byte(hue(leds[i].Color));
      data[i*3+1] = byte(saturation(leds[i].Color));
      data[i*3+2] = byte(brightness(leds[i].Color));
      if(i == 0){
        println(hue(leds[i].Color), saturation(leds[i].Color), brightness(leds[i].Color));
      }
    }
    udp.send( data, screenIP, port );
    lastPacket = millis();    
    
  }
}

String setCharAt(String s, int pos, char c) {
  return s.substring(0,pos) + c + s.substring(pos+1);
}
