class Back {
  //================== in-class valuables ================== 
  color bColor;
  PVector leftEdge = new PVector(0, 0);
  PVector sControlLEtoRE = new PVector(0, 0);
  PVector eControlLEtoRE = new PVector(0, 0);
  PVector rightEdge = new PVector(0, 0);
  PVector corner = new PVector(0, 0);
  PVector sControlCtoLE = new PVector(0, 0);
  PVector eControlCtoLE = new PVector(0, 0);
  PVector sControlREtoC = new PVector(0, 0);
  PVector eControlREtoC = new PVector(0, 0);

  //================== constructor ==================
  Back(int _hue) {
    int hue = _hue;
    bColor = color(hue, 50, 50);
  }

  //================== display() ==================
  void display() {
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

    corner = vMouse.get();
    PVector tempSCREtoC = new PVector(0, 0);
    PVector tempECREtoC = new PVector(0, 0);
    PVector vREtoC = PVector.sub(corner, rightEdge);
    vREtoC.div(4);
    tempSCREtoC.add(rightEdge);
    tempSCREtoC.add(vREtoC);
    vREtoC.mult(3);
    tempECREtoC.add(rightEdge);
    tempECREtoC.add(vREtoC);
    sControlREtoC = tempSCREtoC.get();
    eControlREtoC = tempECREtoC.get();

    PVector tempSCLEtoC = new PVector(0, 0);
    PVector tempECLEtoC = new PVector(0, 0);
    PVector vLEtoC = PVector.sub(corner, leftEdge);
    vLEtoC.div(4);
    tempECLEtoC.add(leftEdge);
    tempECLEtoC.add(vLEtoC);
    vLEtoC.mult(3);
    tempSCLEtoC.add(leftEdge);
    tempSCLEtoC.add(vLEtoC);
    eControlCtoLE = tempSCLEtoC.get();
    sControlCtoLE = tempECLEtoC.get();

    leftEdge.mult(1.2);
    rightEdge.mult(1.2);

    stroke(0);
    strokeWeight(1);   
    fill(bColor);
    beginShape();
    vertex(leftEdge.x, leftEdge.y);
    bezierVertex(sControlLEtoRE.x, sControlLEtoRE.y, eControlLEtoRE.x, eControlLEtoRE.y, rightEdge.x, rightEdge.y);
    bezierVertex(sControlREtoC.x, sControlREtoC.y, eControlREtoC.x, eControlREtoC.y, corner.x, corner.y);
    bezierVertex(eControlCtoLE.x, eControlCtoLE.y, sControlCtoLE.x, sControlCtoLE.y, leftEdge.x, leftEdge.y);
    endShape(CLOSE);

    stroke(5);
    point(sControlLEtoRE.x, sControlLEtoRE.y);
    point(eControlLEtoRE.x, eControlLEtoRE.y);
  }
}

