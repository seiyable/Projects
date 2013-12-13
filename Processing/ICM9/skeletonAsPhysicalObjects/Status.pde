class Status {
  //================== global variables ==================
  String message;
  color mColor;
  boolean success = false;
  long successOccuredAt = 0;
  boolean error = false;
  long errorOccuredAt = 0;

  //================== constructor ==================
  Status() {
  }

  //================== setSuccessOcceredAt() ==================
  void setSuccessOccuredAt() {
    successOccuredAt = millis();
  }

  //================== setErrorOcceredAt() ==================
  void setErrorOccuredAt() {
    errorOccuredAt = millis();
  }

  //================== check() ==================
  void check() {
    if ((error == true) && (millis() - errorOccuredAt < 1000)) {
      message = "Recognition failed";
      mColor = color(0, 0, 200);
    } 
    else {
      if (keyPressed) {
        if(key == '`') {
        message = "Recording";
        mColor = color(0, 200, 200);
        }
      } 
      else {
        message = "Say something with holding down 'B' button!";
        mColor = color(200, 0, 0);
      }
    }    
  }

  //================== display() ==================
  void display() {
    fill(200, 100, 0, 100);
    noStroke();
    rect(18, 8, 492, 35);
    fill(0);
    textSize(40);
//    text("Words.substantialness = true;", 20, 40);
    text("Substantialness of Words", 20, 40);

    fill(mColor);
    textSize(25);
    text(message, 20, 63);
    
    fill(0);
    textSize(16);
    text("then you can play with the words, with your body:)", 20, 85);
    
    fill(255, 100, 100);
    textSize(18);
    text("Press 'Y' to erace all the characters", 20, height - 25);
    text("framerate: " + frameRate, 470, height - 25);
  }
}

