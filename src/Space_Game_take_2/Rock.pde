class Rock {
  //member variables
  PImage rock;
  int x, y, speed, r, health, healthStart;
  //constructor
  Rock(int x, int y) {
    r = int(random(20,30));
    this.x = x;
    this.y = y;
    speed = int(random(2, 5));
    rock = loadImage("rock.png");
    r = 25;
    health = r;
  }

  //display method
  void display() {
    image(rock, x,y, 40, 40);
  }

  void move() {
    y+=speed;
  }

//rock laser collision
boolean laserIntersection(Laser laser) {
    float distance = dist(x,y,laser.x,laser.y);
    if(distance < r + laser.r){
      return true;
      } else {
        return false;
      }
    }

  boolean reachedBottom() {
    if (y>height+10) {
      return true;
    } else {
      return false;
    }
  }
}
