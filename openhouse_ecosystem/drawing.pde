
// adding microscopic round shadow
void microscope() {
  int scopeSize = 300;
  stroke(0);
  strokeWeight(scopeSize);
  noFill();
  ellipse(width/2, height/2, width+scopeSize, height+scopeSize);
  strokeWeight(1);
  noStroke();  
}


void drawGraph() {
  // light
  fill(255, 255, 100);
  for(int i=0; i<dataToShow.size(); i++) {
    int lightVal = dataToShow.getJSONObject(i).getInt(sensorType[0]);
    if (lightVal > 100*4) lightVal = 100*4;
    rect(i, 100-lightVal/4, 3, lightVal/4);
  }
  
  // sound
  fill(0, 255, 100);
  for(int i=0; i<dataToShow.size(); i++) {
    int soundVal = dataToShow.getJSONObject(i).getInt(sensorType[1]);
    soundVal *= 3;
    if (soundVal > 100) soundVal = 100;
    rect(i, 200-soundVal, 3, soundVal);
  }
  
  // temp
  fill(255, 0, 0);
  for(int i=0; i<dataToShow.size(); i++) {
    int tempVal = dataToShow.getJSONObject(i).getInt(sensorType[2]);
    tempVal = (tempVal - 20) * 5;
    if (tempVal > 100) tempVal = 100;
    rect(i, 300-tempVal, 3, tempVal);
  }
  
  // humid
  fill(0, 0, 255);
  for(int i=0; i<dataToShow.size(); i++) {
    int humidVal = dataToShow.getJSONObject(i).getInt(sensorType[3]);
    humidVal = (humidVal - 30) * 5;
    if (humidVal > 100) humidVal = 100;
    rect(i, 400-humidVal, 3, humidVal);
  }
  
  // move 
  fill(0);
  for(int i=0; i<dataToShow.size(); i++) {
    int moveVal = dataToShow.getJSONObject(i).getInt(sensorType[4]);
    moveVal = moveVal * 5;
    if (moveVal > 100) moveVal = 100;
    rect(i, 500-moveVal, 3, moveVal);
  }
  
  
  stroke(0);
  line(0, 100, width, 100);
  line(0, 200, width, 200);
  line(0, 300, width, 300);
  line(0, 400, width, 400);
  line(0, 500, width, 500);
  
  stroke(0, 30);
  for(int i=1; i<3*24; i++) {
    if (i%12 == 0 ) {
      strokeWeight(2);
      if (i%24 == 0) {
        strokeWeight(4);
      }
    } else {
      strokeWeight(1);
    }
    line(i*12, 0, i*12, height);
  }
  noStroke();
}