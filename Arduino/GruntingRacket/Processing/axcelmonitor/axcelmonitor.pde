import processing.serial.*;     // import the Processing serial library
Serial myPort;                  // The serial port

PVector xAxis, pxAxis, yAxis, pyAxis, zAxis, pzAxis;
float time = 0, speed = 1;

void setup() {
  size(800, 600);
  
  //printArray(Serial.list()); // List all the available serial ports
  myPort = new Serial(this, Serial.list()[3], 9600);

  // read bytes into a buffer until you get a linefeed (ASCII 10):
  myPort.bufferUntil('\n');

  xAxis = new PVector(0,0);
  pxAxis = new PVector(0,0);
  yAxis = new PVector(0,0);
  pyAxis = new PVector(0,0);
  zAxis = new PVector(0,0);
  pzAxis = new PVector(0,0);

  // draw with smooth edges:
  smooth();
}

void draw() {
  float mappedTime = map(time, 0, 4000, 0, width);
  xAxis.x = mappedTime;
  yAxis.x = mappedTime;
  zAxis.x = mappedTime;
  
  pushMatrix();
  translate(0, height/3);
  stroke(255);
  line(0 , 0, width, 0);
  stroke(255, 0, 0);
  line(pxAxis.x, pxAxis.y, xAxis.x, xAxis.y);
  text("xAxis", 20, -height/3 + 20);
  popMatrix();
  
  pushMatrix();
  translate(0, height*2/3);
  stroke(255);
  line(0 , 0, width, 0);
  stroke(0, 255, 0);
  line(pyAxis.x, pyAxis.y, yAxis.x, yAxis.y);
  text("yAxis", 20, -height/3 + 20);
  popMatrix();

  pushMatrix();
  translate(0, height);  
  stroke(0, 0, 255);
  line(pzAxis.x, pzAxis.y, zAxis.x, zAxis.y);
  text("zAxis", 20, -height/3 + 20);
  popMatrix();
  
  pxAxis.set(xAxis);
  pyAxis.set(yAxis);
  pzAxis.set(zAxis);  
  time += speed;
}


void serialEvent(Serial myPort) {
  //println("hello");
  
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  myString = trim(myString);

  // split the string at the commas
  // and convert the sections into integers:
  int sensors[] = int(split(myString, ','));

  // print out the values you got:
  for (int sensorNum = 0; sensorNum < sensors.length; sensorNum++) {
    print("Sensor " + sensorNum + ": " + sensors[sensorNum] + "\t");
  }
  // add a linefeed after all the sensor values are printed:
  println();
  
  if (sensors.length > 1) {
    xAxis.y = map(sensors[0], 300, 800, 0, -height/3);
    yAxis.y = map(sensors[1], 300, 800, 0, -height/3);
    zAxis.y = map(sensors[2], 300, 800, 0, -height/3);
  }
  // send a byte to ask for more data:
  myPort.write("A");
}


