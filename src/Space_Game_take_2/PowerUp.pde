class PowerUp {
  int x, y, speed, r, pu; 
  String[] puInfo = {"Ammo", "Health", "Lasers", "Super"};
  PImage monomi;
  PImage usami;

  PowerUp(int x, int y) {
    r = 80; 
    this.x = x;
    this.y = y;
    speed = int(random(2, 5));
    pu = int(random(4));
    monomi = loadImage("monomi.png");
    usami = loadImage("usami.png");
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y > height + r*4) { 
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    switch(pu) {
    case 0: // Ammo
      image(monomi, x, y, 40, 40);
      break;
    case 1: // Health
      image(monomi, x, y, 40, 40);
      break;
    case 2: // Lasers
      image(usami, x, y, 40, 40);
      break;
    case 3: // Super Weapon
      image(usami, x, y, 40, 40);
      break;
    }
  }
}
