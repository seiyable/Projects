//================ import libraries ================
import processing.serial.*;     // import the Processing serial library

//================ global variables ================
Serial myPort;                  // The serial port

PVector xAxis, pxAxis, yAxis, pyAxis, zAxis, pzAxis;
float time = 0, speed = 1;

//data that will be saved in csv file
ArrayList<PVector> xAxisData = new ArrayList<PVector>();
ArrayList<PVector> yAxisData = new ArrayList<PVector>();
ArrayList<PVector> zAxisData = new ArrayList<PVector>();

//================ setup() ================
void setup() {
  size(1200, 600);
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

//================ draw() ================
void draw() {
  drawCurves();
  makeDataforCSV();
}

//================ drawCurves() ================
void drawCurves() {
  float mappedTime = map(time, 0, 2000, 0, width);
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

//================ saveDataInCSV() ================
void makeDataforCSV() {
  PVector current_xAxis = new PVector(xAxis.x, xAxis.y);
  PVector current_yAxis = new PVector(yAxis.x, yAxis.y);  
  PVector current_zAxis = new PVector(zAxis.x, zAxis.y);
  
  xAxisData.add(current_xAxis);
  yAxisData.add(current_yAxis);
  zAxisData.add(current_zAxis);  
}

//================ serialEvent() ================
void serialEvent(Serial myPort) { 
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
    xAxis.y = map(sensors[0], 0, 1023, 0, -height/3);
    yAxis.y = map(sensors[1], 0, 1023, 0, -height/3);
    zAxis.y = map(sensors[2], 0, 1023, 0, -height/3);    
  }
  // send a byte to ask for more data:
  myPort.write("A");
}

//================ mousePressed() ================
//save data in arraylist to new csv file
void mousePressed() {
  
  text("Recorded in CSV", width - 120, 10);
  
  Table table = new Table();
  table.addColumn("xAxis.x", Table.FLOAT);
  table.addColumn("xAxis.y", Table.FLOAT);
  table.addColumn("yAxis.x", Table.FLOAT);
  table.addColumn("yAxis.y", Table.FLOAT);
  table.addColumn("zAxis.x", Table.FLOAT);
  table.addColumn("zAxis.y", Table.FLOAT);
  
  for(int i = 0; i < xAxisData.size(); i++) {
    PVector xAxisValue = xAxisData.get(i);
    PVector yAxisValue = yAxisData.get(i); 
    PVector zAxisValue = zAxisData.get(i);
    
    TableRow row = table.addRow();
    row.setFloat("xAxis.x", xAxisValue.x);
    row.setFloat("xAxis.y", xAxisValue.y);
    row.setFloat("yAxis.x", yAxisValue.x);
    row.setFloat("yAxis.y", yAxisValue.y);
    row.setFloat("zAxis.x", zAxisValue.x);
    row.setFloat("zAxis.y", zAxisValue.y);
  }
  
  int y = year();
  int mn = month();
  int d = day();
  int h = hour();
  int mi = minute();
  int s = second();
  String filename = "data/" + y + mn + d + h + mi + s + ".csv";
  saveTable(table, filename);
}