float vguideX;
float hguideY;
float radius;
float Xcord;
float Ycord;
float sin;
float cos;
float radians;
float degrees;
float t;
float tr;
float speed;

void setup() {
  size(640, 640);
  vguideX = width/2;
  hguideY = height/2;
  radius = 200;
  Xcord = width/2;
  Ycord = height/2;
  sin = 0;
  cos = 0;
  radians = 0;
  degrees =0;
  t = 0;
  tr = 0;
  speed = 1;
}

void draw() {
  background(220);
  //set tr (radians based on time)
  tr = map(t, 0, 255, 0, 2*PI);

  //data
  fill(0, 150, 0, 200);
  text("radius: "+ radius, 500, 540);

  Xcord = radius*cos(tr);
  text("x: "+ Xcord, 500, 500);
  Ycord = radius*sin(tr);
  text("y: "+ Ycord, 500, 520);  
  sin = Ycord/radius;
  text("sinθ: "+ sin, 500, 560);
  cos = Xcord/radius;
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
  ellipse(vguideX, hguideY, 2*radius, 2*radius);

  //draw guidelines
  stroke(0, 100);
  line(0, hguideY, width, hguideY);
  line(vguideX, 0, vguideX, height);

  //draw balls
  stroke(0, 100);
  fill(255, 0, 0);
  ellipse(vguideX, hguideY, 10, 10);
  fill(0, 0, 255);
  ellipse(Xcord + vguideX, hguideY - Ycord, 20, 20);

  //draw a line btw two balls
  noFill();
  line(vguideX, hguideY, Xcord + vguideX, hguideY - Ycord);

  //draw a line btw blue ball and horizontal guideline
  line(Xcord + vguideX, hguideY - Ycord, Xcord + vguideX, hguideY);

  //draw an arc btw the line depicted above and horizontal guideline
  noFill();
  arc(vguideX, hguideY, radius/5, radius/5, 2*PI- radians, 2*PI);

  //difinition
  //  fill(0, 150, 0, 200);
  //  text("radius", vguideX - 25, hguideY - radius - 20);
  //  text("sinθ", mouseX + 20, mouseY + Ycord/2);
  //  text("cosθ", mouseX - Xcord/2, hguideY + 20);
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

  text("Press a key to change speed", 20, 20);
  text("'1': slow / '2': middle / '3': fast", 20, 40);
  
  //add to t
  t = t + speed;
}

void keyPressed() {
  if (key == '1') {
    speed = 1;
  }  else if (key == '2') {
    speed = 2;
  }  else if (key == '3') {
    speed = 3;
  }  
}


