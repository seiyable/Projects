//================ global variables ================
ArrayList<FlyingDatum> fData = new ArrayList<FlyingDatum>();
String[] filenames = {
  "2013103072039.csv",
  "2013103063137.csv", 
  "2013103063417.csv", 
  //  "filename4", 
  //  "filename5",
};

//================ setup() ================
void setup() {
  size(800, 600);
  smooth();
  loadData();
}

//================ draw() ================
void draw() {
  displayBackground();
  
  for(FlyingDatum f : fData){
    f.drawXAxisCurve();
    f.drawYAxisCurve();
    f.drawZAxisCurve();
  }
}

//================ displayBackground() ================
void displayBackground(){
  background(80);
  
  pushMatrix();
  translate(0, height/3);
  stroke(255);
  line(0 , 0, width, 0);
  text("xAxis", 20, -height/3 + 20);
  popMatrix();
  
  pushMatrix();
  translate(0, height*2/3);
  stroke(255);
  line(0 , 0, width, 0);
  text("yAxis", 20, -height/3 + 20);
  popMatrix();

  pushMatrix();
  translate(0, height);  
  text("zAxis", 20, -height/3 + 20);
  popMatrix();  
}

//================ loadData() ================
void loadData() {
  for (int i = 0; i < filenames.length; i++) {
    Table table = loadTable(filenames[i], "header");
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
   fData.add(new FlyingDatum(xAxisData, yAxisData, zAxisData));
  }
}

