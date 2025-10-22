// Cormac Stone || Nov 30 2023 || SpaceGame
import processing.sound.*;
SoundFile laser;
SpaceShip s1;
Star[] star;
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<PowUp> powups = new ArrayList<PowUp>();
ArrayList<Star> stars = new ArrayList<Star>();
int score, level;
boolean play;
Timer rockTimer;
Timer powupTimer;
Timer starTimer;

void setup() {
  s1 = new SpaceShip(width/2, height/2);
  laser = new SoundFile(this, "laser2.wav");
  play = false;
  rockTimer = new Timer(500);
  rockTimer.start();
  powupTimer = new Timer(5000);
  powupTimer.start();
  starTimer = new Timer(50);
  starTimer.start();
  score = 0;
  level = 1;
  size(800, 800);
  //fullScreen();
}

void draw() {
  background(22, 19, 35);
  if (play) {
    if (score==5000 && level!=2) {
      rockTimer = new Timer(300);
      level +=1;
    } else if (score==15000 && level!=3) {
      rockTimer = new Timer(200);
      level +=1;
    } else if (score==30000 && level!=4) {
      rockTimer = new Timer(100);
      level +=1;
    } else if (score==50000 && level!=5) {
      rockTimer = new Timer(0);
      level +=1;
    }
    //rocks
    if (rockTimer.isFinished()) {
      rocks.add(new Rock(int(random(width)), -100));
      rockTimer.start();
      println("lasers:" + lasers.size());
      println("rocks:" + rocks.size());
    }

    //rocks render
    for (int i = 0; i < rocks.size(); i++) {
      Rock r = rocks.get(i);
      if (s1.intersect(r)) {
        s1.health-=r.diam/10;
        rocks.remove(r);
      }
      if (r.reachedBottom()) {
        rocks.remove(r);
        score -=100;
      } else {
        r.display();
        r.move();
      }
    }

    //lasers render
    for (int i = 0; i < lasers.size(); i++) {
      if (s1.ammo>0) {
        Laser l = lasers.get(i);
        for (int j = 0; j<rocks.size(); j++) {
          Rock r = rocks.get(j);
          if (l.intersect(r)) {
            rocks.remove(r);
            lasers.remove(l);
            score+=100;
          }
        }
        if (l.reachedTop())
        {
          lasers.remove(l);
        } else {
          l.display();
          l.move();
        }
      }
    } //powerup render && make
    if (powupTimer.isFinished()) {
      powups.add(new PowUp(int(random(width)), -100));
      powupTimer.start();
      println("lasers:" + lasers.size());
      println("rocks:" + rocks.size());
    }
    for (int i = 0; i < powups.size(); i++) {
      PowUp p = powups.get(i);
      if (s1.intersect(p)) {
        if (p.type=='a') {
          s1.ammo+=p.val;
        } else if (p.type=='h') {
          s1.health+=p.val;
        } else if (p.type=='t') {
          if (s1.turretCount<5) {
            s1.turretCount+=p.val;
          } else {
            s1.ammo+=100;
          }
        }
        powups.remove(p);
      }
      if (p.reachedBottom()) {
        powups.remove(p);
      } else {
        p.display();
        p.move();
      }
    }
    if (starTimer.isFinished()) {
      stars.add(new Star(int(random(width)), -10));
      starTimer.start();
    }
    for (int i = 0; i < stars.size(); i++) {
      Star s = stars.get(i);
      if (s.reachedBottom()) {
        stars.remove(s);
      } else {
        s.display();
        s.move();
      }
    }

    //ship render
    s1.display(s1.x, s1.y);
    s1.move(mouseX, mouseY);
    infoPanel();
    if (s1.ammo<=0) {
      fill(255, 150);
      textSize(100);
      text("NO AMMO", width/2, height/2);
    }
    if (s1.health<1) {
      gameOver();
      noLoop();
    }
  } else {
    startScreen();
  }
}


void infoPanel() {
  if (s1.health > 0) {
    fill(127, 127);
    rectMode(CENTER);
    noStroke();
    rect(60, height-50, 125, 100);
    fill(255);
    textAlign(CENTER);
    textSize(20);
    text("score:" + score, 57, height-70);
    text("level:" + level, 57, height-50);
    text("health:" + s1.health, 57, height-30);
    text("ammo:" + s1.ammo, 57, height-10);
  }
}

void gameOver() {
  if (s1.health<=0) {
    background(0);
    fill(255);
    textSize(100);
    text("GAME OVER", width/2, height/2);
    text("Score:" + score, width/2, (height/2)+100);
    text("Level:" + level, width/2, (height/2)+200);
    noLoop();
  }
}

