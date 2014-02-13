class Strip {
  // =========================== in-class valuables ===========================
  int numberOfChangeColors;
  int[] changePositions;
  Section[] sections;

  // =========================== constructor ===========================  
  Strip() {
    numberOfChangeColors = (int) random(12, 18);
    changePositions = new int[numberOfChangeColors];
    getChangePositions();

    sections = new Section[numberOfChangeColors];    
    for(int i = 0; i < numberOfChangeColors; i++){
      sections[i] = new Section(changePositions[i]);      
    }

    getHeightOfEachSection();    
    getColorOfEachSection();
  }

  // =========================== getChangePositions() ===========================  
  void getChangePositions() {
    int[] temp_positions = new int[numberOfChangeColors];

    for (int i = 0; i < numberOfChangeColors; i++) {
      //pick one number within the range of height
      //if there is a number that has same value in the temp_positions array,
      //try picking number again
      boolean goNext = false;
      while(goNext == false) {
        float x = random(0, 1);
        if (x < 0.5) {
          temp_positions[i] = (int) random(240, 420);
        } else {
        temp_positions[i] = (int) random(640);
        }
//        temp_positions[i] = (int) randomGaussian()*320;
        
        goNext = true;
        for (int j = 0; j < i; j++) {
          if (temp_positions[i] == temp_positions[j]) {
            goNext = false;
          }
        }
        if (temp_positions[i] < 0 || temp_positions[i] > 640){
          goNext = false;
        }
      }
    }
    
    //sort the values in the array
    temp_positions = sort(temp_positions);
    
    //replace the array into changePositions array
    changePositions = temp_positions;
  }

  // =========================== getHeightOfEachSection() ===========================  
  void getHeightOfEachSection() {
    for(int i = 0; i < sections.length; i++) {
      int sectionHeight;
      if(i == sections.length - 1) {
        sectionHeight = height - changePositions[i];
      } else {
        sectionHeight = changePositions[i+1] - changePositions[i];
      }
      sections[i].getHeight(sectionHeight);
    }
  }
  
  // =========================== getColorOfEachSection() ===========================  
  void getColorOfEachSection() {
    for(int i = 0; i < sections.length; i++) {
      sections[i].getColor();
    }
  }
  // =========================== display() ===========================
  void display(int _stripX) {
    for(int i = 0; i < sections.length; i++) {
      sections[i].display(_stripX);
    }
  }
}

