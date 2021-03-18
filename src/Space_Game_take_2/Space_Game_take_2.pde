//Space Game
// by Joanna Bromka | December 2020

// TO DO LIST


// ADD GAME OVER MUSIC
// FIX SUPER WEAPON TEXT SHOWING UP ON EVERY LEVEL UP TICTEXT WHEN THERE ISNT A SUPER WEAPON

Spaceship ship;
Timer timer, rockTimer, enemyTimer, ticTimer, powerupTimer, bgmusicTimer;

ArrayList<Laser> lasers;
ArrayList<Rock> rocks;
ArrayList<Star> stars;
ArrayList<EnemyShip> enemyships;
ArrayList<PowerUp> pUps;
ArrayList<EnemyLaser> enemylasers;

int pass, rockRate, level, rockCount, laserCount, score, weaponCount, enemyHealth, superWeapon, x, y, FADE;

boolean play;
String ticText, ticText2;
boolean ticker; 

import ddf.minim.*;
Minim minim;
AudioPlayer bgmusic;

import processing.sound.*;
SoundFile file, game;

PImage intro, gameover;
PFont font;



void setup() {
  size(960, 540);
  rocks = new ArrayList();
  stars = new ArrayList();
  enemyships = new ArrayList();
  lasers = new ArrayList();
  enemylasers = new ArrayList();
  ship = new Spaceship();
  pUps = new ArrayList();

  rockRate = 1000;
  rockTimer = new Timer(rockRate);
  enemyTimer = new Timer(11000);
  powerupTimer = new Timer(10000);
  timer = new Timer(1000);
  timer.start();
  bgmusicTimer = new Timer(2000);

  pass = 0;
  level = 1;
  score =0;
  enemyHealth = 60;
  superWeapon = 0;

  rockCount = 0;
  laserCount = 0;
  weaponCount = 1;

  play = false;
  ticText = "";
  ticText2 = "";
  ticTimer = new Timer(5000);
  ticker = false;
  rockTimer.start();
  powerupTimer.start();

  minim = new Minim(this);
  bgmusic = minim.loadFile("bgmusic.mp3");

  file = new SoundFile(this, "intro sound.wav");
  file.play();
  game = new SoundFile(this, "game over.wav");


  intro = loadImage("intro.png");
  gameover = loadImage("gameover.png");
  font = loadFont("font1.vlw");
  textFont(font);
}





