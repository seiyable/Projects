int xN = 10, yN = 10;
int arrowWidth = 50;
Arrow[][] arrows = new Arrow[xN][yN];

void setup() {
  size(xN*arrowWidth, yN*arrowWidth, P2D);
  colorMode(HSB, 360, 100, 100);  

  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      arrows[i][j] = new Arrow(arrowWidth/2 + i*arrowWidth, arrowWidth/2 + j*arrowWidth);
    }
  }
}

void draw() {
  background(0);
  drawArrows();
}

void drawArrows() {
  for (int i = 0; i < xN; i++) {
    for (int j = 0; j < yN; j++) {
      arrows[i][j].display();
    }
  }
}

