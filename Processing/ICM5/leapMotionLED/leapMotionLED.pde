// =========================== global variables ===========================
import processing.opengl.*;
import de.voidplus.leapmotion.*;
LeapMotion leap;

int xN = 5, yN = 5, zN = 5;
LED[][][] leds = new LED[xN][yN][zN];

int LEDradius = 40, space = 40, depth;
float hx, hy, hz;

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

  leap = new LeapMotion(this);
}

// =========================== draw() ===========================
void draw() {
  background(0);
  cameraManagement();
  lightsManagement();
  displayHands();
  lightUpByHand();
  displayLEDs();
}

// =========================== cameraManagement ===========================
void cameraManagement() {
  float cAngleMX = map(mouseX, 0, width, -PI/2, PI*3/2);
  float cRadius = depth*5/2;
  float cX = cRadius*cos(cAngleMX);
  float cY = map(mouseY, 0, height, -height*2, height*2);
  float cZ = cRadius*sin(cAngleMX);
  camera(cX, cY, cZ, 0, 0, 0, 0, 1, 0);
}

// =========================== lightsManagement ===========================
void lightsManagement() {
  ambientLight(63, 31, 31);
  directionalLight(40, 20, 60, 0, 1, 1);
  pointLight(30, 60, 100, mouseX, mouseY, 200);
  spotLight(100, 0, 100, mouseX, mouseY, 200, 0, 0, -1, PI, 2);
}

// =========================== displayHands() ===========================
void displayHands() {
  for (Hand hand : leap.getHands()) {
    PVector hand_stabilized  = hand.getStabilizedPosition();

    hx = map(hand_stabilized.x, 0, width, -width*2/3, width*2/3);
    hy = map(hand_stabilized.y, 0, height, -width*2/3, width*2/3);
    hz = map(hand_stabilized.z, -90, 20, -depth*2, depth*2);
    
    pushMatrix();    
    translate(-hx, hy, hz - depth*3);
    fill(60, 50, 100, 200);
    sphere(20);
//    fill(60, 50, 100, 50);
//    sphere(200);
    popMatrix();
  }
}

// =========================== lightUpByHand() ===========================
void lightUpByHand() {
  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      for (int k = 0; k < zN; k++) {
        leds[i][j][k].hand();
      }
    }
  }
}

// =========================== displayLEDs() ===========================
void displayLEDs() {
  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      for (int k = 0; k < zN; k++) {
        leds[i][j][k].displayLED();
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


