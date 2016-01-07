// walker class
function Walker(_x, _y, _palette){
  //================= properties =================
  this.x = _x; // x pos
  this.y = _y; // y pos
  this.palette = _palette; // color palette
  this.c; // current color
  
  //================= display() =================
  // display
  this.display = function(){
    stroke(c); // set stroke color
    strokeWeight(10); // set stroke weight
    point(this.x, this.y); // draw a point
  }
  
  //================= step() =================
  // step to a direction that is randomly chosen
  this.step = function() {
    var choice = floor(random(4)); // 0 or 1 or 2 or 3
    var stepSize = wSize; // step size equals to walker's size
  
    switch(choice){
      case 0:
        this.x += stepSize; // step to right
        c = color(this.palette[0]);
        break;
      case 1:
        this.x -= stepSize; // step to left
        c = color(this.palette[1]);
        break;
      case 2:
        this.y += stepSize; // step to up
        c = color(this.palette[2]);
        break;
      case 3:
        this.y -= stepSize; // step to down
        c = color(this.palette[3]);
        break;
    }
  }
}