class RIPPLE {
  // =========================== in-class variables ===========================
  int centerX, centerY, centerZ;
  float time, speed;
  float currentSpeed;
  int counter;
  int hue;

  // =========================== constructor ===========================
  RIPPLE(int _centerX, int _centerY, int _centerZ, float _speed) {
    centerX = _centerX;
    centerY = _centerY;
    centerZ = _centerZ;
    time = 0;
    speed = _speed;
    currentSpeed = 0;
    counter = 0;
    hue = 320;
  } 

  // =========================== drawRipple ===========================
  void drawRipple() {
    if (counter >= 1) {
      for (int i = 0; i < counter; i++) {
        //---------------------- X-Y plain ----------------------
        // X-Y plain (x > 0, y > 0)   #the origin is (centerX, centerY)
        if (((centerX+(counter-1)-i) >= 0) && ((centerX+(counter-1)-i) < xN)
          && ((centerY+i) >= 0) && ((centerY+i) < yN)) {
          leds[centerX+(counter-1)-i][centerY+i][centerZ].colorH += hue;
          leds[centerX+(counter-1)-i][centerY+i][centerZ].colorS = 50;
          leds[centerX+(counter-1)-i][centerY+i][centerZ].colorB = 100;
          leds[centerX+(counter-1)-i][centerY+i][centerZ].alpha = 255;
        }
        // X-Y plain (x > 0, y < 0)   #the origin is (centerX, centerY)
        if (((centerX+i) >= 0) && ((centerX+i) < xN)
          && ((centerY-(counter-1)+i) >= 0) && ((centerY-(counter-1)+i) < yN)) {
          leds[centerX+i][centerY-(counter-1)+i][centerZ].colorH += hue;
          leds[centerX+i][centerY-(counter-1)+i][centerZ].colorS = 50;
          leds[centerX+i][centerY-(counter-1)+i][centerZ].colorB = 100;
          leds[centerX+i][centerY-(counter-1)+i][centerZ].alpha = 255;
        }
        // X-Y plain (x < 0, y < 0)   #the origin is (centerX, centerY)
        if (((centerX-(counter-1)+i) >= 0) && ((centerX-(counter-1)+i) < xN)
          && ((centerY-i) >= 0) && ((centerY-i) < yN)) {
          leds[centerX-(counter-1)+i][centerY-i][centerZ].colorH += hue;
          leds[centerX-(counter-1)+i][centerY-i][centerZ].colorS = 50;
          leds[centerX-(counter-1)+i][centerY-i][centerZ].colorB = 100;
          leds[centerX-(counter-1)+i][centerY-i][centerZ].alpha = 255;
        }
        // X-Y plain (x < 0, y > 0)   #the origin is (centerX, centerY)
        if (((centerX-i) >= 0) && ((centerX-i) < xN)
          && ((centerY+(counter-1)-i) >= 0) && ((centerY+(counter-1)-i) < yN)) {
          leds[centerX-i][centerY+(counter-1)-i][centerZ].colorH += hue;
          leds[centerX-i][centerY+(counter-1)-i][centerZ].colorS = 50;
          leds[centerX-i][centerY+(counter-1)-i][centerZ].colorB = 100;
          leds[centerX-i][centerY+(counter-1)-i][centerZ].alpha = 255;
        }

        //---------------------- Y-Z plain ----------------------       
        // Y-Z plain (y > 0, z > 0)   #the origin is (centerY, centerZ)
        if (((centerY+(counter-1)-i) >= 0) && ((centerY+(counter-1)-i) < yN)
          && ((centerZ+i) >= 0) && ((centerZ+i) < zN)) {
          leds[centerX][centerY+(counter-1)-i][centerZ+i].colorH += hue;
          leds[centerX][centerY+(counter-1)-i][centerZ+i].colorS = 50;
          leds[centerX][centerY+(counter-1)-i][centerZ+i].colorB = 100;
          leds[centerX][centerY+(counter-1)-i][centerZ+i].alpha = 255;
        }        
        // Y-Z plain (y > 0, z < 0)   #the origin is (centerY, centerZ)
        if (((centerY+i) >= 0) && ((centerY+i) < yN)
          && ((centerZ-(counter-1)+i) >= 0) && ((centerZ-(counter-1)+i) < zN)) {
          leds[centerX][centerY+i][centerZ-(counter-1)+i].colorH += hue;
          leds[centerX][centerY+i][centerZ-(counter-1)+i].colorS = 50;
          leds[centerX][centerY+i][centerZ-(counter-1)+i].colorB = 100;
          leds[centerX][centerY+i][centerZ-(counter-1)+i].alpha = 255;
        }
        // Y-Z plain (y < 0, z < 0)   #the origin is (centerY, centerZ)
        if (((centerY-(counter-1)+i) >= 0) && ((centerY-(counter-1)+i) < yN)
          && ((centerZ-i) >= 0) && ((centerZ-i) < zN)) {
          leds[centerX][centerY-(counter-1)+i][centerZ-i].colorH += hue;
          leds[centerX][centerY-(counter-1)+i][centerZ-i].colorS = 50;
          leds[centerX][centerY-(counter-1)+i][centerZ-i].colorB = 100;
          leds[centerX][centerY-(counter-1)+i][centerZ-i].alpha = 255;
        }        
        // Y-Z plain (y < 0, z > 0)   #the origin is (centerY, centerZ)
        if (((centerY-i) >= 0) && ((centerY-i) < yN)
          && ((centerZ+(counter-1)-i) >= 0) && ((centerZ+(counter-1)-i) < zN)) {
          leds[centerX][centerY-i][centerZ+(counter-1)-i].colorH += hue;
          leds[centerX][centerY-i][centerZ+(counter-1)-i].colorS = 50;
          leds[centerX][centerY-i][centerZ+(counter-1)-i].colorB = 100;
          leds[centerX][centerY-i][centerZ+(counter-1)-i].alpha = 255;
        }

        //---------------------- Z-X plain ----------------------          
        // Z-X plain (z > 0, x > 0)   #the origin is (centerZ, centerX)
        if (((centerZ+(counter-1)-i) >= 0) && ((centerZ+(counter-1)-i) < zN)
          && ((centerX+i) >= 0) && ((centerX+i) < xN)) {
          leds[centerX+i][centerY][centerZ+(counter-1)-i].colorH += hue;
          leds[centerX+i][centerY][centerZ+(counter-1)-i].colorS = 50;
          leds[centerX+i][centerY][centerZ+(counter-1)-i].colorB = 100;
          leds[centerX+i][centerY][centerZ+(counter-1)-i].alpha = 255;
        }        
        // Z-X plain (z > 0, x < 0)   #the origin is (centerZ, centerX)        
        if (((centerZ+i) >= 0) && ((centerZ+i) < zN)
          && ((centerX-(counter-1)+i) >= 0) && ((centerX-(counter-1)+i) < xN)) {
          leds[centerX-(counter-1)+i][centerY][centerZ+i].colorH += hue;
          leds[centerX-(counter-1)+i][centerY][centerZ+i].colorS = 50;
          leds[centerX-(counter-1)+i][centerY][centerZ+i].colorB = 100;
          leds[centerX-(counter-1)+i][centerY][centerZ+i].alpha = 255;
        }        
        // Z-X plain (z < 0, x < 0)   #the origin is (centerZ, centerX)
        if (((centerZ-(counter-1)+i) >= 0) && ((centerZ-(counter-1)+i) < zN)
          && ((centerX-i) >= 0) && ((centerX-i) < xN)) {
          leds[centerX-i][centerY][centerZ-(counter-1)+i].colorH += hue;
          leds[centerX-i][centerY][centerZ-(counter-1)+i].colorS = 50;
          leds[centerX-i][centerY][centerZ-(counter-1)+i].colorB = 100;
          leds[centerX-i][centerY][centerZ-(counter-1)+i].alpha = 255;
        }        
        // Z-X plain (z < 0, x > 0)   #the origin is (centerZ, centerX)
        if (((centerZ-i) >= 0) && ((centerZ-i) < zN)
          && ((centerX+(counter-1)-i) >= 0) && ((centerX+(counter-1)-i) < xN)) {
          leds[centerX+(counter-1)-i][centerY][centerZ-i].colorH += hue;
          leds[centerX+(counter-1)-i][centerY][centerZ-i].colorS = 50;
          leds[centerX+(counter-1)-i][centerY][centerZ-i].colorB = 100;
          leds[centerX+(counter-1)-i][centerY][centerZ-i].alpha = 255;
        }
      }
    }

    //---------------------- adjustment ----------------------
    if (counter == 1) {
      leds[centerX][centerY][centerZ].colorH -= hue*11;
    }
    else if (counter >= 2) {
      if ((centerX+(counter-1)) < xN) {
      leds[centerX+(counter-1)][centerY][centerZ].colorH -= hue*3;
      }
      if ((centerX-(counter-1)) >= 0) {
      leds[centerX-(counter-1)][centerY][centerZ].colorH -= hue*3;
      }
      if ((centerY+(counter-1)) < yN) {
      leds[centerX][centerY+(counter-1)][centerZ].colorH -= hue*3;
      }
      if ((centerY-(counter-1)) >= 0) {
      leds[centerX][centerY-(counter-1)][centerZ].colorH -= hue*3;
      }
      if ((centerZ+(counter-1)) < zN) {
      leds[centerX][centerY][centerZ+(counter-1)].colorH -= hue*3;
      }
      if ((centerZ-(counter-1)) >= 0) {
      leds[centerX][centerY][centerZ-(counter-1)].colorH -= hue*3;
      }
    }
  }

  // =========================== progressTime ===========================
  void progressTime() {
    time += globalSpeed*currentSpeed;
  }

  // =========================== setCounter ===========================
  void setCounter() {
    counter = floor(time);
  }
}

