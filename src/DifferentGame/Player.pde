class Player {
  int x, y, health, yspeed, xspeed, w, h;

  Player(int x, int y) {
    this.x=x;
    this.y=y;
    xspeed= 10;
    w = 10;
    h = 20;
    yspeed= 10;
    fill(100);
    rectMode(CENTER);
    rect(x, y, w, h);
  }
}
