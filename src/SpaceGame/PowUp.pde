class PowUp {
  int x, y, diam, speed, val;
  PImage powup;
  char type;

  PowUp(int x, int y) {
    this.x=x;
    this.y=y;
    diam = 70;
    speed = 2;
    int rand = int(random(7));
    if (rand==0||rand==4||rand==5||rand==6) {
      powup = loadImage("ammo.png");
      val = 100;
      type = 'a';
    } else if (rand==1) {
      powup = loadImage("health.png");
      val = 10;
      type = 'h';
    } else if (rand==2||rand==3) {
      powup = loadImage("turret.png");
      val = 1;
      type = 't';
    }
  }
  void display() {
    imageMode(CENTER);
    powup.resize(diam, diam);
    image(powup, x, y);
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
