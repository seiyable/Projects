class Eyeball {
  PVector location;
  PVector mouse;
  PVector base;
  PShape eyeball;
  PShape eye;

  Eyeball(int _x, int _y) {
    location = new PVector(_x, _y);
    mouse = new PVector(0, 0);
    base = new PVector(0, -eyeballWidth/2);
    eyeball = createShape(ELLIPSE, 0, 0, eyeballWidth, eyeballWidth);
    eyeball.setFill(color(360));
    eye = createShape(ELLIPSE, 0, -eyeballWidth/4, eyeballWidth/2, eyeballWidth/2);
    eye.setFill(color(0));
  }

  void display() {
    mouse.set(mouseX - location.x, mouseY - location.y);
    pushMatrix();
    translate(location.x, location.y);
    float angle = PVector.angleBetween(base, mouse);
    if (mouseX - location.x >= 0) {    
      rotate(angle);
    } 
    else {
      rotate(-angle);
    }
    shape(eyeball);
    shape(eye);
    popMatrix();
  }
}

