//================= global variables =================
var walkers = []; // walker objects
var wIniNum = 50; // initial numbers of walkers
var wSize = 10; // size of the walker

// one of these color palettes will be used in a sketch
// thanks to this article -> https://designschool.canva.com/blog/100-color-combinations/
var colorPalettes = [
  ["#f98866", "#ff420e", "#80bd9e", "#89da59"],
  ["#90afc5", "#336b87", "#2a3132", "#763626"],
  ["#46211a", "#693d3d", "#ba5536", "#a43820"],
  ["#505160", "#68829e", "#aebd38", "#598234"],
  ["#003b46", "#07575b", "#66a5ad", "#c4dfe6"],
  ["#2e4600", "#486b00", "#a2c523", "#7d4427"],
  ["#021c1e", "#004445", "#2c7873", "#6fb98f"],
  ["#375e97", "#fb6542", "#ffbb00", "#3f681c"],
  ["#98dbc6", "#5bc8ac", "#e6d72a", "#f18d9e"],
  ["#324851", "#86ac41", "#34675c", "#7da3a1"]
];
var palette; // applied palette

//================= setup() =================
function setup() {
  createCanvas(window.innerWidth, window.innerHeight); // create a canvas
  palette = getColorPalette(); // get a color palette for this sketch
  
  // generate walker objects and add them to an array
  for(var i = 0; i < wIniNum; i++){
    var x = getGridPos(random(width)); // get x pos
    var y = getGridPos(random(height)); // get y pos
    walkers.push(new Walker(x, y, palette)); // generate and add to the array
  }
  
  background(255); // make background white
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
  var x = getGridPos(mouseX); // get x pos
  var y = getGridPos(mouseY); // get y pos
  walkers.push(new Walker(x, y, palette)); // generate and add to the array
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

//================= getColorPalette() =================
// get a color pallete randomly
function getColorPalette(){
  var choice = floor(random(colorPalettes.length));
  return colorPalettes[choice];
}