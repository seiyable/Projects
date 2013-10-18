//Brick Game!! ver 1.1

// ===================== global variables =====================

//ball's coordinate, size, and speed
float ballX;
float ballY;
float pBallX; //previous position
float pBallY; //previous position
int ballSize = 20;
float speedX = 5;
float speedY = 5;
int ballColorH = 48;
int ballColorS = 255;
int ballColorB = 255;

//paddle's coordinate
int paddleCenterX;
int paddleCenterY;
int pPaddleCenterX; //previous position
int paddleSpeed; // (pPaddleCenterX - paddleCenterX)
int paddleWidth = 150;
int paddleHeight = 30;
int paddleColorH = 128;
int paddleColorS = 255;
int paddleColorB = 255;

//number of row and column
int columnN = 6;
int rowN = 4;

//space btw blocks and window
int paddingX = 50;
int paddingY = 50;

//space btw blocks
int blockSpaceX = 15;
int blockSpaceY = 15;
int blockWidth = 100;
int blockHeight = 30;

//blocks' status
int[][] blockStatus;

//score
int score = 0;

//time
float time = 0;
int timeup = 50; //seconds

//flag for clear/gameover
int cleared = 0;
int gameover = 0;


// ===================== setup() =====================

void setup() {
  //set window size
  //window width and height are determined by
  //paddingX, paddingY, blockSpaceX, blockSpaceY, blockWidth, blockHeight, columnN, and rowN
  size(paddingX*2 + blockSpaceX*(columnN - 1) + blockWidth*columnN, paddingY*2 + (blockSpaceY*(rowN - 1) + blockHeight*rowN)*4);
  colorMode(HSB, 255);
  frameRate(60);

  //make an array for drawing blocks
  blockStatus = new int[columnN][rowN];
  for (int i = 0; i < rowN; i++) {
    for (int j = 0; j < columnN; j++) {
      blockStatus[j][i] = 1;
    }
  }

  //paddleCenterY is determined by window's height, paddingY
  paddleCenterY = height - paddingY*2;

  //the begining position of the ball is determined randomly.
  ballX = int(random(width));
  ballY = paddingY + blockSpaceY*(rowN - 1) + blockHeight*rowN;

  //the begining speed of the ball is determined randomly.
  speedX = speedX*(int(random(2))*2-1);
}

// ===================== draw() =====================

void draw() {
  background(0);
  drawBlocks();
  drawAPaddle();
  drawAndRunABall();
  makeTheBallBoundByTheWalls();
  makeTheBallBoundByThePaddle();
  makeTheBallBoundByTheBlocks();
  displayScore();
  displayTimeBar();
  displayClear();
  displayGameOver();
  storeSomeValuesAsThePrevious();
}

// ===================== keyPressed() =====================

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (speedX < 0) {
        speedX -= 1;
      } 
      else {
        speedX += 1;
      }
      if (speedY < 0) {
        speedY -= 1;
      } 
      else {
        speedY += 1;
      }
    }
    else if (keyCode == DOWN) {
      if (speedX < 0) {
        speedX += 1;
      } 
      else {
        speedX -= 1;
      }
      if (speedY < 0) {
        speedY += 1;
      } 
      else {
        speedY -= 1;
      }
    }
  } 
  else if (key == 'c') {
    cleared = 1;
  }
}

// ===================== drawBlocks() =====================

void drawBlocks() {
  rectMode(CORNER);
  for (int i = 0; i < rowN; i++) {
    for (int j = 0; j < columnN; j++) {
      if (blockStatus[j][i] == 1) {
        fill((i+1)*(255/(rowN+1)), (j+1)*(255/(columnN+1)), 255);
        rect(paddingX + blockSpaceX*j + blockWidth*j, paddingY + blockSpaceY*i + blockHeight*i, blockWidth, blockHeight);
      }
    }
  }
}

// ===================== drawAPaddle() =====================

void drawAPaddle() {
  fill(paddleColorH, paddleColorS, paddleColorB);
  rectMode(CENTER);
  paddleCenterX = mouseX;
  rect(paddleCenterX, paddleCenterY, paddleWidth, paddleHeight);
}

// ===================== drawAndRunABall() =====================

void drawAndRunABall() {
  fill(ballColorH, ballColorS, ballColorB);
  ellipse(ballX, ballY, ballSize, ballSize);
  ballX += speedX;
  ballY += speedY;
}

// ===================== makeTheBallBoundByTheWalls() =====================

void makeTheBallBoundByTheWalls() {
  if (ballX < 0 || ballX > width) {
    speedX = - speedX; //change the direction of X
  }
  if (ballY < 0) {
    speedY = - speedY; //change the direction of Y
  }
}

