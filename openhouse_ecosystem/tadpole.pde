class Bloop {
  PVector location; // Location
  PVector location_p = new PVector(0.0, 0.0);
  PVector velocity; // Velocity
  DNA dna;          // DNA
  float health;     // Life timer
  float xoff;       // For perlin noise
  float yoff;
  // DNA will determine size and maxspeed
  float r;
  float maxspeed;
  float atp;

  // Create a "bloop" creature
  Bloop(PVector l, DNA dna_) {
    location = l.get();
    health = 200;
    xoff = random(1000);
    yoff = random(1000);
    dna = dna_;
    // Gene 0 determines maxspeed and r
    // The bigger the bloop, the slower it is
    maxspeed = map(dna.genes[1], 0, 1, 0, 10);
    r = map(dna.genes[0], 0, 1, 0, 80);
    atp = (maxspeed/50.0) + r/400.0 + 0.03;
  }

  void run() {
    update();
    borders();
    display();
  }

  // A bloop can find food and eat it
  void eat(Food f) {
    ArrayList<PVector> food = f.getFood();
    // Are we touching any food objects?
    for (int i = food.size()-1; i >= 0; i--) {
      PVector foodLocation = food.get(i);
      float d = PVector.dist(location, foodLocation);
      // If we are, juice up our strength!
      if (d < r/2) {
        health += 100; 
        food.remove(i);
      }
    }
  }

  // At any moment there is a teeny, tiny chance a bloop will reproduce
  Bloop reproduce() {
    // asexual reproduction
    if (random(1) < 0.0005) {
      // Child is exact copy of single parent
      DNA childDNA = dna.copy();
      // Child DNA can mutate
      childDNA.mutate(0.01);
      return new Bloop(location, childDNA);
    } 
    else {
      return null;
    }
  }

  // Method to update location
  void update() {
    // Simple movement based on perlin noise
    float vx = map(noise(xoff),0,1,-maxspeed,maxspeed) * g_humidVal;
    float vy = map(noise(yoff),0,1,-maxspeed,maxspeed) * g_humidVal;
    velocity = new PVector(vx,vy);
    xoff += 0.01;
    yoff += 0.01;
    
    location.add(velocity);
    // Death always looming
    float consumption = atp + g_tempVal;
    if (consumption < 0.00001) consumption = 0.00001;
    health -= consumption;
    health -= random(0.0, g_soundVal);
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    noStroke();
    bodyshaping(location, velocity, health);
  }
  
  // drawing a body
  void bodyshaping(PVector l, PVector v, float h) {
    fill(0+(g_tempVal+1.0)*20, 0, 0, h);
    float v_abs = abs(sqrt(pow(v.x, 2.0) + pow(v.y, 2.0)));
    float v_deg = atan2(v.y, v.x);
    pushMatrix();
      translate(l.x, l.y);
      rotate(v_deg);
      arc(0, 0, r, r/2-v_abs*2, -PI/2, PI/2);
      beginShape();
        vertex(0, (-r/2+v_abs*2)/2);
        bezierVertex(-r+random(-5,5), v_abs*2, -r+random(-5,5), -v_abs*2, 0, (r/2-v_abs*2)/2);
      endShape();
    popMatrix();
  }

  // Death
  boolean dead() {
    if (health < 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}