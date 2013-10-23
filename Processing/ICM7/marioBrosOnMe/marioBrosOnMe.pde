//================== import libraries ==================
import ddf.minim.*;
import SimpleOpenNI.*;

//=================== global variables ===================
Minim minim;
Music music;
AudioPlayer bgm1;
AudioSnippet jumpSE;

SimpleOpenNI kinect;
Background background;
ArrayList<Block> blocks;
boolean captureMode = true;
color[] famiColors = {
  #757575, #BCBCBC, #FFFFFF, #FFFFFF, 
  #271B8F, #0073EF, #3FBFFF, #ABE7FF, 
  #0000AB, #233BEF, #5F73FF, #C7D7FF, 
  #47009F, #8300F3, #A78BFD, #D7CBFF, 
  #8F0077, #BF00BF, #F77BFF, #FFC7FF, 
  #AB0013, #E7005B, #FF77B7, #FFC7DB, 
  #A70000, #DB2B00, #FF7763, #FFBFB3, 
  #7F0B00, #CB4F0F, #FF9B3B, #FFDBAB, 
  #432F00, #8B7300, #F3BF3F, #FFE7A3, 
  #004700, #009700, #83D313, #E3FFA3, 
  #005100, #00AB00, #4FDF4B, #ABF3BF, 
  #003F17, #00933B, #58F898, #B3FFCF, 
  #1B3F5F, #00838B, #00EBDB, #9FFFF3, 
  #000000, #000000, #757575, #BCBCBC
};

Mario mario;
Key upKey, downKey, leftKey, rightKey, aKey, bKey, xKey, yKey, lKey, rKey, strtKey, slctKey;
Key[] keys;

//=================== setup() ======================================
void setup() {
  size(640, 480, P2D);
  colorMode(HSB, 360, 100, 100, 100);
  frameRate(20);

  //----------------- setting for bgm & se -----------------
  minim = new Minim(this);
  music = new Music();
  bgm1 = minim.loadFile("bgm1.mp3");
  jumpSE = minim.loadSnippet("jump.mp3");

  //----------------- setting for kinect & background -----------------
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.alternativeViewPointDepthToImage();
  background = new Background();
  blocks = new ArrayList<Block>();

  //----------------- setting for mario -----------------
  PVector mLocation = new PVector(width/2, 0);
  mario = new Mario(mLocation);

  //----------------- setting for key control -----------------
  upKey    = new Key("UP", (char)CODED, UP);
  downKey  = new Key("DOWN", (char)CODED, DOWN);
  leftKey  = new Key("LEFT", (char)CODED, LEFT);
  rightKey = new Key("RIGHT", (char)CODED, RIGHT);
  aKey     = new Key("A", 'a', 0);
  bKey     = new Key("B", 'b', 0);
  xKey     = new Key("X", 'x', 0);
  yKey     = new Key("Y", 'y', 0);
  lKey     = new Key("L", 'l', 0);
  rKey     = new Key("R", 'r', 0);
  strtKey  = new Key("START", ' ', 0);
  slctKey  = new Key("SELECT", 'q', 0);

  keys = new Key[12];
  keys[0] = upKey;
  keys[1] = downKey;
  keys[2] = leftKey;
  keys[3] = rightKey;
  keys[4] = aKey;
  keys[5] = bKey;
  keys[6] = xKey;
  keys[7] = yKey;
  keys[8] = lKey;
  keys[9] = rKey;
  keys[10] = strtKey;
  keys[11] = slctKey;
}



//================ draw() ===================================
void draw() {
  println(frameRate);
  background.display();
  if (captureMode == true) {
    generateBlocks();
  }
  displayBlocks();

  if (captureMode == false) {
    displayMario();
    walkMario();
    slowDownMario();
    jumpMario();
    fallMario();
    updateMario();
    checkBlocks();
    restartMario();
  }

  switchMode();
}

//================ generateBlocks() ================
void generateBlocks() {
  background.getPixelsWithin(2.0);
  background.generateBlocks();
}

//================ displayBlocks() ================

void displayBlocks() {
  for (Block i : blocks) {
    i.display();
  }
}

//================ displayMario() ================
void displayMario() {
  mario.display();
}

//================ walkMario() ================
void walkMario() {
  if (rightKey.isPressed == true) {
    mario.walk(1, 0.1);
    mario.checkDrift();
  }
  else if (leftKey.isPressed == true) {
    mario.walk(-1, -0.1);
    mario.checkDrift();
  }
}

//================ slowDownMario() ================
void slowDownMario() {
  if ((rightKey.isPressed == false) && (leftKey.isPressed == false)) {
    mario.slowDown();
  }
}

//================ jumpMario() ================
void jumpMario() {
  if (bKey.isPressed == true) {
    mario.checkReadyToJump();
    mario.increaseReadyToJumpCounter();
    mario.startJump();
    mario.jump(5);
  }
  else if (bKey.isPressed == false) {
    mario.stopAscending();
    mario.resetReadyToJumpCounter();
  }
}

//================ fallMario() ================
void fallMario() {
  mario.fall(0.5);
}

//================ updateMario() ================
void updateMario() {
  mario.update();
}

//================ checkBlocks() ================
void checkBlocks() {
  mario.checkBlocks();
}

//================ restartMario() ================
void restartMario() {
  if (xKey.isPressed == true) {
    mario.restart();
  }
}

//================ switchMode() ================
void switchMode() {
  if (strtKey.isPressed == true) {
    captureMode = false;
    frameRate(60);
    mario.restart();
    music.playBGM(bgm1);
  }
  if (slctKey.isPressed == true) {
    captureMode = true;
    frameRate(20);
    music.pauseBGM(bgm1);
  }
}

//================ keyPressed() ================
void keyPressed() {
  for (int i = 0; i < keys.length; i++) {
    keys[i].pressed(key, keyCode);
  }
}

//================ keyReleased() ================
void keyReleased() {
  for (int i = 0; i < keys.length; i++) {
    keys[i].released(key, keyCode);
  }
}

//================== stop() ==================
void stop() {
  music.finish();
  minim.stop();
  super.stop();
}