// ===================== makeTheBallBoundByThePaddle() =====================

void makeTheBallBoundByThePaddle() {
  //calculate the friction btw the ball and the paddle based on paddleSpeed
  paddleSpeed = pPaddleCenterX - paddleCenterX;
  //and constrain it from -50 to 50
  if (paddleSpeed > 50) {
    paddleSpeed = 50;
  } 
  else if (paddleSpeed < -50) {
    paddleSpeed = -50;
  }
  float angleChangedByFriction = map(paddleSpeed, -50, 50, -PI/2, PI/2);
  float slope = (ballX - pBallX) / (ballY - pBallY);
  float dist = dist(pBallX, pBallY, ballX, ballY);
  float currentAngle = atan(slope);

  //set the amount of angle change baced on where the ball hit on the paddle
  float angleChangedByContactPoint = 0;
  int contactPoint = 0;

  //make the ball bound on the paddle
  if (((ballX > paddleCenterX - paddleWidth/2) && (ballX < paddleCenterX + paddleWidth/2)) 
    && ((ballY > paddleCenterY - paddleHeight/2) && (ballY < paddleCenterY + paddleHeight/2))) {
    if ((pBallX < paddleCenterX - paddleWidth/2) || (pBallX > paddleCenterX + paddleWidth/2)) {
      //when the ball hit the vertical face of the paddle
      speedX = - speedX; //change the direction of X
    } 
    else {
      //when the ball hit the horizontal face of the paddle
      if (((ballX > paddleCenterX - paddleWidth/2) && (ballX < paddleCenterX - paddleWidth/2 + paddleWidth*1/10))) {
        contactPoint = '1'; //left edge
      } 
      else if (((ballX > paddleCenterX - paddleWidth/2 + paddleWidth/10) && (ballX < paddleCenterX - paddleWidth/2 + paddleWidth*4/10))) {
        contactPoint = '2'; //left midspan
      } 
      else if (((ballX > paddleCenterX - paddleWidth/2 + paddleWidth*4/10) && (ballX < paddleCenterX - paddleWidth/2 + paddleWidth*6/10))) {
        contactPoint = '3'; //center
      } 
      else if (((ballX > paddleCenterX - paddleWidth/2 + paddleWidth*6/10) && (ballX < paddleCenterX - paddleWidth/2 + paddleWidth*9/10))) {
        contactPoint = '4'; //right midspan
      } 
      else if (((ballX > paddleCenterX - paddleWidth/2 + paddleWidth*9/10) && (ballX < paddleCenterX - paddleWidth/2 + paddleWidth*10/10))) {
        contactPoint = '5'; //right edge
      }
      switch(contactPoint) {
      case '1': //left edge
        angleChangedByContactPoint = PI/4;
        break;
      case '2': //left midspan
        angleChangedByContactPoint = PI/6;
        break;
      case '3': //center
        angleChangedByContactPoint = 0;
        break;
      case '4': //right midspan
        angleChangedByContactPoint = -PI/6;
        break;
      case '5': //right edge
        angleChangedByContactPoint = -PI/4;
        break;
      }
      if (speedX < 0) speedX = -speedX;
      speedX = tan(currentAngle + angleChangedByFriction - angleChangedByContactPoint)*speedY; //the angle will change based on the friction and the contact point btw the ball and paddle
      speedY = - speedY; //change the direction of Y
      if (speedX > 10) {
        speedX = 10;
      } 
      else if (speedX < -10) {
        speedX = -10;
      }
    }
  }
}

// ===================== makeTheBallBoundByTheBlocks() =====================

void makeTheBallBoundByTheBlocks() {
  for (int i = 0; i < rowN; i++) {
    for (int j = 0; j < columnN; j++) {
      if (blockStatus[j][i] == 1) {
        if (((ballX > paddingX + blockSpaceX*j + blockWidth*j) && (ballX < paddingX + blockSpaceX*j + blockWidth*(j+1))) 
          && ((ballY > paddingY + blockSpaceY*i + blockHeight*i) && (ballY < paddingY + blockSpaceY*i + blockHeight*(i+1)))) {
          if ((pBallX < paddingX + blockSpaceX*j + blockWidth*j) || (pBallX > paddingX + blockSpaceX*j + blockWidth*(j+1))) {
            //when the ball hit the vertical face of the blocks
            speedX = - speedX;  //change the direction of X
            blockStatus[j][i] = 0;  //make the block dissappear
            score += 10;
          } 
          else {
            //when the ball hit the horizontal face of the blocks
            speedY = - speedY;  //change the direction of Y
            blockStatus[j][i] = 0;  //make the block dissappear
            score += 10;
          }
        }
      }
    }
  }
}

