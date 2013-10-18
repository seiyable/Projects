float vguideX;
float hguideY;
float radious;
float Xcord;
float Ycord;
float sin;
float cos;
float radians;
float degrees;

void setup() {
  size(640, 640);
  vguideX = width/2;
  hguideY = height/2;
  radious = 0;
  Xcord = width/2;
  Ycord = height/2;
  sin = 0;
  cos = 0;
  radians = 0;
  degrees =0;
}

void draw() {
  background(220);

  //data
  fill(0, 150, 0, 200);
  Xcord = mouseX - vguideX;
  text("x: "+ Xcord, 500, 500);
  Ycord = hguideY - mouseY;
  text("y: "+ Ycord, 500, 520);  
  radious = dist(mouseX, mouseY, vguideX, hguideY);
  text("radious: "+ radious, 500, 540);
  sin = Ycord/radious;
  text("sinθ: "+ sin, 500, 560);
  cos = Xcord/radious;
  text("cosθ: "+ cos, 500, 580);
  if (Ycord > 0) {
    radians = acos(cos);
    text("radians: "+ radians, 500, 600);
    degrees = degrees(radians);
    text("degrees: "+ degrees, 500, 620);
  } 
  else {
    radians = 2*PI - acos(cos);
    text("radians: "+ radians, 500, 600);
    degrees = degrees(radians);
    text("degrees: "+ degrees, 500, 620);
  }

  //draw a circle
  stroke(0, 100);
  noFill();
  ellipse(vguideX, hguideY, 2*radious, 2*radious);

  //draw guidelines
  stroke(0, 100);
  line(0, hguideY, width, hguideY);
  line(vguideX, 0, vguideX, height);

  //draw balls
  stroke(0, 100);
  fill(255, 0, 0);
  ellipse(vguideX, hguideY, 10, 10);
  fill(0, 0, 255);
  ellipse(mouseX, mouseY, 20, 20);

  //draw a line btw two balls
  noFill();
  line(vguideX, hguideY, mouseX, mouseY);

  //draw a line btw blue ball and horizontal guideline
  line(mouseX, mouseY, mouseX, hguideY);

  //draw an arc btw the line depicted above and horizontal guideline
  noFill();
  arc(vguideX, hguideY, radious/5, radious/5, 2*PI- radians, 2*PI);

  //difinition
  fill(0, 150, 0, 200);
  text("radious", vguideX - 25, hguideY - radious - 20);
  text("sinθ", mouseX + 20, mouseY + Ycord/2);
  text("cosθ", mouseX - Xcord/2, hguideY + 20);
  noFill();
  stroke(0, 150, 0, 200);
  triangle(30, 600, 150, 520, 150, 600);
  arc(30, 600, 50, 50, PI*11/6, 2*PI);
  fill(0, 150, 0, 200);
  text("θ", 60, 595);
  text("r", 85, 553);
  text("x", 90, 615);
  text("y", 157, 567); 
  text("Difinition:", 180, 550);
  text("sinθ = y/r", 190, 570);
  text("cosθ = x/r", 190, 590);
}

