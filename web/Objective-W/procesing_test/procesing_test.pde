ArrayList<Window> windows;

void setup() {
  size(600, 400);
  colorMode(HSB, 255, 255, 255);
  windows = new ArrayList<Window>();

  String name = "hello";
  float lx = 100;
  float ly = 200;
  windows.add(new Window(name, lx, ly));
}

void draw() {
  background(100);

  for (int i = 0; i < windows.size(); i++) {
    Window w = windows.get(i);
    w.display();
  }

  for (int i = 0; i < windows.size(); i++) {
    Window w = windows.get(i);
    w.update();
  }

  for (int i = 0; i < windows.size(); i++) {
    Window w = windows.get(i);
    w.bounceByEdges();
  }
}


