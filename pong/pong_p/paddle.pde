class Paddle {
  PVector pos;
  int w = 25;
  int h = 100;

  int player;

  Paddle(PVector pos, int player) {
    this.pos = pos;
    this.player = player;
  }

  void show() {
    fill(255);
    noStroke();
    rect(this.pos.x, this.pos.y, this.w, this.h);
  }

  void update(int update) {
    //update data is raw data from arduino 0 - 1023
    if (this.player == 1) {
      //top = 1023 bottom = 0
      this.pos.y = map(update, 1023, 0, this.h/2, height-this.h/2);
    } else if (this.player == 2) {
      //top = 0    bottom = 1023
      this.pos.y = map(update, 0, 1023, this.h/2, height-this.h/2);
    }

    checkBoundaries();
  }

  private void checkBoundaries() {
    if (this.pos.y+this.h/2 > height) 
      this.pos.y = height-this.h/2;
    else if (this.pos.y-this.h/2 < 0)
      this.pos.y = this.h/2;
  }

  void checkBall(Ball ball) {
    //check horizontal collisions (corners are ok)
    if (this.player == 1) {
      if (ball.pos.y+ball.size/4 > this.pos.y-h/2 
        && ball.pos.y-ball.size/4 < this.pos.y+h/2 
        && ball.pos.x-ball.size/2 < this.pos.x+this.w/2 
        && ball.pos.x-ball.size/4 > this.pos.x+this.w/2) {
        ball.vel.x *= -1;
        //updating ball speed
        ball.vel.x += ball.velIncrease;
        //updating the y velocity based on distance from the center of the paddle.
        ball.vel.y = map(ball.pos.y, this.pos.y-this.h/2, this.pos.y+this.h/2, -5, 5);
      }
    } else if (this.player == 2) {
      if (ball.pos.y+ball.size/4 > this.pos.y-h/2 
        && ball.pos.y-ball.size/4 < this.pos.y+h/2
        && ball.pos.x+ball.size/2 > this.pos.x-this.w/2
        && ball.pos.x+ball.size/4 < this.pos.x-this.w/2) {
        ball.vel.x *= -1;
        //updating ball speed
        ball.vel.x -= ball.velIncrease;
        //updating the y velocity based on distance from the center of the paddle.
        ball.vel.y = map(ball.pos.y, this.pos.y-this.h/2, this.pos.y+this.h/2, -5, 5);
      }
    }

    //check vertical collisions
    //top side
    if (ball.pos.x < this.pos.x+this.w/2
      && ball.pos.x > this.pos.x-this.w/2
      && ball.pos.y < this.pos.y
      && ball.pos.y+ball.size/2 > this.pos.y-this.h/2) {
      ball.pos.y = this.pos.y-this.h/2-ball.size/2;
      ball.vel.y = (ball.vel.y < 0) ? ball.vel.y : -ball.vel.y;
    } 
    //bottom side
    else if (ball.pos.x < this.pos.x+this.w/2
      && ball.pos.x > this.pos.x-this.w/2
      && ball.pos.y-ball.size/2 < this.pos.y+this.h/2
      && ball.pos.y > this.pos.y) {
      ball.pos.y = this.pos.y+this.h/2+ball.size/2;
      ball.vel.y = (ball.vel.y > 0) ? ball.vel.y : -ball.vel.y;
    }
  }
}
