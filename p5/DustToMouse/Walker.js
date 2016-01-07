// walker class
function Walker(_x, _y){
  //================= properties =================
  this.x = _x; // x pos
  this.y = _y; // y pos
  this.c = color(random(255), random(255), random(255)); // current color
  
  //================= display() =================
  // display
  this.display = function(){
    stroke(this.c); // set stroke color
    strokeWeight(2); // set stroke weight
    point(this.x, this.y); // draw a point
  }
  
  //================= step() =================
  // step to a direction that is randomly chosen
  this.step = function() {
    var stepSize = wSize; // step size equals to walker's size
    var m = 14.0;
    var p = random(1);
    if(p < 1.0/m){
      // step to up
      this.y += stepSize;
      
    } else if (p < 2.0/m){
      // step to up right
      this.x += stepSize;
      this.y += stepSize;
      
    } else if (p < 3.0/m){
      // step to right
      this.x += stepSize;
      
    } else if (p < 4.0/m){
      // step to down right
      this.x += stepSize;
      this.y -= stepSize;
      
    } else if (p < 5.0/m){
      // step to down
      this.y -= stepSize;
      
    } else if (p < 6.0/m){
      // step to down left
      this.x -= stepSize;
      this.y -= stepSize;
      
    } else if (p < 7.0/m){
      // step to left
      this.x -= stepSize;
      
    } else if (p < 8.0/m){
      // step to up left
      this.x -= stepSize;
      this.y += stepSize;
      
    } else {
      // step to mouse position
      if (this.x < mouseX){
        this.x += stepSize;
      } else if (this.x > mouseX){
        this.x -= stepSize;
      }
      if (this.y < mouseY){
        this.y += stepSize;
      } else if (this.y > mouseY){
        this.y -= stepSize;
      }
    }
  }
}