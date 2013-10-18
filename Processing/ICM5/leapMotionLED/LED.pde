class LED {
  // =========================== in-class variables ===========================
  int x, y, z;
  int colorH, colorS, colorB, alpha;
  boolean lightThisUpForColumns, lightThisUpForRows, lightThisUpForRipples;

  // =========================== constructor ===========================
  LED(int _x, int _y, int _z) {
    x = _x;
    y = _y;
    z = _z;
    colorH = 0;
    colorS = 0;
    colorB = 50;
    alpha = 255;
  }

  // =========================== displayLED ===========================
  void displayLED() {
    while (colorH > 360) colorH -= 360;
    fill(colorH, colorS, colorB, alpha);
    noStroke();

    pushMatrix();
    translate(-width/2 + x*(LEDradius*2 + space), -height/2 + y*(LEDradius*2 + space), -depth/2 + z*(LEDradius*2 + space));
    sphere(LEDradius);
    popMatrix();

    colorH = 0;
    colorS = 0;
    colorB = 50;
    alpha = 255;
  }

  // =========================== hand ===========================
  void hand() {
    float d = dist(-hx, hy, hz - depth*3, -width/2 + x*(LEDradius*2 + space), -height/2 + y*(LEDradius*2 + space), -depth/2 + z*(LEDradius*2 + space));
    if (d < 200) {
      colorB = 100;
    }
  }
}

