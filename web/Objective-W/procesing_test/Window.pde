class Window {
  String name;

  PVector location;
  PVector velocity;
  PVector acceleration;

  float wWidth = 100;
  float wHeight = 100;

  float bgH = 0, bgS = 0, bgB = 255;

  Window(String _name, float _lx, float _ly) {
    name = _name;
    location = new PVector(_lx, _ly);
    velocity = new PVector(5, 2);
    acceleration = new PVector(0, 0);
  }

  void display() {
    rect(location.x, location.y, wWidth, wHeight);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
  }

  void bounceByOthers() {
  }

  void bounceByEdges() {
    if (location.x < 0 || location.x + wWidth > width) {
      velocity.x = -velocity.x;
    }
    if (location.y < 0 || location.y + wHeight > height) {
      velocity.y = -velocity.y; 
    }
  }
}

