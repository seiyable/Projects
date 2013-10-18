class Tree {
  //=================== in-class valuables ===================
  PVector location;
  ArrayList<Branch> branchesOfThisTree;
  float scale;

  //=================== constructor ===================
  Tree(PVector _location, ArrayList<Branch> _branchesOfThisTree, float _scale) {
    location = _location;
    branchesOfThisTree = _branchesOfThisTree;
    scale = _scale;
  }

  //=================== display() ===================
  void display() {
    for (Branch i : branchesOfThisTree) {
      pushMatrix();
      translate(location.x, location.y);
      scale(scale);
      i.display();
      popMatrix();
    }
  }

  //=================== getLocation() ===================
   float getYLocation() {
     return location.y;
  }
}

