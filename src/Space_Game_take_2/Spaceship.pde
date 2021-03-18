class Spaceship {
  //member variables
  int x, y, health, lives, ammo, r;
  PImage pin;
  boolean right;
  

  //constructor
  Spaceship() {
    x = 0;
    y = 0;
    health = 500;
    lives = 5;
    ammo = 1000;
    pin = loadImage("hairpin.png");
    r = 25;
  }

  //display method
  void display(int x, int y) {
    this.x = x;
    this.y = y;
    imageMode(CENTER);
    image(pin, x, y, 60, 60);
  }

 // detect enemy laser collision
  boolean enemyLaserIntersect(EnemyLaser enemylaser) {
    // Calculate distance
    float distance = dist(x, y, enemylaser.x, enemylaser.y); 

    // Compare distance to sum of radii
    if (distance < r + enemylaser.r) { 
      return true;
    } else {
      return false;
    }
  }



  //detect rock collision
  boolean rockIntersection(Rock rock) {
    float distance = dist(x, y, rock.x, rock.y);
    if (distance < r + rock.r) {
      return true;
    } else {
      return false;
    }
  }

  //detect powerup intersect
    boolean puIntersect(PowerUp pu) {
    // Calculate distance
    float distance = dist(x, y, pu.x, pu.y); 

    // Compare distance to sum of radii
    if (distance < r + pu.r) { 
      return true;
    } else {
      return false;
    }
  }

// DETECT EMEMY SHIP COLLISION
  boolean shipIntersect(EnemyShip enemy) {
    // Calculate distance
    float distance = dist(x, y, enemy.x, enemy.y); 

    // Compare distance to sum of radii
    if (distance < r + enemy.r) { 
      return true;
    } else {
      return false;
    }
  }
}