// ===================== displayScore() =====================

void displayScore() {
  if (ballY < height) {
    noStroke();
    fill(128, 255, 255, 200);
    textAlign(LEFT, TOP);
    textSize(25);
    text("SCORE: " + score, 10, 10);
  }
}

// ===================== displayTimeBar() =====================

void displayTimeBar() {
  float t = map(time/round(frameRate), 0, timeup, 0, width);

  //if time is up, then game will over
  if (t > width) {
    gameover = 1;
  } 
  
  //the time bar only dipicted when the game is not cleared / failed
  if ((cleared == 0)&&(gameover == 0)) {
    noStroke();
    rectMode(CORNER);
    fill(128, 255, 255, 100);
    rect(0, height - paddingY, width - t, 10);
    time += 1;
  }
}


// ===================== displayClear() =====================

void displayClear() {
  //check the number of blocks which still exsist
  int sum = 0;
  for (int i = 0; i < rowN; i++) {
    for (int j = 0; j < columnN; j++) {
      sum = sum + blockStatus[j][i];
    }
  }
  if (sum == 0) {
    cleared = 1;
  }

  //display clear screen
  if (cleared == 1) {
    speedX = 0;
    speedY = 0;

    fill(128, 255, 255, 100); //cover
    rect(0, 0, width*2, height*2);
    fill(128, 255, 255);
    noStroke();
    textAlign(CENTER);
    textSize(50);
    text("CLEAR!", width/2, height/2);
    textSize(30);
    text("SCORE: " + score, width/2, height/2 + 40);
    text("TIME REMAINED: " + (timeup - int(time/frameRate)), width/2, height/2 + 80);

    //draw a button
    rectMode(CENTER);
    fill(96, 255, 255);
    rect(width/2, height/2 + 120, 150, 50);
    fill(0, 0, 0);
    textSize(40);
    text("Retry!", width/2, height/2 + 135);

    if ((mousePressed == true) 
      && ((mouseX > width/2 - 75) && (mouseX < width/2 +75)) && ((mouseY > height/2 + 120 - 25) && (mouseY < height/2 + 120 + 25))) {
      cleared = 0;
      score = 0;
      time = 0;

      //the begining position of the ball is determined randomly.
      ballX = int(random(width));
      ballY = paddingY + blockSpaceY*(rowN - 1) + blockHeight*rowN;

      speedX = 5;
      speedY = 5;

      //the begining speed of the ball is determined randomly.
      speedX = speedX*(int(random(2))*2-1);

      //reset the blocks
      for (int i = 0; i < rowN; i++) {
        for (int j = 0; j < columnN; j++) {
          blockStatus[j][i] = 1;
        }
      }
    }
  }
}

// ===================== displayGameOver() =====================

void displayGameOver() {
  if (ballY > height) {
    gameover = 1;
  }

  //display gameover screen
  if (gameover == 1) {
    speedX = 0;
    speedY = 0;
    
    fill(255, 255, 255, 100); //cover
    rect(0, 0, width*2, height*2);
    fill(255, 255, 255);
    noStroke();
    textAlign(CENTER);
    textSize(50);
    text("GAMEOVER", width/2, height/2);
    textSize(30);
    text("SCORE: " + score, width/2, height/2 + 40);

    //draw a button
    rectMode(CENTER);
    fill(96, 255, 255);
    rect(width/2, height/2 + 80, 150, 50);
    fill(0, 0, 0);
    textSize(40);
    text("Retry!", width/2, height/2 + 95);

    if ((mousePressed == true)
      && ((mouseX > width/2 - 75) && (mouseX < width/2 +75)) && ((mouseY > height/2 + 80 - 25) && (mouseY < height/2 + 80 + 25))) {
      gameover = 0;
      score = 0;
      time = 0;

      //the begining position of the ball is determined randomly.
      ballX = int(random(width));
      ballY = paddingY + blockSpaceY*(rowN - 1) + blockHeight*rowN;

      speedX = 5;
      speedY = 5;         

      //the begining speed of the ball is determined randomly.
      speedX = speedX*(int(random(2))*2-1);

      //reset the blocks
      for (int i = 0; i < rowN; i++) {
        for (int j = 0; j < columnN; j++) {
          blockStatus[j][i] = 1;
        }
      }
    }
  }
}

// ===================== storeSomeValuesAsThePrevious() =====================

void storeSomeValuesAsThePrevious() {
  //store paddle's values as the previous
  pPaddleCenterX = paddleCenterX;

  //store ball's values as the previous
  pBallX = ballX;
  pBallY = ballY;
}

