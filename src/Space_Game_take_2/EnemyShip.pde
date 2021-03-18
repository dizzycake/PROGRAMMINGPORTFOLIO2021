class EnemyShip {
  //member variables
  PImage enemy;
  int x, y, r, health, speed, healthStart;
  int savedTime;
  int totalTime;
  boolean right;

  //constructor
  EnemyShip(int x, int y, int t, int health) {
    healthStart = health;
    r = 25;
    this.x = x;
    this.y = y;
    this.health = health;
    speed = 5;
    this.totalTime = t;
    enemy = loadImage("enemy.png");
  }

  //display method
  void display() {
    image(enemy, x, y, 63, 63);
  }

  void move() {
    x += speed;
    if (x >= width|| x <= 0) {
      speed *= -1;
   //   y+=(random(10,30));
      
    }
  }

  boolean laserIntersect(Laser laser) {
    // Calculate distance
    float distance = dist(x, y, laser.x, laser.y); 

    // Compare distance to sum of radii
    if (distance < r + laser.r) { 
      return true;
    } else {
      return false;
    }
  }

  void start() {
    savedTime = millis();
  }

  boolean isFinished() { 
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
