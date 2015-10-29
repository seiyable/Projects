class AxcelData {
  //================ class-in variables ================
  PVector[] xAxisData, yAxisData, zAxisData;

  //================ constructor ================
  AxcelData(PVector[] _xAxisData, PVector[] _yAxisData, PVector[] _zAxisData) {
    xAxisData = _xAxisData;
    yAxisData = _yAxisData;
    zAxisData = _zAxisData;
  }

  //================ drawCurves() ================  
  void drawCurves() {
    for (int i = 0; i < xAxisData.length - 1; i++) {
      //x
      pushMatrix();
      translate(0, height/3);
      stroke(255, 0, 0);
      line(xAxisData[i].x, xAxisData[i].y, xAxisData[i+1].x, xAxisData[i+1].y);
      popMatrix();
      
      //y
      pushMatrix();
      translate(0, height*2/3);
      stroke(0, 255, 0);
      line(yAxisData[i].x, yAxisData[i].y, yAxisData[i+1].x, yAxisData[i+1].y);
      popMatrix();
      
      //z
      pushMatrix();
      translate(0, height);
      stroke(0, 0, 255);
      line(zAxisData[i].x, zAxisData[i].y, zAxisData[i+1].x, zAxisData[i+1].y);
      popMatrix();
    } 
  }
  
  //================ drawPoints() ================
  void drawPoints(int _mouseX){
    strokeWeight(10);
    
    pushMatrix();
    translate(0, height/3);
    stroke(255, 0, 0);
    point(xAxisData[_mouseX].x, xAxisData[_mouseX].y);
    popMatrix();
    
    pushMatrix();
    translate(0, height*2/3);
    stroke(0, 255, 0);
    point(yAxisData[_mouseX].x, yAxisData[_mouseX].y);
    popMatrix();
    
    pushMatrix();
    translate(0, height);
    stroke(0, 0, 255);
    point(zAxisData[_mouseX].x, zAxisData[_mouseX].y);
    popMatrix();
    
    strokeWeight(1);

  }
  
  //================ getValuesOnMouseX() ================
  float[] getValuesOnMouseX(int _mouseX){
    float[] values = new float[3];
    
    values[0] = map(xAxisData[_mouseX].y, 0, -height/3, 0, 1023);
    values[1] = map(yAxisData[_mouseX].y, 0, -height/3, 0, 1023);
    values[2] = map(zAxisData[_mouseX].y, 0, -height/3, 0, 1023);
    
    return values;
  }
}