//Cormac Stone || Aug 29 || Shape Game
int x, y, score, tx, ty;
int w, h, tw, th, a, b;
int xspeed, yspeed;
int time;
boolean l, r, u, d, got;
boolean lcol, rcol, ucol, dcol;
PImage pan, egg;
//sets up stuff
void setup() {
  //size(600, 400);
  fullScreen();
  background(255);
  lcol = false;
  rcol = false;
  ucol= false;
  dcol= false;
  x = 100;
  y = 100;
  w = 100;
  tw = 50;
  h = 100;
  th = 50;
  xspeed = 20;
  yspeed = 20;
  score = 0;
  //frameRate(60);
  pan = loadImage("FryingPan.png");
  egg = loadImage("Egg.png");
}

//runs stuff forever
void draw() {
  fill(255, 0, 0);
  background(255);
  scorePanel();
  target();
  noStroke();
  fill(0, 0, 255);
  //ellipse(x, y, w, h);
  imageMode(CENTER);
  image(pan, x, y);
  movement();
  fill(0);
  text("yspeed " + yspeed, 200, 250);
  text("xspeed " + xspeed, 200, 200);
  time -= 1;
  text("time left " + time, 200, 300);
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
  textMode(CENTER);
  text("Score: " + score, (width/2)-20, 40);
}

void target() {
  fill(255, 0, 0);
  rectMode(CENTER);
  float distance = dist(x, y, tx, ty);
  text(distance, 200, 150);

  if (time == 0 || distance <= 120 && !got) {
    a = int(random(50, width-50));
    b = int(random(50, height-50));
    score += 100+time;
    if (time == 0){
      score -= 100;
    }
    time = 200;
    got = true;
  } else {
    tx = a;
    ty = b;
    got = false;
  }
  fill(255, 0, 0);
  rect(tx, ty, tw, th);
  imageMode(CENTER);
  image(egg, tx, ty);
}
void movement() {
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
