class FlyingDatum {
  //================ class-in variables ================
  PVector[] xAxisData, yAxisData, zAxisData;

  //================ constructor ================
  FlyingDatum(PVector[] _xAxisData, PVector[] _yAxisData, PVector[] _zAxisData) {
    xAxisData = _xAxisData;
    yAxisData = _yAxisData;
    zAxisData = _zAxisData;
  }

  //================ drawXAxisCurve() ================  
  void drawXAxisCurve() {
    for (int i = 0; i < xAxisData.length - 1; i++) {
      pushMatrix();
      translate(0, height/3);
      stroke(255, 0, 0);
      line(xAxisData[i].x, xAxisData[i].y, xAxisData[i+1].x, xAxisData[i+1].y);
      popMatrix();
    }
  }

  //================ drawYAxisCurve() ================  
  void drawYAxisCurve() {
    for (int i = 0; i < yAxisData.length - 1; i++) {
      pushMatrix();
      translate(0, height*2/3);
      stroke(0, 255, 0);
      line(yAxisData[i].x, yAxisData[i].y, yAxisData[i+1].x, yAxisData[i+1].y);
      popMatrix();
    }
  }

  //================ drawZAxisCurve() ================  
  void drawZAxisCurve() {
    for (int i = 0; i < zAxisData.length - 1; i++) {
      pushMatrix();
      translate(0, height);
      stroke(0, 0, 255);
      line(zAxisData[i].x, zAxisData[i].y, zAxisData[i+1].x, zAxisData[i+1].y);
      popMatrix();
    }
  }
}

