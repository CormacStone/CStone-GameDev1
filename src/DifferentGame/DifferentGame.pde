//Cormac Stone
boolean l, r, u, d,lcol,rcol,ucol,dcol;
int x,y;
int nFloor;
Player player;
Map map;
void setup() {
  nFloor = 40;
  size(600, 600);
  x = 100;
  y = 100;
}

void draw() {
  background(255);
  noStroke();
  rectMode(CORNER);
  map = new Map();
  map.drawMap();
  player = new Player(x,y);
  movement();
  //println(mouseX + " " + mouseY);
  frameRate(60);
}
void movement() {
  if (!lcol) {
    if (l) {
      x-=player.xspeed;
    }
  }
  if (!rcol) {
    if (r) {
      x+=player.xspeed;
    }
  }
  if (!ucol) {
    if (u) {
      y-=player.yspeed;
    }
  }
  if (!dcol) {
    if (d) {
      y+=player.yspeed;
    }
  }
  //colision checks
  if (x<=player.w/2) {
    lcol= true;
    x=player.w/2;
  } else {
    lcol = false;
  }
  if (x>=width-player.w/2) {
    rcol = true;
    x = width-player.w/2;
  } else {
    rcol = false;
  }
  if (y<=(player.h/2)) {
    ucol = true;
    y = (player.h/2);
  } else {
    ucol = false;
  }
  if (nFloor <= player.h) {
    dcol = true;
  } else {
    dcol = false;
  }
  nFloor = 500-y;
}
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
}
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
