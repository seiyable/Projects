// =========================== how to play ===========================
//press ↑, →, ↓, ←: change direction of light
//press +, -: change speed of light
//click mouse on circles: draw a ripple

// =========================== global variables ===========================
int rowN = 14, columnN = 20;
LED[][] leds = new LED[columnN][rowN];

int LEDwidth = 36, LEDheight = 36, space = 4;
float globalTime = 0, globalSpeed = 0.2;
float localTimeColumn = 0, localTimeRow = 0, localTimeRipple = 0;
float localSpeedColumn = 1.0, localSpeedRow = 1.0, localSpeedRipple = 1.0;
float currentSpeedColumn = 0, currentSpeedRow = 0, currentSpeedRipple = 0;
int globalCounter = 0;
int localCounterColumn = 0, localCounterRow = 0, localCounterRipple = 0;
int rippleCenterX = 0, rippleCenterY = 0;

// =========================== setup() ===========================
void setup() {
  size(columnN*(LEDwidth + space) + space, rowN*(LEDheight + space) + space);
  frameRate(20);
  colorMode(HSB, 360, 100, 100);

  //set x & y coordinate to each LED object
  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j] = new LED(i, j);
    }
  }

  currentSpeedColumn = localSpeedColumn;
  currentSpeedRow = localSpeedRow;
}

// =========================== draw() ===========================
void draw() {
  background(30);
  drawLEDs();
  lightUpColumns();
  lightUpRows();
  drawRipples();
  mouseOver();
  timeManagement();
}

// =========================== drawLEDs() ===========================
void drawLEDs() {
  //draw LEDs
  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].drawLED();
    }
  }
}

// =========================== lightUpColumns() ===========================
void lightUpColumns() {
  //light up Columns
  for (int j = 0; j < rowN; j++) {
    leds[localCounterColumn][j].columnOn();
  }

  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].columnOff();
    }
  }

  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].lightUpColumns();
    }
  }
}

// =========================== lightUpRows() ===========================
void lightUpRows() {
  //light up Rows
  for (int i = 0; i < columnN; i++) {
    leds[i][localCounterRow].rowOn();
  }

  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].rowOff();
    }
  }

  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].lightUpRows();
    }
  }
}

