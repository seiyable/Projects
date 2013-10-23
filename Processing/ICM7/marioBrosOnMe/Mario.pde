class Mario {
  //================ in-class variables ================
  PVector location, pLocation, speed, acceleration;
  boolean walk = false, drift = false, jump = false, readyToJump = false, stopAscending = false, onGround = false;
  float walkCounter = 0, jumpCounter = 0, readyToJumpCounter;
  PImage standImg, walkImg1, walkImg2, walkImg3, driftImg, jumpImg, deadImg;
  int direction = 1;
  float imageWidth = 32;

  //================ constructor ================  
  Mario(PVector _location) {
    location = new PVector(_location.x, _location.y);
    pLocation = new PVector(0, 0);
    speed = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    standImg = loadImage("stand.gif");
    walkImg1 = loadImage("walk1.gif");
    walkImg2 = loadImage("walk2.gif");
    walkImg3 = loadImage("walk3.gif");
    driftImg = loadImage("drift.gif");
    jumpImg = loadImage("jump.gif");
    deadImg = loadImage("dead.gif");

    imageMode(CENTER);
  }

  //================ display() ================
  void display() {
    pushMatrix();
    translate(location.x, location.y);

    if (direction == -1) {
      scale(-1, 1);
    }

    if ((walk == true) && (drift == false) && (onGround == true)) {
      if (floor(walkCounter) == 0) {
        image(walkImg1, 0, 0);
      }
      else if (floor(walkCounter) == 1) {
        image(walkImg2, 0, 0);
      }
      else if (floor(walkCounter) == 2) {
        image(walkImg3, 0, 0);
      }
    }

    else if ((walk == true) && (drift == true) && (onGround == true)) {
      image(driftImg, 0, 0);
    }

    else if (onGround == false) {
      image(jumpImg, 0, 0);
    }

    else {
      image(standImg, 0, 0);
    }

    popMatrix();
  }

  //================ walk() ================  
  void walk(int _direction, float _accelerationX) {
    walk = true;
    direction = _direction;
    acceleration.x = _accelerationX;

    walkCounter += 0.1;
    if (walkCounter >= 3.0) {
      walkCounter -= 3.0;
    }
  }

  //================ checkDrift() ================
  void checkDrift() {
    if (walk == true) {
      if (((direction == 1) && (speed.x < 0)) || ((direction == -1) && (speed.x > 0))) {
        drift = true;
      }
      else {
        drift = false;
      }
    }
  }

  //================ slowDown() ================  
  void slowDown() {
    if (walk == true) {
      acceleration.x = -direction*abs(acceleration.x);

      walkCounter += 0.1;
      if (walkCounter >= 3.0) {
        walkCounter -= 3.0;
      }

      mario.stopWalking();
    }
  }

  //================ stopWalking() ================
  void stopWalking() {

    if (direction == 1) {
      if (speed.x <= 0) {
        speed.x = 0;
        acceleration.x = 0;
        walk = false;
        walkCounter = 0;
      }
    }
    if (direction == -1) {
      if (speed.x >= 0) {
        speed.x = 0;
        acceleration.x = 0;
        walk = false;
        walkCounter = 0;
      }
    }
  }

  //================ increaseReadyToJumpCounter() ================  
  void increaseReadyToJumpCounter() {
    readyToJumpCounter += 0.1;
  }

  //================ checkReadyToJump() ================
  void checkReadyToJump() {
    if ((readyToJumpCounter == 0) && (jump == false) && (onGround == true)) {
      readyToJump = true;
    } 
    else {
      readyToJump = false;
    }
  }

  //================ startJump() ================
  void startJump() {
    if (readyToJump == true) {
      jump = true;
      onGround = false;
      stopAscending = false;
      music.playSE(jumpSE);
    }
  }

  //================ jump() ================  
  void jump(float _speedY) {
    if (jump == true) {
      jumpCounter += 0.1;
      if (jumpCounter > 2.0) {
        stopAscending = true;
      }
      if (stopAscending == false) {
        speed.y = -_speedY;
      }
    }
  }

  //================ stopAscending() ================
  void stopAscending() {
    if (jump == true) {
      stopAscending = true;
    }
  }

  //================ resetReadyToJumpCounter() ================  
  void resetReadyToJumpCounter() {
    readyToJumpCounter = 0;
  }

  //================ fall() ================
  void fall(float _accelerationY) {
    if (((onGround == false) && (jump == false)) || ((onGround == false) && (stopAscending == true))) {
      acceleration.y = _accelerationY;
    }
  }

  //================ update() ================
  void update() {
    pLocation.set(location);
    speed.add(acceleration);
    speed.x = constrain(speed.x, -3, 3);
    speed.y = constrain(speed.y, -7, 7);
    location.add(speed);
  }

  //================ checkBlocks() ================
  void checkBlocks() {
    onGround = false;

    for (Block i : blocks) {
      PVector blockL = i.getLocation();
      float blockW = i.getBlockWidth();
      float adj = 2;

      float blockCenterX = blockL.x;
      float blockCenterY = blockL.y;
      float blockTopFace = blockL.y - blockW/2;
      float blockRightFace = blockL.x + blockW/2;
      float blockUnderFace = blockL.y + blockW/2;
      float blockLeftFace = blockL.x - blockW/2;

      float marioCenterX = location.x;
      float marioCenterY = location.y;
      float marioTopFace = location.y - imageWidth/2;
      float pMarioTopFace = pLocation.y - imageWidth/2;
      float marioRightFace = location.x + imageWidth/2 - adj;
      float pMarioRightFace = pLocation.x + imageWidth/2 - adj;
      float marioUnderFace = location.y + imageWidth/2;
      float pMarioUnderFace = pLocation.y + imageWidth/2;
      float marioLeftFace = location.x - imageWidth/2 + adj;
      float pMarioLeftFace = pLocation.x - imageWidth/2 + adj;

      if ((marioRightFace > blockLeftFace) && (marioLeftFace <= blockRightFace)) {
        if ((marioUnderFace > blockTopFace) && (pMarioUnderFace <= blockTopFace)) { 
          //------------ stop falling ------------
          location.y = blockTopFace - imageWidth/2;
          speed.y = 0;
          acceleration.y = 0;
          onGround = true;
          jump = false;
          readyToJump = true;
          stopAscending = false;
          jumpCounter = 0;
        } 
        else if ((marioTopFace < blockUnderFace) && (pMarioTopFace >= blockUnderFace)) {
          //------------ stop ascending ------------
          location.y = blockUnderFace + imageWidth/2;
          speed.y = 0;
          stopAscending();
        }
      }

      if ((marioUnderFace > blockTopFace) && (marioTopFace <= blockUnderFace)) {
        if ((marioRightFace > blockLeftFace) && (pMarioRightFace <= blockLeftFace)) {
          //------------ stop going right ------------
          location.x = blockLeftFace - imageWidth/2;
          speed.x = 0;
          acceleration.x = 0;
        }
        else if ((marioLeftFace < blockRightFace) && (pMarioLeftFace >= blockRightFace)) {
          //------------ stop going left ------------
          location.x = blockRightFace + imageWidth/2;
          speed.x = 0;
          acceleration.x = 0;
        }
      }

      //------------ check onGround ------------
      if ((marioRightFace > blockLeftFace) && (marioLeftFace <= blockRightFace)) {
        if (marioUnderFace == blockTopFace) {
          onGround = true;
        }
      }
    }
  }
  //================ restart() ================
  void restart() {
    PVector newLocation = new PVector(width/2, 0);
    location.set(newLocation);
  }
}

