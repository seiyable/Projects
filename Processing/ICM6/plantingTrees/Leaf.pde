class Leaf {
  //=================== in-class valuables =================== 
  PVector location;
  color h, s, b;
  float lWidth;
  PShape l;

  //=================== constructor ===================
  Leaf(PVector _location, int _direction, float _lWidth) {
    location = _location.get();
    h = (int) random(60, 120);
    s = (int) random(70, 100);
    b = (int) random(70, 100);
    lWidth = _lWidth;
    
    int d = _direction;
    l = createShape();
    l.beginShape();
    l.fill(h, s, b);
    l.noStroke();
    l.vertex(0, 0);
    l.bezierVertex(d*lWidth/5, -lWidth/5, d*lWidth*3/5, -lWidth/5, d*lWidth, 0);
    l.bezierVertex(d*lWidth*3/5, lWidth/5, d*lWidth/5, lWidth/5, d*0, 0);
    l.endShape();
    
  }

  //=================== display() ===================
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    shape(l);
    popMatrix();
  }
  
  //=================== display() ===================
  PVector getLocation() {
    return location; 
  }
}

