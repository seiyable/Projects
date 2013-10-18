PImage pikachu;
PImage pokemonsea;
float t;
float tr;
float trmap;
float ptrmap;
float Ycord;
float pYcord;
float speed;
float wwidth;
float wheight;
float waveslope;
float pikatilt;

void setup() {
  size(600, 300);
  frameRate(60);
  pikachu = loadImage("pikachu.gif");
  pokemonsea = loadImage("pokemonsea.gif");
  Ycord = 0;
  pYcord = 0;
  t = 0;
  tr = 0;
  speed = 1;
  trmap = 0;
  ptrmap = 0;
  wwidth = 300;
  wheight = 60;
  waveslope = 1;
  pikatilt = 0;
}

void draw() {
  image(pokemonsea, 0, 0);

  //reset t
  if (t < 0) {
    t=0; 
    speed = 1;
  }

  //set tr (radians based on time)
  tr = map(t, 0, 255, 0, 2*PI);

  //set trmap (it will be used as a cordinate to draw curves)
  trmap = map(tr, 0, 2*PI, 0, wwidth);

  //set cordinates
  Ycord = wheight*sin(tr);

  /*
  //draw a sinwave and coswave
   strokeWeight(2);
   stroke(0);
   line(ptrmap, height/2 - pYcord, trmap, height/2 - Ycord);
   */

  //text
  textSize(20);
  fill(255);
  text("Press [SPACE KEY] to restart", 10, 20);

  //calculate the slope of the wave
  waveslope = (Ycord - pYcord)/(trmap - ptrmap);
  pikatilt = map(waveslope, -3.08, 3.08, -PI*2/5, PI*2/5);

  //draw pikachu
  translate(trmap, height/2 - Ycord - 30);  
  rotate(-pikatilt);
  imageMode(CENTER);
  image(pikachu, 0, 0);

  //stock some data as privious variables
  ptrmap = trmap;
  pYcord = Ycord;

  //add to t
  t = t + speed;
}

void keyPressed() {
  speed = -5;
}

