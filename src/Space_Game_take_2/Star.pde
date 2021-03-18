class Star {
  //member variables
  int x, y, speed, dia;
  color c;
  
  //constructor
  Star(int x, int y) {
    this.x = x;
    this.y = y;
    c = color(255);
    speed = int(random(1, 2));
    dia = int(random(1, 3));
  }

  //display method
  void display() {
    rectMode(CENTER);
    noStroke();
    fill(c);
    rect(x, y, dia, dia);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y>height+10) {
      return true;
    } else {
      return false;
    }
  }
}
