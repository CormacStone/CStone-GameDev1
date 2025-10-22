class Rock {
  int x, y, diam, speed;
  PImage rock;

  Rock(int x, int y) {
    this.x=x;
    this.y=y;
    diam = int(random(60,90));
    speed = int(random(1, 6));
    rock = loadImage("rok.png");
  }
  void display() {
    imageMode(CENTER);
    rock.resize(diam, diam);
    image(rock, x, y);
  }
  void move() {
    y+=speed;
  }
  boolean reachedBottom() {
    if (y>height+100) {
      return true;
    } else {
      return false;
    }
  }
}
