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
     
    //Считаем длину массива с ледами
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
  
  void render(){
    
  }   
  
  
  void makeOutputFile(){
    PrintWriter outputFile = createWriter("output/output.txt");
    //String[] output = new String[ledsLength];
    for(int i = 0; i < ledsLength; i++){
      outputFile.println(hex(leds[i].Color));
    }
    outputFile.flush(); // Writes the remaining data to the file
    outputFile.close();
  }
}
