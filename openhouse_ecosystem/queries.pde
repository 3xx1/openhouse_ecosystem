import http.requests.*;

void queryInitialRequest() 
{
  println("initial request queried");
  
  // fetching fake data for now as the server is not working...
  GetRequest getReq = new GetRequest("http://3xx1.info/studio-sensor-data-fake.json");
  // GetRequest getReq = new GetRequest("https://studio-sensors.cloudint.frogdesign.com/view?studio=sea&limit=14400");
  getReq.send();
  sensorData = parseJSONArray(getReq.getContent());
}

void queryNewRequest()
{
  println("new request queried");
  
  //fetch data and store them to arrays
  GetRequest getReq = new GetRequest("https://studio-sensors.cloudint.frogdesign.com/view?studio=sea&limit=5");
  getReq.send();
  JSONArray response = parseJSONArray(getReq.getContent());
  
  //pushing array to renew first 5 data and discard 5 last data
  for (int i=sensorData.size()-1; i>4; i--) 
  {
    sensorData.setJSONObject(i, sensorData.getJSONObject(i-5));
  }
  for (int i=0; i<5; i++) {
    sensorData.setJSONObject(i, response.getJSONObject(i));
  }
}