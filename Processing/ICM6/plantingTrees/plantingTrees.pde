//=================== how to play ===================
//Press space key to grow a tree
//Press mouse to plant it
//give green to this slush-and-burned land!

//=================== global valuables ===================
PImage noTrees;
ArrayList<Branch> branches = new ArrayList<Branch>();
ArrayList<Tree> trees = new ArrayList<Tree>();
ArrayList<Leaf> leavesOnGround = new ArrayList<Leaf>();

float bScale = 1;
int genCounter = 0, genLimit = 5;

//=================== setup() ===================
void setup() {
  size(800, 600, P2D);
  colorMode(HSB, 360, 100, 100);
  noTrees = loadImage("noTrees.jpg");

  float bLength = random(100, 200);
  PVector start = new PVector(0, 0);
  PVector end = new PVector(0, -bLength);
  float bWidth = random(30, 40);
  int h = (int) random(30, 50);
  int s = (int) random(50, 100);
  int b = (int) random(20, 50);
  color bColor = color(h, s, b);
  ArrayList<Leaf> zeroLeaves = new ArrayList<Leaf>();
  branches.add(new Branch(start, end, bWidth, bColor, zeroLeaves));
}

//=================== draw() ===================
void draw() {
  image(noTrees, 0, 0);
  displayLeavesOnTheGorund();
  displayBranches();
  displayTrees();
}

//=================== displayLeavesOnTheGorund() ===================
void displayLeavesOnTheGorund() {
  for (Leaf i : leavesOnGround) {
    i.display();
  }
}

//=================== displayBranches() ===================
void displayBranches() {
  if (mouseY > height/4) {
    pushMatrix();
    translate(mouseX, mouseY);
    bScale = map(mouseY, height/4, height, 0.01, 1);
    scale(bScale);

    for (Branch i : branches) {
      i.display();
    }
    popMatrix();
  }
}

//=================== displayTrees() ===================
void displayTrees() {
  for (Tree i : trees) {
    i.display();
  }
}

//=================== keyPressed() ===================
void keyPressed() {
  if (key == ' ') {
    if (genCounter < genLimit) {
      generateBranches();
    }
    genCounter += 1;
  }
}

//=================== generateBranches() ===================
void generateBranches() {
  int size = branches.size() - 1;
  for (int i = size; i > size - pow(2, genCounter); i--) {
    Branch branch = branches.get(i);
    PVector a = branch.getPointA();
    PVector b = branch.getPointB();
    PVector c = branch.getPointC();
    PVector d = branch.getPointD();
    float w = branch.getBWidth();
    float ang = branch.getBAngle();
    color bColor = branch.getBColor();
    
    ArrayList<Leaf> genLeaves1 = new ArrayList<Leaf>();
    if (i != 0) {
      genLeaves1 = branch.generateLeaves();
    }

    ArrayList<Leaf> genLeaves2 = genLeaves1;
    for (Leaf j : genLeaves2) {
      PVector l = j.getLocation();
      PVector ab = PVector.sub(b, a);
      PVector bc = PVector.sub(c, b);
      float angle = PVector.angleBetween(ab, bc);
      l.rotate(-angle);
      ab.div(2);
      l.add(ab);
      j.location = l.get();
    }

    ArrayList<Leaf> genLeaves3 = genLeaves1;
    for (Leaf j : genLeaves3) {
      PVector l = j.getLocation();
      PVector ab = PVector.sub(b, a);
      PVector bd = PVector.sub(d, b);
      float angle = PVector.angleBetween(ab, bd);
      l.rotate(angle);
      ab.div(2);
      l.add(ab);
      j.location = l.get();
    }

    branches.add(new Branch(b, c, w*4/5.0, bColor, genLeaves2));
    branches.add(new Branch(b, d, w*4/5.0, bColor, genLeaves3));
  }
}

//=================== mousePressed() ===================
void mousePressed() {
  PVector vMouse = new PVector(mouseX, mouseY);
  ArrayList<Branch> tBranches = new ArrayList<Branch>();
  for (Branch i : branches) {
    tBranches.add(i);
  }
  trees.add(new Tree(vMouse, tBranches, bScale));

  for (int i = branches.size() - 1; i >= 0; i--) {
    branches.remove(i);
  }

  float bLength = random(100, 200);
  PVector start = new PVector(0, 0);
  PVector end = new PVector(0, -bLength);
  float bWidth = random(30, 40);
  int h = (int) random(30, 50);
  int s = (int) random(50, 100);
  int b = (int) random(20, 50);
  color bColor = color(h, s, b);
  ArrayList<Leaf> zeroLeaves = new ArrayList<Leaf>();
  branches.add(new Branch(start, end, bWidth, bColor, zeroLeaves));

  genCounter = 0;

  //------------ make the ground green ------------
  int n = trees.size();
  for (int i = 0; i < 10*n; i++) {
    float x = random(width);
    float y = random(height*3/10, height);
    PVector l = new PVector(x, y);
    float w = map(y, height*3/10, height, 3 , 20);
    leavesOnGround.add(new Leaf(l, 1, w));
  }
}

