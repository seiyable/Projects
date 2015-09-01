function SubWindow(_name, _lx, _ly) {
  // =========== in-class variables ===========
  this.name = _name;

  this.location = new PVector(_lx, _ly);
  this.velocity = new PVector(5, 2);
  this.acceleration = new PVector(0, 0);

  this.wWidth = 200, this.wHeight = 180;

  this.bgH = 0, this.bgS = 80, this.bgB = 100;

  this.ifKey = null;
  this.operator = null;
  this.ifValue = null;
  this.thenKey = null;
  this.thenValue = null;
}

SubWindow.prototype = {
  display : function() {
    var color = tinycolor({h : this.bgH, s : this.bgS, v : this.bgB});

    rect(this.location.x, this.location.y, this.wWidth, this.wHeight);
    window.opener.moveSub(this.name, this.location.x, this.location.y);
    window.opener.resizeSub(this.name, this.wWidth, this.wHeight);
    window.opener.changeColSub(this.name, color.toHexString());
  },

  update : function() {
    this.velocity.add(this.acceleration);
    this.location.add(this.velocity);
  },

  bounceByOthers : function() {
  },

  bounceByEdges : function() {
    if (this.location.x < 0 || this.location.x + this.wWidth > width) {
      this.velocity.x = -this.velocity.x;
    }
    if (this.location.y < 20 || this.location.y + this.wHeight > height) {
      this.velocity.y = -this.velocity.y; 
    }
  },

  conditional : function(){
    if (this.operator != null){
      switch(this.operator){
        case ">":
        if(this[this.ifKey].x > this.ifValue) {
            this[this.thenKey] = this.thenValue;
        }
            break;
        case ">=":
        if(this[this.ifKey] >= this.ifValue) {
            this[this.thenKey] = this.thenValue;
        }
            break;
        case "==":
        if(this[this.ifKey] == this.ifValue) {
            this[this.thenKey] = this.thenValue;
        }
            break;
        case "<":
        if(this[this.ifKey].x < this.ifValue) {
            this[this.thenKey] = this.thenValue;
        }
            break;
        case "<=":
        if(this[this.ifKey] <= this.ifValue) {
            this[this.thenKey] = this.thenValue;
        }
            break;

      }
    }
  }

}
