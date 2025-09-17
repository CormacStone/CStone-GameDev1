class Targets {

  int x, y, w, xspeed, yspeed;
  PImage pan;

  Targets(int side) {
    if (side == 0 ) {
      x = -100;
      y = int(random(50, height-50));
      xspeed = int(random(10, 25));
      if (y <= height/2) {
        yspeed = int(random(2, 8));
      } else if (y > height/2) {
        yspeed = int(random(-8, -2));
      }
    } else if (side == 1) {
      y = -50;
      x = int(random(50, width-50));
      yspeed = int(random(1, 14));
      if (x > width/2) {
        xspeed = int(random(-10, -2));
      } else if (x < width/2) {
        xspeed = int(random(2, 10));
      }
    } else if (side == 2) {
      x = width + 50;
      y = int(random(50, height-50));
      xspeed = int(random(-25, -10));
      if (y >= height/2) {
        yspeed = int(random(2, 8));
      } else if (y < height/2) {
        yspeed = int(random(-8, -2));
      }
    } else if (side == 3) {
      y = height + 50;
      x = int(random(50, width-50));
      yspeed = int(random(-14,-1));
      if (x > width/2) {
        xspeed = int(random(-10, -2));
      } else if (x < width/2) {
        xspeed = int(random(2, 10));
      }
    }
    w = int(random(120, 150));
    pan = loadImage("FryingPan.png");
  }
  void display() {
    imageMode(CENTER);
    pan.resize(w, w);
    image(pan, x, y);
  }
  void move() {
    y+=yspeed;
    x+=xspeed;
  }
  boolean reachedEdge() {
    if (y > height+150 || y < -150 || x > width +150 || x < -150) {
      return true;
    } else {
      return false;
    }
  }
}
