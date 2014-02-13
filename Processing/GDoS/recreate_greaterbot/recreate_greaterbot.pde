// =========================== global variables ===========================
Strip[] strips = new Strip[128];

// =========================== setup() ===========================
void setup() {
  size(640, 640);
  noStroke();
  colorMode(RGB, 255, 255, 255);
  for(int i = 0; i < 128; i++) {
    strips[i] = new Strip();
  }
}

// =========================== draw() ===========================
void draw() {
  background(0);
  for(int i = 0; i < 128; i++) {
    strips[i].display(i*5);
  }
  
//  print(strips[1].sections[8].changePosition);
//  print(",");
//  print(strips[1].sections[8].r);
//  print(",");
//  print(strips[1].sections[8].g);
//  print(",");
//  println(strips[1].sections[8].b);
  
  for(int i = 0; i < 10; i++) {
    print(strips[1].changePositions[i]);
    print(",");
  }
  println();
}
