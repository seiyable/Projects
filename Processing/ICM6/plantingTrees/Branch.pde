class Branch {
  //=================== in-class valuables ===================
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  PVector start, end;
  float bWidth, bAngle;
  int leafN;
  color bColor;
  

  //=================== constructor ===================
  Branch(PVector _start, PVector _end, float _bWidth, color _bColor, ArrayList<Leaf> _leaves) {
    start = _start.get();
    end = _end.get();
    bWidth = random(_bWidth*0.8, _bWidth);
    bAngle = random(PI/12, PI/4);
    leafN = (int) random(10);
    leaves = _leaves;
    bColor = _bColor;
  }

  //=================== display() ===================
  void display() {
    stroke(bColor); //40, 100, 40
    strokeWeight(bWidth);
    line(start.x, start.y, end.x, end.y);
    
    displayLeaves();
  }

  //=================== displayLeaves() ===================
  void displayLeaves() {
    for (Leaf i : leaves) {
      i.display();
    }
  }  

  //=================== getPointA() ===================
  PVector getPointA() {
    return start.get();
  }

  //=================== getPointB() ===================
  PVector getPointB() {
    return end.get();
  }

  //=================== getPointC() ===================
  PVector getPointC() {
    PVector v = PVector.sub(end, start);
    v.mult(2/3.0);
    v.rotate(-bAngle);
    v.add(end);
    return v;
  }

  //=================== getPointD() ===================
  PVector getPointD() {
    PVector v = PVector.sub(end, start);
    v.mult(2/3.0);
    v.rotate(bAngle);
    v.add(end);
    return v;
  }
  
  //=================== generateLeaves() ===================
  ArrayList<Leaf> generateLeaves() {
    ArrayList<Leaf> genLeaves = new ArrayList<Leaf>();
    for (int i = 0; i < leafN; i++) {
      PVector ab = PVector.sub(end, start);
      float l = ab.mag();
      float y = random(l);
      float x = bWidth/2*(int(random(2))*2-1);
      PVector leafL = new PVector(x, y);
      float angle = PVector.angleBetween(leafL, ab);
      leafL.rotate(angle);
      leafL.add(start);

      if (x > 0) {
        genLeaves.add(new Leaf(leafL, 1, bWidth*2));
      } 
      else {
        genLeaves.add(new Leaf(leafL, -1, bWidth*2));
      }
    }
    return genLeaves;
  }  

  //=================== getBWidth() ===================
  float getBWidth() {
    return bWidth;
  }
  
  //=================== getBAngle() ===================
  float getBAngle() {
    return bAngle;
  }
  
  //=================== getBColor() ===================
  color getBColor() {
    return bColor;
  }  

  //=================== getStart() ===================
  PVector getStart() {
    return start;
  }

  //=================== getLPos() ===================
  ArrayList<PVector> getLPos() {
    ArrayList<PVector> lps = new ArrayList<PVector>();
    for (int i = 0; i < leafN; i++) {
      PVector ab = PVector.sub(end, start);
      float l = ab.mag();
      float y = random(l);
      float x = bWidth/2*(int(random(2))*2-1);
      lps.add(new PVector(x, y));
    }
    return lps;
  }   
}

