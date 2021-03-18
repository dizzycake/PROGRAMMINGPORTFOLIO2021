class EnemyLaser {
  int x, y, speed, r, power; 
  color c;
  
 EnemyLaser(int x, int y) {
    r = 4; 
    power = 100;
    this.x = x; 
    this.y = y; 
    speed = 7;    
    c = color(0, 0, 255);
  }
  
  void fire() {
    y += speed;
  }
  
  boolean reachedBottom() {
    if (y > height) { 
      return true;
    } else {
      return false;
    }
  }
  
  void display() {
    fill(c);
    noStroke();
    rect(x, y, r, 8);
  }
  
}
