int lightVal, soundVal, moveVal;
float tempVal, humidVal;
float g_lightVal, g_soundVal, g_tempVal, g_humidVal, g_moveVal;

void globalSensorValueUpdate(int idx) {
  int dataNumber = ((288-1) - idx);
  if (idx > 288-1 || idx < 0) {
    return;
  } else {
    lightVal = dataToShow.getJSONObject(dataNumber).getInt(sensorType[0]);
    soundVal = dataToShow.getJSONObject(dataNumber).getInt(sensorType[1]);
    tempVal = dataToShow.getJSONObject(dataNumber).getFloat(sensorType[2]);
    humidVal = dataToShow.getJSONObject(dataNumber).getFloat(sensorType[3]);
    moveVal = dataToShow.getJSONObject(dataNumber).getInt(sensorType[4]);
    
    // Implemented as a chance of food appearance
    g_lightVal = map(lightVal, 0, 512, 0.0, 0.3);
    print("light trigger"); println(g_lightVal);
    // Implemented as a stress factor for tadpole
    g_soundVal = map(soundVal, 0, 512, 0.0, 1.0);
    
    // Implemented as an individual energy consumption acceleration/deceleration
    if (tempVal > 26.0) tempVal = 26.0; if (tempVal < 22.0) tempVal = 22.0; 
    g_tempVal = map(tempVal, 22.0, 26.0, -1.0, +1.0);
    
    // Implemented as how an individual is able to smoothly move
    if (humidVal > 40.0) humidVal = 40.0; if (humidVal < 30.0) humidVal = 30.0;
    g_humidVal = map(humidVal, 30.0, 40.0, 0.5, 1.5);
  }
}