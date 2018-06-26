class Ball {
  PVector pos, vel;
  int size = 20;

  float velIncrease = 1;
  int maxX = 7;

  Ball(PVector pos, PVector vel) {
    this.pos = pos;
    this.vel = vel;
  }

  void show() {
    fill(255, 0, 0);
    noStroke();
    ellipse(this.pos.x, this.pos.y, this.size, this.size);
  }

  void update() {
    this.vel.x = constrain(this.vel.x, -this.maxX, this.maxX);
    this.pos.add(this.vel);
    this.checkBoundaries();
  }

  private void checkBoundaries() {
    if (this.pos.y+this.size/2 > height) {
      this.pos.y = height-this.size/2;
      this.vel.y *= -1;
    } else if (this.pos.y-this.size/2 < 0) {
      this.pos.y = this.size/2;
      this.vel.y *= -1;
    }
  }
}
