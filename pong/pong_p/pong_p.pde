import processing.serial.*;

//--------------------------------------------------------------------------------
Serial port;
String fromSerial;
String[] split;
long timer;

int data1 = 0;
int data2 = 0;
//--------------------------------------------------------------------------------
Ball ball;
Paddle p1;
Paddle p2;

boolean started = false;
int p1Score = 0;
int p2Score = 0;
boolean winner = false;
int maxScore = 5;
//--------------------------------------------------------------------------------

void setup() {
  size(900, 400);

  rectMode(CENTER);

  int posNeg = (random(0, 1) < 0.5 ? 1 : -1);
  ball = new Ball(new PVector(width/2, height/2), 
    new PVector(posNeg*random(2, 4), random(-5, 5)));

  p1 = new Paddle(new PVector(50, height/2), 1);
  p2 = new Paddle(new PVector(width-50, height/2), 2);
  timer = millis() - 3000;
}

void draw() {
  if(port == null){
    selectCom();
  }
  else{
    background(51);
    if (!winner) {
      readSerial();

      p1.update(data1);
      p2.update(data2);
      if (started) {
        ball.update();
        p1.checkBall(ball);
        p2.checkBall(ball);
  
        checkScore(ball);
      }
      ball.show();
      p1.show();
      p2.show();
      showScores();
    } else {
        p1.show();
        p2.show();
        showScores();
      String whoWon = (p1Score == maxScore) ? "Player 1 wins!":"Player 2 wins!";
      textSize(40);
      text(whoWon, width/2, height/2);
    }
  }
}

//--------------------------------------------------------------------------------

void keyReleased() {
  if (key == ' ')
    started = !started;

  if (keyCode == ENTER || keyCode == RETURN)
    restart();
}

//--------------------------------------------------------------------------------

void showScores() {
  fill(255);
  textSize(25);
  textAlign(CENTER, CENTER);
  //player 1
  text("Player 1:   "+p1Score, width/2-width/3, height/15);
  //player 2
  text("Player 2:   "+p2Score, width/2+width/3, height/15);
}

//--------------------------------------------------------------------------------

void restart() {
  int posNeg = (random(0, 1) < 0.5 ? 1 : -1);
  ball = new Ball(new PVector(width/2, height/2), 
    new PVector(posNeg*random(2, 4), random(-5, 5)));

  started = false;
  p1Score = 0;
  p2Score = 0;
  winner = false;
}

void reset() {
  int posNeg = (random(0, 1) < 0.5 ? 1 : -1);
  ball = new Ball(new PVector(width/2, height/2), 
    new PVector(posNeg*random(2, 4), random(-5, 5)));
  started = false;
}

//--------------------------------------------------------------------------------

void checkScore(Ball ball) {
  if (ball.pos.x > width) {
    p1Score++;
    reset();
  } else if (ball.pos.x < 0) {
    p2Score++;
    reset();
  }

  if (p1Score == maxScore || p2Score == maxScore)
    winner = true;
}

//--------------------------------------------------------------------------------
//reads information from the Serail port and grabs the data
void readSerial() {
  if (port.available() > 0) {
    fromSerial = port.readStringUntil('\n');
  } 

  if (fromSerial != null) {
    try{
      split = fromSerial.split(",");
      if (split.length == 2) {
        data1 = Integer.parseInt(split[0]);
        data2 = Integer.parseInt(split[1].substring(0, split[1].length()-1)); //dont want the \n
        println(data1+" "+data2);
      }
    }
    catch(Exception e){print(data1 + ", " + data2);}
  }
}