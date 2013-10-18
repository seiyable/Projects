class XLIGHT {
  // =========================== in-class variables ===========================
  float yTime, zTime, speed;
  float yCurrentSpeed, zCurrentSpeed;
  int yCounter, zCounter;
  int hue;

  // =========================== constructor ===========================
  XLIGHT(int _yTime, int _zTime, float _speed) {
    yTime = _yTime;
    zTime = _zTime;
    speed = _speed;
    yCurrentSpeed = 0;
    zCurrentSpeed = speed;
    yCounter = 0;
    zCounter = 0;
    hue = 30;
  } 

  // =========================== drawXLight ===========================
  void drawXLight() {
    for (int i = 0; i < xN; i++) {
      leds[i][yCounter][zCounter].colorH += hue;
      leds[i][yCounter][zCounter].colorS = 50;
      leds[i][yCounter][zCounter].colorB = 100;
      leds[i][yCounter][zCounter].alpha = 255;
    }
  }

  // =========================== progressTime ===========================
  void progressTime() {
    yTime += globalSpeed*yCurrentSpeed;
    if (yTime >= yN) {
      yTime = yTime - yN;
    } 
    else if (yTime < 0) {
      yTime = yTime + (yN - 0.01);
    }

    zTime += globalSpeed*zCurrentSpeed;
    if (zTime >= zN) {
      zTime = zTime - zN;
    } 
    else if (zTime < 0) {
      zTime = zTime + (zN - 0.01);
    }
  }

  // =========================== setCounter ===========================
  void setCounter() {
    yCounter = floor(yTime);
    zCounter = floor(zTime);
  }
}
