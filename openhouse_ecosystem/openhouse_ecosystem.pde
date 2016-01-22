// caution!!! projection mapping part includes some stupid bugs.

import processing.opengl.*;

int selected = -1;
int pos[][] = {{0,0},{1000,0},{1000,1000},{0,1000}};
int switchState[] = new int[12];
int round = 0;
int currentTimeIndex;

// setup function
void setup() {
  // size(800, 800, P3D);
  fullScreen(P3D);
  frame.setLocation(300, 0); 
  world = new World(50);
  smooth();
  
  // initial data fetch, relatively huge
  queryInitialRequest();
  switchingDataToShow(0);
  println(sensorLocation[0]);
  frameRate(FRAME_RATE);
  
  myPort = new Serial(this, "/dev/tty.usbmodem1421", 9600);
  
  for(int i=0; i<12; i++) {
    switchState[i] = 1;
  }
  
  for(int i=0;i<SIZE;i++) {
    ripples[i] = new Ripple();
  }
}

// main loop
void draw() {
  
  background(31+lightVal, 47+lightVal, 84+lightVal);
  // print("light val: "); println(lightVal);
  world.run();
  if(frameCount%500 == 0) world.born(random(0, mouseX), random(0, mouseY));
  
  // timer for autoquery new data
  if(timer>queryCycle)
  {
    timer = 0;
    // queryNewRequest();
  }
  timer++;
  
  // drawing functions
  // background(255);
  // drawGraph(); //disable in the real app
  // print("Current Minutehand: "); println(minuteHandCurrent);
  
  round += clockEventHandler();
  currentTimeIndex = (round-1)*12 + (12-minuteHandCurrent);
  if (currentTimeIndex < 0) currentTimeIndex += 288;
  if (currentTimeIndex > 288-1) currentTimeIndex -= 288;
  print("Current Time Index: "); println(currentTimeIndex);
  
  globalSensorValueUpdate(currentTimeIndex);
  
  // drawing ripple
  for(int i=0;i<SIZE;i++) {
    if(ripples[i].getFlag()) {
      ripples[i].move();
      ripples[i].rippleDraw();
    }
  }
  
  microscope();
  
  loadPixels();
  PImage screenshot = createImage(width, height, RGB);
  for (int i=0; i<height*width; i++) {
    screenshot.pixels[i] = pixels[i];
  }
  
  background(0);
  
  if (g_soundVal > random(1)) {
    for(int i=SIZE-1;i>0;i--) {
      ripples[i] = new Ripple(ripples[i-1]);
    }
    ripples[0].init(int(random(0, mouseX)), int(random(0, mouseY)), random(5,15), int(random(10,80)));
  }
  
  // stroke(255);
  beginShape();
    texture(screenshot);  
    vertex(pos[0][0], pos[0][1], 0, 0);
    vertex(pos[1][0], pos[1][1], screenshot.width, 0);
    vertex(pos[2][0], pos[2][1], screenshot.width, screenshot.height);
    vertex(pos[3][0], pos[3][1], 0, screenshot.height);
  endShape(CLOSE);
  
  stroke(255);
  if ( mousePressed && selected >= 0 ) {
    pos[selected][0] = mouseX;
    pos[selected][1] = mouseY;
  }
  else {
    float min_d = 20; 
    selected = -1;
    for (int i=0; i<4; i++) {
      float d = dist( mouseX, mouseY, pos[i][0], pos[i][1] );
      if ( d < min_d ) {
        min_d = d;
        selected = i;
      }
    }
  }
  if ( selected >= 0 ) {
    fill(222);
    ellipse( mouseX, mouseY, 20, 20 );
  }
}