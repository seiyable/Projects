class Block {
  //================ in-class variables ================
  PVector location;
  float blockWidth;
  color bColor;

  //================ constructor ================  
  Block(PVector _location, float _blockWidth, color _bColor) {
    location = _location.get();
    blockWidth = _blockWidth;
    bColor = _bColor;
    rectMode(CENTER);
  }

  //================ display() ================
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rectMode(CENTER);
    fill(bColor);
    rect(0, 0, blockWidth, blockWidth);
    popMatrix();
  }
  
  //================ getLocation() ================
  PVector getLocation() {
    return location;
  }
  
  //================ getBlockWidth() ================
  float getBlockWidth() {
    return blockWidth;
  }
}

