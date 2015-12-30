/*
Grunting Racket
Every time swinging a tennis racket, you can hear pro tennis players' grantings.
Components are an axcellerometer, a battery, a speaker, Arduino mini, Adafruit Soundboard, a LED, and some buttons.
When a value from axcellerometer excesses a particular threshold, the soundboard will play a tone.
You can switch to other players whose granting you want to hear by pressing a button on the grip.
*/

//============================== filenames =============================
//filename should have 8 charactors
String sharapova[] = {
  "SHARA1!!WAV\n",
  "SHARA5!!WAV\n",
  "SHARA8!!WAV\n",
  "SHARA9!!WAV\n",
  "SHARA16!WAV\n",
  "SHARA17!WAV\n"
};

String serena[] = {
};

String federer[] = {
};

String djokovic[] = {
};

//============================== include libraries =============================
#include <SoftwareSerial.h>
#include "Adafruit_Soundboard.h"

// Choose any two pins that can be used with SoftwareSerial to RX & TX
#define SFX_TX 3
#define SFX_RX 4

// Connect to the RST pin on the Sound Board
#define SFX_RST 2

// You can also monitor the ACT pin for when audio is playing!

// we'll be using software serial
SoftwareSerial ss = SoftwareSerial(SFX_TX, SFX_RX);

// pass the software serial to Adafruit_soundboard, the second
// argument is the debug port (not used really) and the third arg is the reset pin
Adafruit_Soundboard sfx = Adafruit_Soundboard(&ss, NULL, SFX_RST);

// can also try hardware serial with
// Adafruit_Soundboard sfx = Adafruit_Soundboard(&Serial1, NULL, SFX_RST);

//============================== global variables =============================
//Pin assignments -----------------------------------------
const int xInput = A2;
const int yInput = A1;
const int zInput = A0;
const int playerSelectButtonPin = 9;
const int LEDPin = 13;

//Flags -----------------------------------------
boolean isSwung = false;
unsigned long lastSwing;
const int pauseDuration = 2000;

#define DEBOUNCE 100  // button debouncer

//============================== setup =============================
void setup() {
   //analogReference(EXTERNAL);
   Serial.begin(115200);
   Serial.println("Adafruit Sound Board!");
  
   // softwareserial at 9600 baud
   ss.begin(9600);
   // can also do Serial1.begin(9600);
  
   /*
   if (!sfx.reset()) {
     Serial.println("Not found");
     while (1);
   }
   Serial.println("SFX board found");
   */
   
   pinMode(playerSelectButtonPin, INPUT);
   pinMode(LEDPin, OUTPUT);
}

//============================== loop() =============================
void loop() {
  //try to detect swing of racket
  swingDetection();
  
  //play sounds if the racket is swung
  playSounds();
  
  //for debugging use
  testButtonAndLED();
}

//============================== swingDetection() =============================
void swingDetection() {
  //define threshold
  int thresholdHigh = 1000;
  int thresholdLow = 150;
  
  //read analog inputs
  int xRaw = readAxis(xInput);
  int yRaw = readAxis(yInput);
  int zRaw = readAxis(zInput);
  
  //String printThis = "xRaw: " + String(xRaw) + " yRaw: " + String(yRaw) + " zRaw: " + String(zRaw);
  //Serial.println(printThis);
  
  //if one of the input values excesses the threshold, turn the flag on
  if (xRaw > thresholdHigh || yRaw > thresholdHigh || zRaw > thresholdHigh || xRaw < thresholdLow || yRaw < thresholdLow || zRaw < thresholdLow){
    isSwung = true;
    lastSwing = millis();
    Serial.println("Racket was swung!");
    Serial.println("lastSwing: " + String(lastSwing));
    
  } else {
    isSwung = false;
  }
}

//============================== playSounds() =============================
void playSounds() {
  if (isSwung && lastSwing - millis() > pauseDuration) {
    Serial.println("trying to play sound");
    
    //choose one filename
    String filename = chooseFilename();
    
    //convert string to char array
    char name[12];
    filename.toCharArray(name, 12);
    
    //play sound with the filename
    Serial.println("sent command to SFX with this string: " + filename);
    if (! sfx.playTrack(name) ) {
      Serial.println("Failed to play track?");
    }
  }

  //reset the flag
  isSwung = false;
}

//============================== chooseFilename() =============================
// choose one filename randomly
//
String chooseFilename() {
  int arraySize = sizeof(sharapova) / sizeof(String);
  int num = int(random(arraySize));
  String filename = sharapova[num];
  return filename;
}

//============================== readAxis() =============================
// Read "sampleSize" samples and report the average
//
int readAxis(int axisPin) {
  int sampleSize = 10;
  
  long reading = 0;
  analogRead(axisPin);
  delay(1);
  for (int i = 0; i < sampleSize; i++) {
    reading += analogRead(axisPin);
  }
  return reading/sampleSize;
}

//============================== testButtonAndLED() =============================
// Test if they work
//
void testButtonAndLED(){
  if(digitalRead(playerSelectButtonPin) == HIGH){
    digitalWrite(LEDPin, HIGH);
  } else {
    digitalWrite(LEDPin, LOW);
  }
}


