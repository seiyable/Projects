void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  
  pinMode(2, INPUT);
  pinMode(13, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  
  if(digitalRead(2) == HIGH){
    digitalWrite(13, HIGH);
    Serial.println("ON");
  } else {
    digitalWrite(13, LOW);
  }

}
