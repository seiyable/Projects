//================ global variables ================
AxcelData aData; //storing x,y,z axis values
String filename = "201511101621.csv"; //the CSV file that you want to load

//selected values of x,y,z charts based on your mouse position
float xValue = 0, yValue = 0, zValue = 0;

//================ setup() ================
void setup() {
  size(1200, 600);
  smooth();
  loadData();
}

//================ draw() ================
void draw() {
  //update selected values based on your mouse position
  updateSelectedValues();
  
  //display background lines and texts
  displayBackground(); 
  
  //draw curves
  aData.drawCurves();
  
  //draw points
  aData.drawPoints(mouseX);
}

//================ updateSelectedValues() ================
void updateSelectedValues(){
  float[] values = aData.getValuesOnMouseX(mouseX);
  xValue = values[0];
  yValue = values[1];
  zValue = values[2];
}

//================ displayBackground() ================
void displayBackground(){
  background(80);
  
  //x
  pushMatrix();
  translate(0, height/3);
  stroke(255);
  line(0, 0, width, 0);
  text("xAxis", 20, -height/3 + 20);
  text(xValue, 20 + 50, -height/3 + 20); //display selected value of X axis
  popMatrix();
  
  //y
  pushMatrix();
  translate(0, height*2/3);
  stroke(255);
  line(0, 0, width, 0);
  text("yAxis", 20, -height/3 + 20);
  text(yValue, 20 + 50, -height/3 + 20); //display selected value of X axis
  popMatrix();

  //z
  pushMatrix();
  translate(0, height);  
  text("zAxis", 20, -height/3 + 20);
  text(zValue, 20 + 50, -height/3 + 20); //display selected value of X axis
  popMatrix();
  
  //mouse line
  stroke(255, 255, 0);
  line(mouseX, 0, mouseX, height);
}

//================ loadData() ================
void loadData() {
    Table table = loadTable(filename, "header");
    PVector[] xAxisData = new PVector[table.getRowCount()];
    PVector[] yAxisData = new PVector[table.getRowCount()];
    PVector[] zAxisData = new PVector[table.getRowCount()];  

    int rowCount = 0;
    for (TableRow row : table.rows()) {
      float xAxisX = row.getFloat("xAxis.x");
      float xAxisY = row.getFloat("xAxis.y");
      float yAxisX = row.getFloat("yAxis.x");
      float yAxisY = row.getFloat("yAxis.y");
      float zAxisX = row.getFloat("zAxis.x");
      float zAxisY = row.getFloat("zAxis.y");      

      xAxisData[rowCount] = new PVector(xAxisX, xAxisY);
      yAxisData[rowCount] = new PVector(yAxisX, yAxisY);
      zAxisData[rowCount] = new PVector(zAxisX, zAxisY);
      rowCount++;
    }
   aData = new AxcelData(xAxisData, yAxisData, zAxisData);
}