

// Swithing DataToShow Data

void keyPressed() {
  if(key == '1')
  {
    switchingDataToShow(0);
    println(sensorLocation[0]);
  }
  
  if(key == '2')
  {
    switchingDataToShow(1);
    println(sensorLocation[1]);
  }
  
  if(key == '3')
  {
    switchingDataToShow(2);
    println(sensorLocation[2]);
  }
  
  if(key == '4')
  {
    switchingDataToShow(3);
    println(sensorLocation[3]);
  }
  
  if(key == '5')
  {
    switchingDataToShow(4);
    println(sensorLocation[4]);
  }
}

// actual data switch function
void switchingDataToShow(int channel) 
{  
  for(int i=dataToShow.size()-1; i>-1; i--) dataToShow.remove(i);
  for(int i=0; i<sensorData.size(); i++) {
    if( i%5 == 0 ) {
      dataToShow.append(sensorData.getJSONObject(i));
    }
  }
}