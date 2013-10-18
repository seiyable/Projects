// =========================== global variables ===========================
import processing.opengl.*;
int xN = 5, yN = 5, zN = 5;
LED[][][] leds = new LED[xN][yN][zN];

int LEDradius = 40, space = 40, depth;
float globalTime = 0, globalSpeed = 0.2;

XLIGHT[] xLights = new XLIGHT[1];
YLIGHT[] yLights = new YLIGHT[1];
ZLIGHT[] zLights = new ZLIGHT[1];
RIPPLE[] ripples = new RIPPLE[1];

// =========================== setup() ===========================
void setup() {
  size((xN-1)*(LEDradius*2 + space), (yN-1)*(LEDradius*2 + space), OPENGL);
  depth = width;
  frameRate(20);
  colorMode(HSB, 360, 100, 100);
  noStroke();

  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      for (int k = 0; k < zN; k++) {
        leds[i][j][k] = new LED(i, j, k);
      }
    }
  }

  xLights[0] = new XLIGHT(2, 2, 0.7);
  yLights[0] = new YLIGHT(2, 2, 0.7);
  zLights[0] = new ZLIGHT(3, 3, -0.7);
  ripples[0] = new RIPPLE(2, 2, 2, 0.7);
}

// =========================== draw() ===========================
void draw() {
  background(0);
  cameraManagement();
  lightsManagement();
  drawLEDs();
  drawXLights();
  drawYLights();
  drawZLights();
  drawRipples();
  timeManagement();
}

// =========================== cameraManagement ===========================
void cameraManagement() {
  float cAngleMX = map(mouseX, 0, width, 0, 2*PI);
  float cRadius = depth*5/2;
  float cX = cRadius*cos(cAngleMX);
  float cY = map(mouseY, 0, height, -height*2, height*2);
  float cZ = cRadius*sin(cAngleMX);
  camera(cX, cY, cZ, 0, 0, 0, 0, 1, 0);
}

// =========================== lightsManagement ===========================
void lightsManagement() {
  ambientLight(63, 31, 31);
  directionalLight(0, 0, 100, 0, 1, 0);
  pointLight(30, 60, 100, mouseX, mouseY, 200);
  spotLight(100, 100, 100, mouseX, mouseY, 200, 0, 0, -1, PI, 2);
}

// =========================== drawLEDs() ===========================
void drawLEDs() {
  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      for (int k = 0; k < zN; k++) {
        leds[i][j][k].drawLED();
      }
    }
  }
/*
  leds[0][0][0].colorH = 0;
  leds[0][0][0].colorS = 200;
  leds[1][0][0].colorH = 20;
  leds[1][0][0].colorS = 200;
  leds[2][0][0].colorH = 40;
  leds[2][0][0].colorS = 200;
  leds[0][1][0].colorH = 200;
  leds[0][1][0].colorS = 200;
  leds[0][2][0].colorH = 220;
  leds[0][2][0].colorS = 200;
*/
}

// =========================== drawXLights() ===========================
void drawXLights() {
  xLights[0].drawXLight();
}

// =========================== drawYLights() ===========================
void drawYLights() {
  yLights[0].drawYLight();
}

// =========================== drawZLights() ===========================
void drawZLights() {
  zLights[0].drawZLight();
}

// =========================== drawRipples() ===========================
void drawRipples() {
  ripples[0].drawRipple();
}


// =========================== timeManagement() ===========================
void timeManagement() {
  globalTime += globalSpeed;
  xLights[0].progressTime();
  xLights[0].setCounter();
  yLights[0].progressTime();
  yLights[0].setCounter();
  zLights[0].progressTime();
  zLights[0].setCounter();
  ripples[0].progressTime();
  ripples[0].setCounter();
}

// =========================== keyPressed() ===========================
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      xLights[0].yCurrentSpeed = -xLights[0].speed;
      xLights[0].zCurrentSpeed = 0;
    }
    else if (keyCode == DOWN) {
      xLights[0].yCurrentSpeed = xLights[0].speed;
      xLights[0].zCurrentSpeed = 0;
    }
    else if (keyCode == RIGHT) {
      xLights[0].yCurrentSpeed = 0;
      xLights[0].zCurrentSpeed = -xLights[0].speed;
    }
    else if (keyCode == LEFT) {
      xLights[0].yCurrentSpeed = 0;
      xLights[0].zCurrentSpeed = xLights[0].speed;
    }
  } 
  else if (key == 'w') {
    yLights[0].xCurrentSpeed = -yLights[0].speed;
    yLights[0].zCurrentSpeed = 0;
  } 
  else if (key == 's') {
    yLights[0].xCurrentSpeed = yLights[0].speed;
    yLights[0].zCurrentSpeed = 0;
  } 
  else if (key == 'd') {
    yLights[0].xCurrentSpeed = 0;
    yLights[0].zCurrentSpeed = -yLights[0].speed;
  } 
  else if (key =='a') {
    yLights[0].xCurrentSpeed = 0;
    yLights[0].zCurrentSpeed = yLights[0].speed;
  }
}

// =========================== mousePressed() ===========================
void mousePressed() {
  ripples[0].time = 0;
  ripples[0].currentSpeed = ripples[0].speed;
  
}
