class Star {
  int x, y, diam, speed;
  PImage star;

  Star(int x, int y) {
    this.x=x;
    this.y=y;
    diam = int(random(10, 20));
    speed = int(random(1, 4));
    star = loadImage("str.png");
  }
  void display() {
    imageMode(CENTER);
    star.resize(diam, diam);
    image(star, x, y);
  }

  void move() {
    y+=speed;
  }
  boolean reachedBottom() {
    if (y>height+10) {
      return true;
    } else {
      return false;
    }
  }
}
