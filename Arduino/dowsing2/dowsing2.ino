//=========================================
//global variables
//=========================================
#include <Servo.h>

const int rightRodPin = 9;
const int leftRodPin = 10;
Servo rightServo;
Servo leftServo;
int rAngle = 90;   // right servo position in degrees
int lAngle = 90;   // left servo position in degrees


//=========================================
//setup
//=========================================
void setup() {
  rightServo.attach(rightRodPin);
  leftServo.attach(leftRodPin);

  Serial.begin(9600);
}


//=========================================
//loop
//=========================================
void loop() {
  if (Serial.available()) {
    char command = Serial.read();

    switch (command) {
      case 'f':
        //move forward
        moveForward();
        break;
        //------------------------

      case 'b':
        //turn around 180 degrees
        turnAround();
        break;
        //------------------------

      case 'l':
        //upcoming left(within 10 seconds)
        incomingLeft();
        break;
        //------------------------

      case 'L':
        //turn left now
        turnLeft();
        break;
        //------------------------

      case 'r':
        //upcoming right(within 10 seconds)
        incomingRight();
        break;
        //------------------------

      case 'R':
        //turn tight now
        turnRight();
        break;
        //------------------------

      case 's':
        //stop
        temporaryStop();
        break;
        //------------------------

      case 'S':
        //stop, you've reached your destination
        reachedDestination();
        break;
        //------------------------
    }
  }
}

//=========================================
// Move Forward Function
//=========================================
void moveForward() {
  //turn both rods to straight position
    rAngle = 90;
    lAngle = 90;
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
}

//=========================================
// Turn Around Function
//=========================================
void turnAround() {
  //close both rods
  for (int i = 0; i < 30; i++) {
    rAngle = 90 + i; //turn left
    lAngle = 90 - i; //turn right
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 120 - i; //turn right
    lAngle = 60 + i; //turn left
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 60 + i; //turn left
    lAngle = 120 - i; //turn right
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 120 - i; //turn right
    lAngle = 60 + i; //turn left
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 60 + i; //turn left
    lAngle = 120 - i; //turn right
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 120 - i; //turn right
    lAngle = 60 + i; //turn left
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 30; i++) {
    rAngle = 60 + i; //turn left
    lAngle = 120 - i; //turn right
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

}

//=========================================
// Incoming Left Function
//=========================================
void incomingLeft() {
  //close both rods
  for (int i = 0; i < 30; i++) {
    lAngle = 90 - i; //turn right
    leftServo.write(lAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    lAngle = 60 + i; //turn left
    leftServo.write(lAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 60; i++) {
    lAngle = 120 - i; //turn right
    leftServo.write(lAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    lAngle = 60 + i; //turn left
    leftServo.write(lAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 60; i++) {
    lAngle = 120 - i; //turn right
    leftServo.write(lAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    lAngle = 60 + i; //turn left
    leftServo.write(lAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 30; i++) {
    lAngle = 120 - i; //turn right
    leftServo.write(lAngle);
    delay(15);
  }
}

//=========================================
// Turn Left Function
//=========================================
void turnLeft() {
  //turn both rods to left
  for (int i = 0; i < 90; i++) {
    rAngle = 90 + i;
    lAngle = 90 + i;
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //wait for 3 seconds
  delay(3000);

  //return both rods to straight position
  for (int i = 0; i < 90; i++) {
    rAngle = 180 - i;
    lAngle = 180 - i;
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

}

//=========================================
// Incoming Right Function
//=========================================
void incomingRight() {
  //close both rods
  for (int i = 0; i < 30; i++) {
    rAngle = 90 + i; //turn left
    rightServo.write(rAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 120 - i; //turn right
    rightServo.write(rAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 60 + i; //turn left
    rightServo.write(rAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 120 - i; //turn right
    rightServo.write(rAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 60 + i; //turn left
    rightServo.write(rAngle);
    delay(15);
  }

  //open both rods
  for (int i = 0; i < 60; i++) {
    rAngle = 120 - i; //turn right
    rightServo.write(rAngle);
    delay(15);
  }

  //close both rods
  for (int i = 0; i < 30; i++) {
    rAngle = 60 + i; //turn left
    rightServo.write(rAngle);
    delay(15);
  }

}

//=========================================
// Turn Right Function
//=========================================
void turnRight() {
  //turn both rods to right
  for (int i = 0; i < 90; i++) {
    rAngle = 90 - i;
    lAngle = 90 - i;
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //wait for 3 seconds
  delay(3000);

  //return both rods to straight position
  for (int i = 0; i < 90; i++) {
    rAngle = i;
    lAngle = i;
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }
}

//=========================================
// Temporary Stop Function
//=========================================
void temporaryStop() {
  //close both rods
  for (int i = 0; i < 90; i++) {
    rAngle = 90 + i; //turn left
    lAngle = 90 - i; //turn right
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //wait for 3 seconds
  delay(3000);

  //return both bars to straight position
  for (int i = 0; i < 90; i++) {
    rAngle = 180 - i; //turn left
    lAngle = i; //turn right
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }
}

//=========================================
// Reached Destination Function
//=========================================
void reachedDestination() {
  //open both bars 
  for (int i = 0; i < 90; i++) {
    rAngle = 90 - i; //turn left
    lAngle = 90 + i; //turn right
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }

  //wait for 3 seconds
  delay(6000);

  //return both bars to straight position  
  for (int i = 0; i < 90; i++) {
    rAngle = i; //turn right
    lAngle = 180 - i; //turn left
    rightServo.write(rAngle);
    leftServo.write(lAngle);
    delay(15);
  }
}

