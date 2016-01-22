
int minuteHandCurrent = -1;
int minuteHandPrevious = -1;

// returns 1 if fastforward, returns -1 if rewinded, returns 0 if nothing is going on
// minuteHandCurrent stores where the minute hand is currently located
int clockEventHandler() {
  
  if( myPort.available() > 11 ) {
    print("Current State: ");
    for (int i=0; i<12; i++) {
      switchState[i] = myPort.read();
      print(switchState[i]);
    }
    println("");
    myPort.write(255);
  }
  
  for (int i=0; i<12; i++) {
    if (switchState[i] < 1) {
      minuteHandCurrent = i;
      if (minuteHandPrevious < 0) minuteHandPrevious = minuteHandCurrent;
      if (minuteHandPrevious == 11 && minuteHandCurrent == 0) {
        minuteHandPrevious = minuteHandCurrent;
        return -1;
      } else if (minuteHandCurrent == 11 && minuteHandPrevious == 0) { 
        minuteHandPrevious = minuteHandCurrent;
        return 1;
      } else {
        minuteHandPrevious = minuteHandCurrent;
        return 0;
      }
    }
  }
  
  return 0;
}

// to start serial communication
void mousePressed() {
  myPort.write(255);
}