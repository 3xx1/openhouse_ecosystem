import processing.serial.*;

int FRAME_RATE = 30;
int timer = 0;
int queryCycle = 60*5*FRAME_RATE; // Cycle for query in [sec] setup as 300[sec] = 5[mins]
int sensorId[] = {13, 8, 39, 14, 44};
String sensorLocation[] = {"East Pen", "Kitchen", "Sound Garden", "Maker Space", "Ziggurat"};
String sensorType[] = {"light", "sound", "temp", "humidity", "movement"};

JSONArray sensorData;
JSONArray dataToShow = new JSONArray();

World world;
float angleX, angleY;

// Serial Port for Clock communication
Serial myPort;