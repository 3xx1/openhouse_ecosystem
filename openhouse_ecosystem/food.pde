class Food {
  ArrayList<PVector> food;
  
  Food(int num) {
    
    // Start with some food
    food = new ArrayList();
    for (int i = 0; i < num; i++) {
       food.add(new PVector(random(width), random(height), random(0,1))); 
    }
  } 
  
  // Add some food at a location
  void add(PVector l) {
     food.add(l.get()); 
  }
  
  // Display the food
  void run() {
    for (PVector f : food) {
       fill(0, 100);
       ellipse(f.x, f.y, 15+random(-2,2), 15+random(-2,2));
       
       float speed = map(f.z, 0, 1, 0.1, 3) * g_humidVal;
       float degree = map(f.z, 0, 1, 0, 8*PI-random(0,PI/2));
       f.x += speed * cos(degree);
       f.y += speed * sin(degree);
       if (f.x < 0) f.x += width;
       if (f.y < 0) f.y += height;
       if (f.x > width) f.x -= width;
       if (f.y > height) f.y -= height;
    } 
    
    // There's a small chance food will appear randomly
    if (random(0, 1) < g_lightVal && food.size() > 0) {
      PVector sample = food.get(int(random(0, food.size())));
      food.add(new PVector(random(width), random(height), sample.z)); 
    }
  }
  
  // Return the list of food
  ArrayList getFood() {
    return food; 
  }
}