void startScreen() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(100);
  text("SPACE GAME", width/2, 200);
  textSize(50);
  text("by Cormac Stone", width/2, 275);
  text("click to begin", width/2, 350);
  if (mousePressed) {
    play = true;
  }
}

void mousePressed() {
  noCursor();
  if (s1.ammo!=0) {
    if (s1.turretCount == 1) {
      lasers.add(new Laser(s1.x, s1.y));
      laser.play();
      s1.ammo -= 1;
    } else  if (s1.turretCount == 2) {
      lasers.add(new Laser(s1.x-15, s1.y));
      lasers.add(new Laser(s1.x+15, s1.y));
      laser.play();
      s1.ammo -= 2;
    } else  if (s1.turretCount == 3) {
      lasers.add(new Laser(s1.x, s1.y));
      lasers.add(new Laser(s1.x+30, s1.y));
      lasers.add(new Laser(s1.x-30, s1.y));
      laser.play();
      s1.ammo -= 3;
    } else  if (s1.turretCount == 4) {
      lasers.add(new Laser(s1.x-15, s1.y));
      lasers.add(new Laser(s1.x+15, s1.y));
      lasers.add(new Laser(s1.x-45, s1.y));
      lasers.add(new Laser(s1.x+45, s1.y));
      laser.play();
      s1.ammo -= 4;
    } else  if (s1.turretCount == 5) {
      lasers.add(new Laser(s1.x, s1.y));
      lasers.add(new Laser(s1.x+30, s1.y));
      lasers.add(new Laser(s1.x-30, s1.y));
      lasers.add(new Laser(s1.x+60, s1.y));
      lasers.add(new Laser(s1.x-60, s1.y));
      laser.play();
      s1.ammo -= 5;
    }
  } else {
    fill(255, 150);
    textSize(100);
    text("NO AMMO", width/2, height/2);
  }
}
void keyPressed() {
  if (key==' ') {
    if (s1.ammo!=0&&s1.ammo>0) {
      if (s1.turretCount == 1) {
        lasers.add(new Laser(s1.x, s1.y));
        laser.play();
        s1.ammo -= 1;
      } else  if (s1.turretCount == 2) {
        lasers.add(new Laser(s1.x-15, s1.y));
        lasers.add(new Laser(s1.x+15, s1.y));
        laser.play();
        s1.ammo -= 2;
      } else  if (s1.turretCount == 3) {
        lasers.add(new Laser(s1.x, s1.y));
        lasers.add(new Laser(s1.x+30, s1.y));
        lasers.add(new Laser(s1.x-30, s1.y));
        laser.play();
        s1.ammo -= 3;
      } else  if (s1.turretCount == 4) {
        lasers.add(new Laser(s1.x-15, s1.y));
        lasers.add(new Laser(s1.x+15, s1.y));
        lasers.add(new Laser(s1.x-45, s1.y));
        lasers.add(new Laser(s1.x+45, s1.y));
        laser.play();
        s1.ammo -= 4;
      } else  if (s1.turretCount == 5) {
        lasers.add(new Laser(s1.x, s1.y));
        lasers.add(new Laser(s1.x+30, s1.y));
        lasers.add(new Laser(s1.x-30, s1.y));
        lasers.add(new Laser(s1.x+60, s1.y));
        lasers.add(new Laser(s1.x-60, s1.y));
        laser.play();
        s1.ammo -= 5;
      }
    }
  }
  if (keyCode ==116) {
    s1.ammo=1000;
    lasers.add(new Laser(s1.x, s1.y));
    lasers.add(new Laser(s1.x+30, s1.y));
    lasers.add(new Laser(s1.x-30, s1.y));
    lasers.add(new Laser(s1.x+60, s1.y));
    lasers.add(new Laser(s1.x-60, s1.y));
    lasers.add(new Laser(s1.x+90, s1.y));
    lasers.add(new Laser(s1.x-90, s1.y));
    lasers.add(new Laser(s1.x+120, s1.y));
    lasers.add(new Laser(s1.x-120, s1.y));
    lasers.add(new Laser(s1.x+150, s1.y));
    lasers.add(new Laser(s1.x-150, s1.y));
    lasers.add(new Laser(s1.x+180, s1.y));
    lasers.add(new Laser(s1.x-180, s1.y));
    lasers.add(new Laser(s1.x+210, s1.y));
    lasers.add(new Laser(s1.x-210, s1.y));
    laser.play();
  }
}
