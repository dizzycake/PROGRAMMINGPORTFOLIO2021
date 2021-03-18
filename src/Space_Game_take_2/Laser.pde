class Laser {
  //member variables
  int x, y, speed, r;
  color c;

  //constructor
  Laser(int x, int y) {
    this.x = x;
    this.y = y;
    c = color(255);
    speed = 20;
    r = 3;
  }

  //display method
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(c);
    rect(x, y, 3, 6);
  } 

  void fire() {
    y-=speed;
  }

  boolean reachedTop() {
    if (y<0) {
      return true;
    } else {
      return false;
    }
  }
}
