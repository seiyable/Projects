//for managing state of each key
class Key {
  //================ in-class variables ================
  String name;
  char key;
  int keyCode;
  boolean isPressed;

  //================ constructor ================
  Key(String _name, char _key, int _keyCode) {
    name = _name;
    key = _key;
    keyCode = _keyCode;
    isPressed = false;
  }

  //================ equals() ================
  boolean equals(char tempKey, int tempKeyCode) {
    if (tempKey != CODED) {
      if (key == tempKey) {
        return true;
      } else {
        return false;
      }
    } else {
      if (keyCode == tempKeyCode) {
        return true;
      } else {
        return false;
      }
    }
  }

  //================ pressed() ================
  void pressed(char tempKey, int tempKeyCode) {
    if (equals(tempKey, tempKeyCode) == true) {
      isPressed = true;
    }
  }

  //================ released() ================
  void released(char tempKey, int tempKeyCode) {
    if (equals(tempKey, tempKeyCode) == true) {
      isPressed = false;
    }
  }
}

