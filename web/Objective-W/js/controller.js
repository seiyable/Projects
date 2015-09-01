// =========== global variables ===========
var windows = [];
var running = false;

// =========== setup() ===========
function setup() {
  var canvas = createCanvas(900, 900);
  canvas.position(0, 400);

  // var name = "hello";
  // var lx = 100;
  // var ly = 200;
  // windows.push(new SubWindow(name, lx, ly));
}

// =========== draw() ===========
function draw() {
  background(100);

  for (var i = 0; i < windows.length; i++) {
    windows[i].display();
  }

  if (running == true) {
    for (var i = 0; i < windows.length; i++) {
      windows[i].update();
    }

    for (var i = 0; i < windows.length; i++) {
      windows[i].bounceByEdges();
    }

    for (var i = 0; i < windows.length; i++) {
      windows[i].conditional();
    }

  }
}


// =========== addNewWindow() ===========
function addNewWindow(_name, _lx, _ly){
  var name = _name;
  var lx = _lx;
  var ly = _ly;
  windows.push(new SubWindow(name, lx, ly));
}

// =========== removeWindow() ===========
function removeWindow(_name){
  var name = _name;
  var removeIndex = -1;
  for (var i = 0; i < windows.length; i++) {
    if (windows[i].name == _name) {
      removeIndex = i;
    }
  }
  if (removeIndex != -1){
    windows.splice(removeIndex,1);
  }
}

// =========== run() ===========
function run(){
  running = true;
}

// =========== stop() ===========
function stop(){
  running = false;
}


// =========== getValues() ===========
function getValues(_name) {
  var values = [];
  for (var i = 0; i < windows.length; i++) {
    if (windows[i].name == _name) {
       values.push(windows[i].location.x);
       values.push(windows[i].location.y);
       values.push(windows[i].wWidth);
       values.push(windows[i].wHeight);
       values.push(windows[i].bgH);
       values.push(windows[i].bgS);
       values.push(windows[i].bgB);
    }
  }
  return values;
}

// =========== setValue() ===========
function setValue(_name, _key, _value) {
    for (var i = 0; i < windows.length; i++) {
    if (windows[i].name == _name) {
      if (_key === "lx") windows[i].location.x = _value;
      else if (_key === "ly") windows[i].location.y = _value;
      else if (_key === "vx") windows[i].velocity.x = _value;
      else if (_key === "vy") windows[i].velocity.y = _value;
      else if (_key === "h") windows[i].bgH = _value;
      else if (_key === "s") windows[i].bgS = _value;
      else if (_key === "v") windows[i].bgB = _value;
      else if (_key === "width") windows[i].wWidth = _value;
      else if (_key === "height") windows[i].wHeight = _value;
    }
  }
}

// =========== setConditional() ===========
function setConditional(_name, _key, _operator, _value, _key2, _value2) {
    for (var i = 0; i < windows.length; i++) {
    if (windows[i].name == _name) {
      if (_key === "lx") windows[i].ifKey = "location";
      else if (_key === "ly") windows[i].ifKey = "location";
      else if (_key === "vx") windows[i].ifKey = "velocity";
      else if (_key === "vy") windows[i].ifKey = "velocity";
      else if (_key === "h") windows[i].ifKey = "bgH";
      else if (_key === "s") windows[i].ifKey = "bgS";
      else if (_key === "v") windows[i].ifKey = "bgB";
      windows[i].operator = _operator;
      windows[i].ifValue = _value;

      if (_key2 === "lx") windows[i].thenKey = "location";
      else if (_key2 === "ly") windows[i].thenKey = "location";
      else if (_key2 === "vx") windows[i].thenKey = "velocity";
      else if (_key2 === "vy") windows[i].thenKey = "velocity";
      else if (_key2 === "h") windows[i].thenKey = "bgH";
      else if (_key2 === "s") windows[i].thenKey = "bgS";
      else if (_key2 === "v") windows[i].thenKey = "bgB";
      windows[i].thenValue = _value2;
    }
  }
}