void draw() {
  // Gameplay
  if (!play) {
    startScreen();
  } else {
    background(20);
    file.pause();
    //LEVELS
    if (frameCount % 1000 == 10) {
      level++;
      if (superWeapon >= 1) {
        ticText = "Level:" + level;
        ticText2 = "Super Weapon is ready! Right click to use!";
      } else {
        ticText = "Level:" + level;
      }

      ticker();
      rockRate-=90;
      enemyHealth+=100;
      rockTimer.totalTime = rockRate;
    }


    //STARFIELD 
    stars.add(new Star(int(random(width)), 0));
    for (int i = 0; i < stars.size(); i++) {
      Star star = stars.get(i);
      star.display();
      star.move();
      if (star.reachedBottom()) {
        stars.remove(star);
      }
    }


    //if (bgmusicTimer.isFinished()) {
    //  //distribute rock
    bgmusic.play();
    //  bgmusicTimer.start();
    //}


    //ENEMY SHIP SPAWN
    if (enemyTimer.isFinished()) {
      //distribute rock
      enemyships.add(new EnemyShip(0, 80, int(random(500, 1500)), enemyHealth));
      enemyTimer.start();
    }

    for (int i = 0; i<enemyships.size(); i++) {
      EnemyShip enemyship = enemyships.get(i);
      enemyship.move();
      enemyship.display();

      //enemy and ship intersection
      if (ship.shipIntersect(enemyship)) {
        ship.health-=500;
        score+=enemyship.healthStart;
        enemyships.remove(enemyship);
      }
      if (enemyship.isFinished()) {
        enemylasers.add(new EnemyLaser(enemyship.x, enemyship.y));
        enemyship.start();
      }
    }


    //ENEMY LASER
    for (int i=enemylasers.size()-1; i>=0; i--) {
      EnemyLaser enemylaser = (EnemyLaser) enemylasers.get(i);
      enemylaser.fire();
      enemylaser.display();

      if (ship.enemyLaserIntersect(enemylaser)) {
        ship.health-=enemylaser.power;
        enemylasers.remove(enemylaser);
      }
      if (enemylaser.reachedBottom()) {
        enemylasers.remove(enemylaser);
      }
    }  



    //ROCK DISTRIBUTIONS
    if (timer.isFinished()) {
      //distribute rock
      rocks.add(new Rock(int(random(width)), -70 ));
      timer.start();
    }

    //ROCK RENDER
    for (int i = 0; i < rocks.size(); i++) {
      Rock rock = rocks.get(i);
      rock.display();
      rock.move();
      //collison
      if (ship.rockIntersection(rock)) {
        ship.health-=20;
        //if (rock.health<1) {
        //  score+=rock.healthStart;
        rocks.remove(rock);
        //}
      }

      //ROCK DISPOSAL
      if (rock.reachedBottom()) {
        rocks.remove(rock);
      }
    }

    //LASER RENDER
    for (int i = 0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      laser.display();
      laser.fire();
      //laser collision rock

      //ROCK AND LASER INTERSECTION
      for (int j = 0; j < rocks.size(); j++) {
        Rock rock = rocks.get(j);
        if (rock.laserIntersection(laser)) {
          rock.health-=30;
          lasers.remove(laser);
          if (rock.health<1) {
            rocks.remove(rock);
            score-=rock.health;
          }
        }
      }

      //ENEMYSHIP AND LASER INTERSECTION
      for (int k = 0; k<enemyships.size(); k++) {
        EnemyShip enemyship = enemyships.get(k);
        if (enemyship.laserIntersect(laser)) {
          lasers.remove(laser);
          enemyship.health-=20;
          if (enemyship.health<1) {
            score+=enemyship.healthStart;
            enemyships.remove(enemyship);
          }
        }
      }

      //LASER DISPOSAL
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
    }

    ship.display(mouseX, mouseY);
    infoPanel();

    //POWERUP AND SHIP INTERSECT
    if (powerupTimer.isFinished()) {
      pUps.add(new PowerUp(int(random(width)), -20));
      powerupTimer.start();
    }

    for (int i = 0; i<pUps.size(); i++) {
      PowerUp powerup= pUps.get(i);
      powerup.move();
      powerup.display();

      if (ship.puIntersect(powerup)) {
        if (powerup.pu == 0) { //adds ammo
          ship.health+=50;
          ship.ammo+=50;
        } else if (powerup.pu == 1) {
          ship.health+=50;
          ship.ammo+=50;
        } else if (powerup.pu == 2) {
          ship.health+=100;
          weaponCount++;
          superWeapon++;
          ship.ammo+=50;
        } else if (powerup.pu == 3) {
          ship.health+=100;
          ship.ammo+=100;
          superWeapon++;
          weaponCount++;
        }
        pUps.remove(powerup);
      }
    }

    if (ticker) {
      if (!ticTimer.isFinished()) {
        fill(255, 127);
        textSize(44);
        textAlign(CENTER);
        text(ticText, width/2, height/2);
        textSize(30);
        text(ticText2, width/2, height/1.7);
      } else if (!ticTimer.isFinished() && ship.health < 30) {
        fill(255, 127);
        textSize(44);
        textAlign(CENTER);
        text(ticText, width/2, height/2);
      }
    }

    infoPanel();

    //decreasing lives
    // GameOver Logic
    if (ship.health < 1|| pass>100) {
      play = false;
      gameOver();
    }
  }
}

//EDITING HERE



