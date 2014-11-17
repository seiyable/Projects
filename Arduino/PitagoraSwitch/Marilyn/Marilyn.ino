const int sensorPin = A0;   // input sensor
const int redLEDPin = 2;
const int yellowLEDPin = 3;
const int greenLEDPin = 4;
unsigned long blowingTime = 0;
bool sentSignal = false;

const int threshold = 150;
const unsigned long blowingLimit = 180;

void setup() {
  // configure serial communications:
  Serial.begin(9600);
  pinMode(redLEDPin, OUTPUT);
  pinMode(yellowLEDPin, OUTPUT);
  pinMode(greenLEDPin, OUTPUT);

  // set XBee's destination address:
  setDestination();
  digitalWrite(redLEDPin, LOW);
  digitalWrite(yellowLEDPin, LOW);
  digitalWrite(greenLEDPin, HIGH);
}


void loop() {
  int sensorValue = analogRead(sensorPin);
  Serial.print("sensorValue: ");
  Serial.println(sensorValue);

  if (sensorValue > threshold && sentSignal == false) {
    digitalWrite(yellowLEDPin, HIGH);
    digitalWrite(greenLEDPin, LOW);
    
    blowingTime++;
    Serial.print("blowingTime: ");
    Serial.println(blowingTime);
    
    if (blowingTime > blowingLimit){
      Serial.println('X');
      digitalWrite(redLEDPin, HIGH);
      digitalWrite(yellowLEDPin, LOW);
      sentSignal = true;
    }
  }
}

void setDestination() {
  // put the radio in command mode:
  Serial.print("+++");
  // wait for the radio to respond with "OK\r"
  char thisByte = 0;
  while (thisByte != '\r') {
    if (Serial.available() > 0) {
      thisByte = Serial.read();
    }
  }

  // set the destination address, using 16-bit addressing.
  // if you're using two radios, one radio's destination
  // should be the other radio's MY address, and vice versa:
  Serial.print("ATDH0, DL15\r"); //DL17
  // set my address using 16-bit addressing:
  Serial.print("ATMY16\r");
  // set the PAN ID. If you're working in a place where many people
  // are using XBees, you should set your own PAN ID distinct
  // from other projects.
  Serial.print("ATIDFEED\r");
  // put the radio in data mode:
  Serial.print("ATCN\r");
}
