class YLIGHT {
  // =========================== in-class variables ===========================
  float xTime, zTime, speed;
  float xCurrentSpeed, zCurrentSpeed;
  int xCounter, zCounter;
  float startTime, duration;
  int hue;

  // =========================== constructor ===========================
  YLIGHT(int _xTime, int _zTime, float _speed) {
    xTime = _xTime;
    zTime = _zTime;
    speed = _speed;
    xCurrentSpeed = speed;
    zCurrentSpeed = 0;
    xCounter = 0;
    zCounter = 0;
    hue = 90;
  } 

  // =========================== drawYLight ===========================
  void drawYLight() {
    for (int j = 0; j < yN; j++) {
      leds[xCounter][j][zCounter].colorH += hue;
      leds[xCounter][j][zCounter].colorS = 50;
      leds[xCounter][j][zCounter].colorB = 100;
      leds[xCounter][j][zCounter].alpha = 255;
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
    xCounter = floor(xTime);
    zCounter = floor(zTime);
  }
}