// =========================== drawRipples() ===========================
void drawRipples() {
  //when mouse pressed on a particular LED, begin drawing a ripple
  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].ifMousePressedThenBeginDrawingRipple();
    }
  }

  //determine which led should light up for drawing the ripple
  if (localCounterRipple > 0) {
    for (int k = 0; k < localCounterRipple - 1; k++) {
      //------------ light up each LED which should light up for drawing ripple ------------
      //light on upper right LEDs from center point, only when its column and row exist
      if (((rippleCenterX+k) >= 0) && ((rippleCenterX+k) < columnN)
        && ((rippleCenterY-(localCounterRipple-1)+k) >= 0) && ((rippleCenterY-(localCounterRipple-1)+k) < rowN)) {
        leds[rippleCenterX+k][rippleCenterY-(localCounterRipple-1)+k].rippleOn();
      }
      //light up lower right LEDs LEDs from center point, only when its column and row exist
      if (((rippleCenterX+(localCounterRipple-1)-k) >= 0) && ((rippleCenterX+(localCounterRipple-1)-k) < columnN)
        && ((rippleCenterY+k) >= 0) && ((rippleCenterY+k) < rowN)) {
        leds[rippleCenterX+(localCounterRipple-1)-k][rippleCenterY+k].rippleOn();
      }
      //light up lower left LEDs from center point, only when its column and row exist
      if (((rippleCenterX-k) >= 0) && ((rippleCenterX-k) < columnN)
        && ((rippleCenterY+(localCounterRipple-1)-k) >= 0) && ((rippleCenterY+(localCounterRipple-1)-k) < rowN)) {
        leds[rippleCenterX-k][rippleCenterY+(localCounterRipple-1)-k].rippleOn();
      }
      //light up upper left LEDs from center point, only when its column and row exist
      if (((rippleCenterX-(localCounterRipple-1)+k) >= 0) && ((rippleCenterX-(localCounterRipple-1)+k) < columnN)
        && ((rippleCenterY-k) >= 0) && ((rippleCenterY-k) < rowN)) {
        leds[rippleCenterX-(localCounterRipple-1)+k][rippleCenterY-k].rippleOn();
      }

      //------------ if there are no LEDs lighting up, the ripple will be finished ------------      
      if ((((rippleCenterX+k) < 0) || ((rippleCenterX+k) >= columnN))
        && (((rippleCenterY-(localCounterRipple-1)+k) < 0) || ((rippleCenterY-(localCounterRipple-1)+k) >= rowN))
        && (((rippleCenterX+(localCounterRipple-1)-k) < 0) || ((rippleCenterX+(localCounterRipple-1)-k) >= columnN))
        && (((rippleCenterY+k) < 0) || ((rippleCenterY+k) >= rowN))
        && (((rippleCenterX-k) < 0) || ((rippleCenterX-k) >= columnN))
        && (((rippleCenterY+(localCounterRipple-1)-k) < 0) || ((rippleCenterY+(localCounterRipple-1)-k) >= rowN))
        && (((rippleCenterX-(localCounterRipple-1)+k) < 0) || ((rippleCenterX-(localCounterRipple-1)+k) >= columnN))
        && (((rippleCenterY-k) < 0) || ((rippleCenterY-k) >= rowN))) {
        localTimeRipple = 0;
        currentSpeedRipple = 0;
        localCounterRipple = 0;
      }
    }
  }

  //light up LEDs for a particular duration to draw ripple
  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].rippleOff();
    }
  }

  //draw ripple
  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].drawRipples();
    }
  }
}

// =========================== mouseOver() ===========================
void mouseOver() {
  //mouse over
  for (int i = 0; i < columnN; i++) {
    for (int j = 0; j < rowN; j++) {
      leds[i][j].mouseOver();
    }
  }
}

// =========================== timeManagement() ===========================
void timeManagement() {
  //progress time

  globalTime += globalSpeed;
  localTimeColumn += globalSpeed*currentSpeedColumn;
  localTimeRow += globalSpeed*currentSpeedRow;
  localTimeRipple += globalSpeed*currentSpeedRipple;

  //loop localTime for lighting columns within a range from 0 to columnN
  if (localTimeColumn >= columnN) {
    localTimeColumn = localTimeColumn - columnN;
  } 
  else if (localTimeColumn < 0) {
    localTimeColumn = localTimeColumn + (columnN - 0.01);
  }

  //loop localTime for lighting rows within a range from 0 to rowN
  if (localTimeRow >= rowN) {
    localTimeRow = localTimeRow - rowN;
  } 
  else if (localTimeRow < 0) {
    localTimeRow = localTimeRow + (rowN - 0.01);
  }

  globalCounter = floor(globalTime);
  localCounterColumn = floor(localTimeColumn);
  localCounterRow = floor(localTimeRow);
  localCounterRipple = floor(localTimeRipple);
}

// =========================== keyPressed() ===========================
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      currentSpeedRow = -abs(currentSpeedRow);
    }
    else if (keyCode == DOWN) {
      currentSpeedRow = abs(currentSpeedRow);
    }
    else if (keyCode == RIGHT) {
      currentSpeedColumn = abs(currentSpeedColumn);
    }
    else if (keyCode == LEFT) {
      currentSpeedColumn = -abs(currentSpeedColumn);
    }
  } 
  else if (key == '=') {
    currentSpeedColumn = currentSpeedColumn*2;
    currentSpeedRow = currentSpeedRow*2;
    currentSpeedRipple = currentSpeedRipple*2;
  }
  else if (key == '-') {
    currentSpeedColumn = currentSpeedColumn/2;
    currentSpeedRow = currentSpeedRow/2;
    currentSpeedRipple = currentSpeedRipple/2;
  }  
}

