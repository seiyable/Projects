class LED {
  // =========================== in-class variables ===========================
  int x, y;
  int colorH, colorS, colorB, alpha;
  boolean lightThisUpForColumns, lightThisUpForRows, lightThisUpForRipples;
  float startTimeColumn, startTimeRow, startTimeRipple;
  float columnDuration, rowDuration, rippleDuration;

  // =========================== constructor ===========================
  LED(int _x, int _y) {
    x = _x;
    y = _y;
    colorH = 0;
    colorS = 0;
    colorB = 50;
    alpha = 255;
    lightThisUpForColumns = false;
    lightThisUpForRows = false;
    lightThisUpForRipples = false;
    startTimeColumn = 0;
    startTimeRow = 0;
    startTimeRipple = 0;
    columnDuration = globalSpeed*0.9;
    rowDuration = globalSpeed*0.9;
    rippleDuration = globalSpeed*0.9;
  }

  // =========================== drawLEDs ===========================
  void drawLED() {
    fill(colorH, colorS, colorB, alpha);
    noStroke();
    ellipse(x*(LEDwidth + space) + LEDwidth/2 + space, y*(LEDheight + space) + LEDheight/2 + space, LEDwidth, LEDheight);
    colorH = 0;
    colorS = 0;
    colorB = 50;
    alpha = 255;
  }

  // =========================== columnOn() ===========================
  void columnOn() {
    lightThisUpForColumns = true;
    startTimeColumn = globalTime;
  }

  // =========================== columnOff() ===========================
  void columnOff() {
    if (lightThisUpForColumns == true) {
      if ((globalTime - startTimeColumn) >= columnDuration) {
        lightThisUpForColumns = false;
      }
    }
  }

  // =========================== lightUpColumns() ===========================
  void lightUpColumns() {
    if (lightThisUpForColumns == true) {
      colorH += 60;
      colorS = 50;
      colorB = 100;
      alpha = 255;
    }
  }

  // =========================== rowOn() ===========================
  void rowOn() {
    lightThisUpForRows = true;
    startTimeRow = globalTime;
  }

  // =========================== rowOff() ===========================
  void rowOff() {
    if (lightThisUpForRows == true) {
      if ((globalTime - startTimeRow) >= rowDuration) {
        lightThisUpForRows = false;
      }
    }
  }

  // =========================== lightUpRows() ===========================
  void lightUpRows() {
    if (lightThisUpForRows == true) {
      colorH += 90;
      colorS = 50;
      colorB = 100;
      alpha = 255;
    }
  }

  // =========================== ifMousePressedThenBeginDrawingRipple() ===========================
  void ifMousePressedThenBeginDrawingRipple() {
    //judge whether mouse is pressed on it or not
    if ((mousePressed == true) && (dist(mouseX, mouseY, x*(LEDwidth + space) + LEDwidth/2 + space, y*(LEDheight + space) + LEDheight/2 + space) < LEDwidth/2)) {
      rippleCenterX = x; //remember the x-coordinate of the center of the ripple
      rippleCenterY = y; //remember the y-coordinate of the center of the ripple
      localTimeRipple = 0; //reset
      localCounterRipple = 0; //reset
      currentSpeedRipple = localSpeedRipple; //begin drawing ripple
    }
  }

  // =========================== rippleOn() ===========================
  void rippleOn() {
    lightThisUpForRipples = true;
    startTimeRipple = globalTime; //remember time when each LED started lighting up for drawing ripple
  }

  // =========================== rippleOff() ===========================
  void rippleOff() {
    if (lightThisUpForRipples == true) {
      if ((globalTime - startTimeRipple) >= rippleDuration) {
        lightThisUpForRipples = false;
      }
    }
  }

  // =========================== drawRipples() ===========================
  void drawRipples() {
    if (lightThisUpForRipples == true) {
      colorH += 200;
      colorS = 50;
      colorB = 100;
      alpha = 255;
    }
  }

  // =========================== mouseOver() ===========================  
  void mouseOver() {
    if (dist(mouseX, mouseY, x*(LEDwidth + space) + LEDwidth/2 + space, y*(LEDheight + space) + LEDheight/2 + space) < LEDwidth/2) {
      colorB -= 30;
    }
  }
}

