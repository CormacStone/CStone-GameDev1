class SpaceShip {
  int x, y, w, health, ammo, turretCount;
  PImage ship;

  SpaceShip(int x, int y) {
    this.x=x;
    this.y=y;
    w=80;
    health = 100;
    ammo = 1000;
    turretCount = 1;
    ship = loadImage("ship.png");
  }
  void display(int x, int y) {
    if (health>0) {
      imageMode(CENTER);
      ship.resize(w, w);
      image(ship, x, y);
    }
  }
  void move(int x, int y) {
    this.x=x;
    this.y=y;
  }

  boolean fire() {
    if (ammo > 0) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<=r.diam/1.5) {
      return true;
    } else {
      return false;
    }
  } boolean intersect(PowUp p) {
    float d = dist(x, y, p.x, p.y);
    if (d<=p.diam/1.5) {
      return true;
    } else {
      return false;
    }
  }
}
