//Cormac Stone || Aug 29 || Shape Game
import processing.sound.*;
SoundFile hit, win, hello;
int x, y, score, tx, ty;
int w, h, tw, th, a, b;
int xspeed, yspeed;
int time;
boolean l, r, u, d, got;
boolean lcol, rcol, ucol, dcol;
PImage pan, egg;
boolean won, start, played;

//sets up stuff
void setup() {
  size(600, 400);
  textAllign(CENTER);
  //fullScreen();
  background(255);
  played = false;
  won = false;
  win = new SoundFile(this, "yay.wav");
  hit = new SoundFile(this, "LegoYodaDeath sound.wav");
  hello = new SoundFile(this, "Hello.wav");
  lcol = false;
  rcol = false;
  ucol= false;
  dcol= false;
  start = true;
  x = 500;
  y = 500;
  w = 100;
  tw = 50;
  h = 100;
  th = 50;
  xspeed = 20;
  yspeed = 20;
  score = 0;
  frameRate(100);
  pan = loadImage("FryingPan.png");
  egg = loadImage("Egg.png");
}

//runs stuff forever
void draw() {
  fill(255, 0, 0);
  background(255);
  if (start) {
    startScreen();
  } else {
    scorePanel();
    target();
    player();
    time -= 1;
    if (Score >= 10000) {
      won = true;
    }
  }
  if (won) {
    endScreen();
    noLoop();
  }
}

//keypresses
void keyPressed() {
  if (keyCode == 37 || key == 'a' || key == 'A') {
    l = true;
  }
  if (keyCode == 39 || key == 'd' || key == 'D') {
    r = true;
  }
  if (keyCode == 38 || key == 'w' || key == 'W') {
    u = true;
  }
  if (keyCode == 40 || key == 's' || key == 'S') {
    d = true;
  }
  if (key == '1') {
    xspeed += 1;
  }
  if (key == '2') {
    yspeed += 1;
  }
  if (key == '3') {
    xspeed -=1;
  }
  if (key == '4') {
    yspeed -=1;
  }
}
//also keypresses just making them smoother
void keyReleased() {
  if (keyCode == 37 || key == 'a' || key == 'A') {
    l = false;
  }
  if (keyCode == 39 || key == 'd' || key == 'D') {
    r = false;
  }
  if (keyCode == 38 || key == 'w' || key == 'W') {
    u = false;
  }
  if (keyCode == 40 || key == 's' || key == 'S') {
    d = false;
  }
}
void scorePanel() {
  fill(127, 127);
  rectMode(LEFT);
  rect(0, 0, width, 50);
  fill(0);
  textSize(50);
  text("Score: " + score, (width/2)-50, 40);
}

void target() {
  float distance = dist(x, y, tx, ty);
  if (time == 0 || distance <= 120 && !got) {
    a = int(random(50, width-50));
    b = int(random(50, height-50));
    score += 100+time;
    hit.play();
    if (hit.isPlaying()) {
      hit.stop();
      hit.play();
    }
    if (time == 0) {
      score -= 200;
    }
    time = 200;
    got = true;
  } else {
    tx = a;
    ty = b;
    got = false;
  }
  imageMode(CENTER);
  image(egg, tx, ty);
}
void player() {
  imageMode(CENTER);
  image(pan, x, y);
  if (!lcol) {
    if (l) {
      x-=xspeed;
    }
  }
  if (!rcol) {
    if (r) {
      x+=xspeed;
    }
  }
  if (!ucol) {
    if (u) {
      y-=yspeed;
    }
  }
  if (!dcol) {
    if (d) {
      y+=yspeed;
    }
  }
  //colision checks
  if (x<=w/2) {
    lcol= true;
    x=w/2;
  } else {
    lcol = false;
  }
  if (x>=width-w/2) {
    rcol = true;
    x = width-w/2;
  } else {
    rcol = false;
  }
  if (y<=(h/2)+35) {
    ucol = true;
    y = (h/2)+35;
  } else {
    ucol = false;
  }
  if (y>=height-h/2) {
    dcol = true;
    y = height-h/2;
  } else {
    dcol = false;
  }
}
void mousePressed() {
  start = false;
}
void startScreen() {

  if (!played) {
    hello.play();
    played = true;
  }
  fill(0);
  textSize(150);
  text("Hello", width/2-(2*w)+25, 200);
  textSize(25);
  text("click to play", width/2-w, 350);
}
void endScreen() {
  win.play();
  textSize(200);
  text("You Win/n Yay", 200,200);
  textSize(20);
  text("no more game bruv,"500,500);
}
