class Page {
  //================== in-class valuables ================== 
  color pColor;
  PVector leftEdge = new PVector(0, 0);
  PVector sControlLEtoRE = new PVector(0, 0);
  PVector eControlLEtoRE = new PVector(0, 0);
  PVector rightEdge = new PVector(0, 0);
  PVector aniMouse = new PVector(0, 0);
  PVector aniMouseOffSet = new PVector(0, 0);

  //================== constructor ==================
  Page() {
    int hue = (int) random(360);
    pColor = color(hue, 100, 100);
    backs.add(new Back(hue));
  }

  //================== display ==================  
  void display(int _pageN) {
    if (_pageN == pages.size() - 2) {

      float ly;
      float rx;
      PVector vMouse = new PVector(0, 0);
      if (mousePressed) {
        vMouse.set(mouseX, mouseY);
      }
      PVector xAxis = new PVector(1, 0);
      float vMouseMag = vMouse.mag();
      float vMouseAng = PVector.angleBetween(xAxis, vMouse);
      ly = vMouseMag/(2*sqrt(1 - cos(vMouseAng)));
      rx = vMouseMag/(2*sqrt(1 - sin(vMouseAng)));

      leftEdge.set(0, ly);
      rightEdge.set(rx, 0);
      PVector tempSCLEtoRE = new PVector(0, 0);
      PVector tempECLEtoRE = new PVector(0, 0);      
      PVector vLEtoRE = PVector.sub(rightEdge, leftEdge);
      vLEtoRE.div(4);
      tempSCLEtoRE.add(leftEdge);
      tempSCLEtoRE.add(vLEtoRE);
      vLEtoRE.mult(3);
      tempECLEtoRE.add(leftEdge); 
      tempECLEtoRE.add(vLEtoRE);
      sControlLEtoRE = tempSCLEtoRE.get();
      eControlLEtoRE = tempECLEtoRE.get();

      leftEdge.mult(1.2);
      rightEdge.mult(1.2);

      stroke(0);
      strokeWeight(1);   
      fill(pColor);
      beginShape();
      vertex(leftEdge.x, leftEdge.y);
      bezierVertex(sControlLEtoRE.x, sControlLEtoRE.y, eControlLEtoRE.x, eControlLEtoRE.y, rightEdge.x, rightEdge.y);
      vertex(width, 0);
      vertex(width, height);
      vertex(0, height);
      endShape(CLOSE);

      Back b = backs.get(_pageN);
      b.display();
    } 
    else {
      fill(pColor);
      rect(0, 0, width, height);
    }
  }

  //================== stayThePage() ==================  
  void stayThePage(int _pageN) {
    if (_pageN == pages.size() - 2) {

      float ly;
      float rx;
      
      aniMouse.sub(aniMouseOffSet);
      PVector vMouse = aniMouse;

      PVector xAxis = new PVector(1, 0);
      float vMouseMag = vMouse.mag();
      float vMouseAng = PVector.angleBetween(xAxis, vMouse);
      ly = vMouseMag/(2*sqrt(1 - cos(vMouseAng)));
      rx = vMouseMag/(2*sqrt(1 - sin(vMouseAng)));

      leftEdge.set(0, ly);
      rightEdge.set(rx, 0);
      PVector tempSCLEtoRE = new PVector(0, 0);
      PVector tempECLEtoRE = new PVector(0, 0);      
      PVector vLEtoRE = PVector.sub(rightEdge, leftEdge);
      vLEtoRE.div(4);
      tempSCLEtoRE.add(leftEdge);
      tempSCLEtoRE.add(vLEtoRE);
      vLEtoRE.mult(3);
      tempECLEtoRE.add(leftEdge); 
      tempECLEtoRE.add(vLEtoRE);
      sControlLEtoRE = tempSCLEtoRE.get();
      eControlLEtoRE = tempECLEtoRE.get();

      leftEdge.mult(1.2);
      rightEdge.mult(1.2);

      stroke(0);
      strokeWeight(1);   
      fill(pColor);
      beginShape();
      vertex(leftEdge.x, leftEdge.y);
      bezierVertex(sControlLEtoRE.x, sControlLEtoRE.y, eControlLEtoRE.x, eControlLEtoRE.y, rightEdge.x, rightEdge.y);
      vertex(width, 0);
      vertex(width, height);
      vertex(0, height);
      endShape(CLOSE);

      Back b = backs.get(_pageN);
      b.display();
      
      if ((aniMouse.x <= 0) || (aniMouse.y <= 0)) {
        animationStay = false;
        println("stay");
      }
    } 
    else {
      fill(pColor);
      rect(0, 0, width, height);
    }
  }

  //================== goToTheNextPage() ==================  
  void goToTheNextPage(int _pageN) {
    if (_pageN == pages.size() - 2) {
      float ly;
      float rx;
      
      aniMouse.add(aniMouseOffSet);
      PVector vMouse = aniMouse;
//      println(aniMouse.x);
      
      PVector xAxis = new PVector(1, 0);
      float vMouseMag = vMouse.mag();
      float vMouseAng = PVector.angleBetween(xAxis, vMouse);
      ly = vMouseMag/(2*sqrt(1 - cos(vMouseAng)));
      rx = vMouseMag/(2*sqrt(1 - sin(vMouseAng)));

      leftEdge.set(0, ly);
      rightEdge.set(rx, 0);
      PVector tempSCLEtoRE = new PVector(0, 0);
      PVector tempECLEtoRE = new PVector(0, 0);      
      PVector vLEtoRE = PVector.sub(rightEdge, leftEdge);
      vLEtoRE.div(4);
      tempSCLEtoRE.add(leftEdge);
      tempSCLEtoRE.add(vLEtoRE);
      vLEtoRE.mult(3);
      tempECLEtoRE.add(leftEdge); 
      tempECLEtoRE.add(vLEtoRE);
      sControlLEtoRE = tempSCLEtoRE.get();
      eControlLEtoRE = tempECLEtoRE.get();

      leftEdge.mult(1.2);
      rightEdge.mult(1.2);

      stroke(0);
      strokeWeight(1);   
      fill(pColor);
      beginShape();
      vertex(leftEdge.x, leftEdge.y);
      bezierVertex(sControlLEtoRE.x, sControlLEtoRE.y, eControlLEtoRE.x, eControlLEtoRE.y, rightEdge.x, rightEdge.y);
      vertex(width, 0);
      vertex(width, height);
      vertex(0, height);
      endShape(CLOSE);

      Back b = backs.get(_pageN);
      b.display();
      
      if ((aniMouse.x >= width) || (aniMouse.y >= height)) {
        println("next");
        pages.add(new Page());
        sound.rewind();
        sound.play();
        animationNext = false;
      }
    } 
    else {
      fill(pColor);
      rect(0, 0, width, height);
    }
  }
    
  //================== setAniMouse() ==================
  void setAniMouse() {
    aniMouse.set(mouseX, mouseY);
    aniMouseOffSet = PVector.mult(aniMouse, 0.1);
  }
}

