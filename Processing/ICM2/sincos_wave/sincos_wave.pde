float vguideX1;
float vguideX2;
float vguideX3;
float vguideX4;
float vguideX5;
float hguideY1;
float hguideY2;
float hguideY3;
float hguideY4;
float hguideY5;
float radious;
float Xcord;
float Ycord;
float pXcord;
float pYcord;
float sin;
float cos;
float radians;
float degrees;
float t;
float tr;
float speed;
float trmap;
float ptrmap;

void setup() {
  size(600, 600);
  background(220);
  vguideX1 = 100;
  vguideX2 = 200;
  vguideX3 = 300;
  vguideX4 = 400;
  vguideX5 = 500;
  hguideY1 = 100;
  hguideY2 = 200;
  hguideY3 = 300;
  hguideY4 = 400;
  hguideY5 = 500;
  radious = 80;
  Xcord = radious;
  Ycord = 0;
  pXcord = radious;
  pYcord = 0;
  sin = 0;
  cos = 1;
  radians = 0;
  degrees = 0;
  t = 0;
  tr = 0;
  speed = 0.5;
  trmap = 0;
  ptrmap = 0;

  //text
  fill(0, 150, 0, 200);
  textSize(18);
  text("π/2", 180, 105);
  text("π", 292, 105);
  text("3π/2", 375, 105);
  text("2π", 488, 105);
  text("π/2", 80, 205);
  text("π", 92, 305);
  text("3π/2", 75, 405);
  text("2π", 88, 505);
}

void draw() {
  smooth();

  //erace privious blue ball
  fill(220);
  stroke(220);
  ellipse(pXcord + vguideX1, hguideY1 - pYcord, 20, 20);

  //erace texts for data
  fill(220);
  noStroke();
  rect(vguideX2 + 1, hguideY2 + 1, width - vguideX2 - 1, height - hguideY2 - 1);

  //set tr (radians based on time)
  tr = map(t, 0, 255, 0, 5/2*PI);

  //set trmap (it will be used as a cordinate to draw curves)
  trmap = map(tr, 0, 5/2*PI, 0, vguideX5);

  //set cordinates
  Xcord = radious*cos(tr);
  if (tr == 5/2*PI) {
    Ycord = 0;
  } 
  else { 
    Ycord = radious*sin(tr);
  }

  //draw guidelines
  stroke(120);
  line(vguideX1, 0, vguideX1, height);
  line(vguideX2, 0, vguideX2, hguideY2);
  line(vguideX3, 0, vguideX3, hguideY2);
  line(vguideX4, 0, vguideX4, hguideY2);
  line(vguideX5, 0, vguideX5, hguideY2);
  line(0, hguideY1, width, hguideY1);
  line(0, hguideY2, vguideX2, hguideY2);
  line(0, hguideY3, vguideX2, hguideY3);
  line(0, hguideY4, vguideX2, hguideY4);
  line(0, hguideY5, vguideX2, hguideY5);
  line(vguideX2, hguideY2, vguideX2, height);
  line(vguideX2, hguideY2, width, hguideY2);

  //draw a circle
  stroke(120);
  noFill();
  ellipse(vguideX1, hguideY1, 2*radious, 2*radious);

  //draw balls
  stroke(220);
  strokeWeight(1);
  fill(255, 0, 0);
  ellipse(vguideX1, hguideY1, 10, 10);
  fill(0, 0, 255);
  ellipse(Xcord + vguideX1, hguideY1 - Ycord, 20, 20);

  /*
  //draw a line btw two balls
   noFill();
   line(vguideX1, hguideY1, Xcord + vguideX1, hguideY1 - Ycord);
   
   //draw a line btw blue ball and horizontal guideline
   line(Xcord + vguideX1, hguideY1 - Ycord, Xcord + vguideX1, hguideY1);
   
   //draw an arc btw the line depicted above and horizontal guideline
   noFill();
   arc(vguideX1, hguideY1, radious/3, radious/3, 2*PI- tr, 2*PI);
   */

  //texts for data
  fill(0, 150, 0, 200);
  textSize(30);
  text("↑sin wave", 340, 240);
  text("←cos wave", 210, 400);
  fill(0, 150, 0);

  textSize(15);
  fill(0, 150, 0, 200);
  text("x: "+ Xcord, 400, 440);
  text("y: "+ Ycord, 400, 460);
  text("radious: "+ radious, 400, 480);
  sin = Ycord/radious;
  text("sinθ: "+ sin, 400, 500);
  cos = Xcord/radious;
  text("cosθ: "+ cos, 400, 520); 
  if (Ycord > 0) {
    radians = acos(cos);
    text("radians: "+ radians, 400, 540);
    degrees = degrees(radians);
    text("degrees: "+ degrees, 400, 560);
  } 
  else {
    radians = 2*PI - acos(cos);
    text("radians: "+ radians, 400, 540);
    degrees = degrees(radians);
    text("degrees: "+ degrees, 400, 560);
  }

  //draw a sinwave and coswave
  strokeWeight(2);
  stroke(0);
  line(vguideX1 + ptrmap, hguideY1 - pYcord, vguideX1 + trmap, hguideY1 - Ycord);
  line(vguideX1 + pXcord, hguideY1 + ptrmap, vguideX1 + Xcord, hguideY1 + trmap);
  strokeWeight(1);

  //stock some data as privious variables
  ptrmap = trmap;
  pXcord = Xcord;
  pYcord = Ycord;

  //stop drawing when the wave reachs end
  if (trmap == vguideX5) {
    speed = 0;
  }

  //add to t
  t = t + speed;
}

