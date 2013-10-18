class ZLIGHT {
  // =========================== in-class variables ===========================
  float xTime, yTime, speed;
  float xCurrentSpeed, yCurrentSpeed;
  int xCounter, yCounter;
  float startTime, duration;
  int hue;

  // =========================== constructor ===========================
  ZLIGHT(int _xTime, int _yTime, float _speed) {
    xTime = _xTime;
    yTime = _yTime;
    speed = _speed;
    xCurrentSpeed = speed;
    yCurrentSpeed = 0;
    xCounter = 0;
    yCounter = 0;
    hue = 150;
  } 

  // =========================== drawYLight ===========================
  void drawZLight() {
    for (int k = 0; k < zN; k++) {
      leds[xCounter][yCounter][k].colorH += hue;
      leds[xCounter][yCounter][k].colorS = 50;
      leds[xCounter][yCounter][k].colorB = 100;
      leds[xCounter][yCounter][k].alpha = 255;
    }
  }

  // =========================== progressTime ===========================
  void progressTime() {
    xTime += globalSpeed*xCurrentSpeed;
    if (xTime >= xN) {
      xTime = xTime - xN;
    } 
    else if (xTime < 0) {
      xTime = xTime + (xN - 0.01);
    }

    yTime += globalSpeed*yCurrentSpeed;
    if (yTime >= yN) {
      yTime = yTime - yN;
    } 
    else if (yTime < 0) {
      yTime = yTime + (yN - 0.01);
    }
  }

  // =========================== setCounter ===========================
  void setCounter() {
    xCounter = floor(xTime);
    yCounter = floor(yTime);
  }
}