void mousePressed() {
  if (mouseButton == RIGHT && superWeapon >= 1) {
    superWeapon--;
    pass = 0;
    weaponCount =1;
    rockRate = 1000;
    rockTimer.totalTime = rockRate;
    enemyHealth = 100;
    for (int i = 0; i<rocks.size(); i++) {
      Rock rock = rocks.get(i);
      score+=rock.healthStart;
      rocks.remove(rock);
      rockCount++;
    }
    rocks.removeAll(rocks);
    rockTimer.start();
    for (int i = 0; i<enemyships.size(); i++) {
      EnemyShip enemyship = enemyships.get(i);
      score+=enemyship.healthStart;
      enemyships.remove(enemyship);
      //enemyship.start();
    }
    enemyships.removeAll(enemyships);
  }

  if (ship.ammo > 0) {
    if (weaponCount == 1) {
      lasers.add(new Laser(ship.x, ship.y));
      laserCount++;
      ship.ammo--;
    } else if (weaponCount == 2) {
      lasers.add(new Laser(ship.x-20, ship.y));
      lasers.add(new Laser(ship.x+20, ship.y));
      laserCount++;
      ship.ammo-=2;
    } else if (weaponCount == 3) {
      lasers.add(new Laser(ship.x-20, ship.y));
      lasers.add(new Laser(ship.x+20, ship.y));
      laserCount++;
      ship.ammo-=3;
    } else if (weaponCount == 4) {
      lasers.add(new Laser(ship.x-20, ship.y));
      lasers.add(new Laser(ship.x+20, ship.y));
      laserCount++;
      ship.ammo-=4;
    } else if (weaponCount == 5) {
      lasers.add(new Laser(ship.x-20, ship.y));
      lasers.add(new Laser(ship.x+20, ship.y));
      lasers.add(new Laser(ship.x-40, ship.y));
      lasers.add(new Laser(ship.x+40, ship.y));
      laserCount++;
      ship.ammo-=5;
    } else if (weaponCount == 6) {
      lasers.add(new Laser(ship.x-20, ship.y));
      lasers.add(new Laser(ship.x+20, ship.y));
      lasers.add(new Laser(ship.x-40, ship.y));
      lasers.add(new Laser(ship.x+40, ship.y));
      laserCount++;
      ship.ammo-=6;
    } else if (weaponCount == 7) {
      lasers.add(new Laser(ship.x-20, ship.y));
      lasers.add(new Laser(ship.x+20, ship.y));
      lasers.add(new Laser(ship.x-40, ship.y));
      lasers.add(new Laser(ship.x+40, ship.y));
      laserCount++;
      ship.ammo-=10;
    }
  }
}


void BgMusicLoop() {
  if (bgmusicTimer.isFinished()) {
    //distribute rock
    bgmusic.play();
  }
}


void ticker() {
  ticTimer.start();
  ticker = true;
  if (ticTimer.isFinished()) {
    ticker = false;
  }
  // Show Level Up

  // Show Low Health Warning

  // Show Rock Pass Warning
}






void startScreen() {
  image(intro, x, y);

  if (mousePressed) {
    play = true;
  }
}




void infoPanel() {
  //bg rect
  fill(#6E98CE, 128);
  rectMode(CORNER);
  rect(0, 0, width, 40);

  //text
  fill(255, 200);
  textSize(25);
  textAlign(CORNER);
  text("HP:" + ship.health, 25, 25);
  text("AMMO:" + ship.ammo, 180, 25);
  // text("lives:" + ship.lives, 55, 70);
  text("SCORE:" + score, 375, 25);
}

void gameOver() {
  game.play();
  image(gameover, x+480, y+270);
  bgmusic.shiftGain(bgmusic.getGain(), -80, FADE);
  fill(230);
  textSize(30);
  textAlign(CENTER);
  text("FINAL SCORE: " + score, width/2, height/2+140);
  text("REACHED LEVEL: " + level, width/2, height/2+190);
  noLoop();
}
