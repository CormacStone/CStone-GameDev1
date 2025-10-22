class Laser {
  int x, y, w, h, speed;
  PImage laser;
  Laser(int x, int y) {
    this.x=x;
    this.y=y;
    w=60;
    h= 10;
    speed = 12;
    laser = loadImage("laser.png");
    
  }
  void display() {
    imageMode(CENTER);
    laser.resize(w, w);
    image(laser, x+1, y);
  }

  void move() {
    y-=speed;
  }

  boolean reachedTop() {
    if (y<-100) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<=r.diam/2) {
      return true;
    } else {
      return false;
    }
  }
}
