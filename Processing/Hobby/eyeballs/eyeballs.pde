int xN = 10, yN = 10;
int eyeballWidth = 50;
int space = 5;
Eyeball[][] eyeballs = new Eyeball[xN][yN];

void setup() {
  size(xN*(eyeballWidth + space) + space, yN*(eyeballWidth + space) + space, P2D);
  colorMode(HSB, 360, 100, 100);  

  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      eyeballs[i][j] = new Eyeball(eyeballWidth/2 + i*(eyeballWidth + space) + space, eyeballWidth/2 + j*(eyeballWidth + space) + space);
    }
  }
}

void draw() {
  background(200);
  drawEyeballs();
}

void drawEyeballs() {
  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      eyeballs[i][j].display();
    }
  }
}

