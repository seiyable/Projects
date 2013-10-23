class Background {
  //================ in-class variables ================
  color bgColor = #ABE7FF;
  PImage depthImage;
  PImage rgbImage;
  int cellSize = 10;
  int cols, rows;
  PFont myFont;

  //================ constructor ================
  Background() {
    cols = width/cellSize;
    rows = height/cellSize;
    myFont = createFont("Charcoal CY", 24);
    textFont(myFont);
  }
  
  //================ display() ================
  void display() {
    background(bgColor);
    
    if (captureMode == true) {
      fill(0);
      textSize(24);
      text("Press", 10, 30);
      fill(0, 100, 100);
      text("Start Button(or 'Space' Key)", 80, 30);
      fill(0);
      text("to go to play mode!", 10, 55);
      
    } else if (captureMode == false) {
      fill(0);
      textSize(24);
      text("Press", 10, 30);
      fill(120, 100, 100);
      text("Select Button(or 'q' Key)", 80, 30);
      fill(0);
      text("to go back to capture mode!", 10, 55);
    } 
  }

  //================ getPixelsWithin() ================
  void getPixelsWithin(float _depth) {
    kinect.update();
    depthImage = kinect.depthImage();
    rgbImage = kinect.rgbImage();

    int[] depthValues = kinect.depthMap();
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        int a = depthValues[i + j*width];
        if ((a > _depth*1000) || (a == 0)) {
          rgbImage.pixels[i + j*width] = color(0, 0, 0, 0);
        }
      }
    }
  }

  //================ generateBlocks() ================
  void generateBlocks() {
    ArrayList<Block> nextBlocks = new ArrayList<Block>();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {

        int x = i*cellSize;
        int y = j*cellSize;
        int loc = x + y*rgbImage.width; // Reversing x to mirror the image

        float h = hue(rgbImage.pixels[loc]);
        float s = saturation(rgbImage.pixels[loc]);
        float b = brightness(rgbImage.pixels[loc]);
        float alpha = alpha(rgbImage.pixels[loc]);
        color c = color(h, s, b, alpha);

        if (alpha != 0) {
          float worldRecord = 1000;
          float [] d = new float[famiColors.length];
          for (int k = 0; k < famiColors.length; k++) {
            float hk = hue(famiColors[k]);
            float sk = saturation(famiColors[k]);
            float bk = brightness(famiColors[k]);  
            d[k] = dist(hk, sk, bk, h, s, b);

            if (d[k] < worldRecord) {
              worldRecord = d[k];
              c = color(hk, sk, bk);
            }
          }
          PVector bLocation = new PVector(x+cellSize/2, y+cellSize/2);
          nextBlocks.add(new Block(bLocation, cellSize, c));         
        }
      }
    }
    blocks = nextBlocks;
  }
}

