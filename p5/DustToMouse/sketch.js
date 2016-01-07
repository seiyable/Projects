//================= global variables =================
var walkers = []; // walker objects
var wSize = 4; // size of the walker

//================= setup() =================
function setup() {
  createCanvas(window.innerWidth, window.innerHeight); // create a canvas
  background(255); // make background white
  fill(200);
  textSize(24);
  textAlign(CENTER);
  text("Click Mouse!", width/2, height/2);
}

//================= draw() =================
function draw() {
  // let walkers step and show
  for(var i = 0; i < walkers.length; i++){
    var w = walkers[i];
    w.step();
    w.display();
  }
}

//================= mouseClicked() =================
// generate another walker when mouse is clicked
function mouseClicked() {
  var wAddNum = 30; // added numbers of walkers when mouse is pressed
  var r = 30;
  
  for(var i = 0; i < wAddNum; i++){
    var x = getGridPos(random(mouseX - r, mouseX + r)); // get x pos
    var y = getGridPos(random(mouseY - r, mouseY + r)); // get y pos
    walkers.push(new Walker(x, y)); // generate and add to the array
  }
}

//================= windowResized() =================
// resize the canvas to fit to the window when it is resized
function windowResized() {
  resizeCanvas(windowWidth, windowHeight); //resize the canvas
}

//================= getGridPos() =================
// get a position that fits to grid of walker's size
function getGridPos(_pos) {
  return _pos - (_pos % wSize);
}