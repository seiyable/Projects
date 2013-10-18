class Arrow {
  PVector location;
  PVector mouse;
  PVector base;
  PShape arw;

  Arrow(int _x, int _y) {
    location = new PVector(_x, _y);
    mouse = new PVector(0, 0);
    base = new PVector(0, -arrowWidth/2);
    arw = createShape();
    arw.beginShape();
    arw.vertex(0, - arrowWidth/2);
    arw.vertex(arrowWidth/3, -arrowWidth/10);
    arw.vertex(arrowWidth/10, -arrowWidth/10);
    arw.vertex(arrowWidth/10, arrowWidth/2);
    arw.vertex(-arrowWidth/10, arrowWidth/2);
    arw.vertex(-arrowWidth/10, -arrowWidth/10);
    arw.vertex(-arrowWidth/3, -arrowWidth/10);
    arw.endShape();
  }

  void display() {
    mouse.set(mouseX - location.x, mouseY - location.y);
    pushMatrix();
    translate(location.x, location.y);
    float angle = PVector.angleBetween(base, mouse);
    if (mouseX - location.x >= 0) {    
      rotate(angle);
    } else {
      rotate(-angle);
    }
    shape(arw);
    popMatrix();
  }
}

