//Cormac Stone || Aug 29 || Shape Game
import processing.sound.*;
SoundFile hit, win, hello;
ArrayList<Targets> target = new ArrayList<Targets>();
int x, y, health, tx, ty;
int w, h, tw, th, a, b;
int xspeed, yspeed;
int distance;
double time;
boolean l, r, u, d, got;
boolean lcol, rcol, ucol, dcol;
PImage pan, egg, title;
boolean won, lost, start, played, victory;
Timer panT;

//sets up stuff
void setup() {
  size(600, 400);
  textAlign(CENTER);
  fullScreen();
  background(255);
  panT = new Timer(400);
  panT.start();
  played = false;
  victory = false;
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
  health = 20;
  frameRate(60);
  title = loadImage("Title.png");
  egg = loadImage("Egg.png");
}

//runs stuff forever
void draw() {
  fill(255, 0, 0);
  background(255);
  time +=1;
  if (start) {
    startScreen();
  } else {
    scorePanel();
    player();
    if (time == 2000 /*&& t !=300*/) {
      panT = new Timer(200);
      println("200");
    } else if (time == 5000) {
      panT = new Timer(100);
      println("100");
    } else if (time == 9000) {
      panT = new Timer(45);
      println("45");
    } else if (time >= 20000) {
      panT = new Timer(0);
      victory = true;
      println(0);
    }
    if (panT.isFinished()) {
      target.add(new Targets(int(random(0, 4))));
      panT.start();
      println("eggs:" + target.size());
    }
    for (int i = 0; i < target.size(); i++) {
      Targets t = target.get(i);
      distance = int(dist(x, y, t.x, t.y));
      if (distance < t.w) {
        hit.play();
        if (hit.isPlaying()) {
          hit.stop();
          hit.play();
        }
        target.remove(t);
        health -= 1;
      }
      if (t.reachedEdge()) {
        target.remove(t);
        //health+=100;
      } else {
        t.display();
      }
      t.move();
    }
  }
  if (health >= 5000 || victory && time >= 30000) {
    won = true;
  }
  if (health <= 0) {
    lost = true;
  }

  if (won || lost) {
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
  text("Health Left: " + health, (width/2)-50, 40);
}

void player() {
  imageMode(CENTER);
  image(egg, x, y);
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
  title.resize(750,750);
  image(title, width/2-300, 40);
  textSize(25);
  text("Survive As Long As Possible", width/2, 450);
  textSize(15);
  text("by Cormac  Stone 2025", width/2, 475);
  textSize(50);
  text("click to play", width/2, 550);
}
void endScreen() {
  background(255);
  if (won) {
    win.play();
    textSize(200);
    text("You Win\n Yay", width/2, 200);
    textSize(20);
    text("no more game bruv,", width/2, 550);
  } else if (lost) {
    textSize(200);
    text("Game Over", width/2, 200);
    textSize(30);
    text("no more game bruv", width/2, 450);
    text("Total Time alive " + time/100 + " seconds", width/2, 600);
  }
}
