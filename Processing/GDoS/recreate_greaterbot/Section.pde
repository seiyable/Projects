class Section {
  // =========================== in-class valuables ===========================
  int changePosition;
  int sectionHeight;
  float r, g, b;
  int rFuncCoef;
  int gFuncCoef;
  int bFuncCoef;
    
  // =========================== constructor ===========================  
  Section(int _changePosition) {
    changePosition = _changePosition;
    rFuncCoef = (int) random(10, 30);
    gFuncCoef = (int) random(5, 50);
    bFuncCoef = (int) random(50, 100);

  }

  // =========================== getHeight() ===========================    
  void getHeight(int _sectionHeight){
    sectionHeight = _sectionHeight;
  }
  
  // =========================== getColor() ===========================    
  void getColor(){
    r = log(changePosition/rFuncCoef);
    r = map(r, 0, log(640/rFuncCoef), 0, 255);
    g = log(changePosition/gFuncCoef);
    g = map(g, 0, log(640/gFuncCoef), 0, 200);    
    b = log(changePosition/bFuncCoef);
    b = map(b, 0, log(640/bFuncCoef), 0, 100);
  }
  
  // =========================== display() ===========================  
  void display(int _stripX) {
    fill(r, g, b);
    rect(_stripX, changePosition, 5, sectionHeight);
  }
}

