class UserLine {
  //================== class-in variables ==================
  HashMap<String, FLine> flines = new HashMap<String, FLine>();
  HashMap<String, PVector> flvelos = new HashMap<String, PVector>();
  color fillcolor;

  //================== constructor ==================    
  UserLine(color _fillcolor) {
    fillcolor = _fillcolor;

    flines.put("head2neck", new FLine(0, 0, 0, 0));
    flines.put("neck2ls", new FLine(0, 0, 0, 0));
    flines.put("neck2rs", new FLine(0, 0, 0, 0));
    flines.put("ls2le", new FLine(0, 0, 0, 0));
    flines.put("rs2re", new FLine(0, 0, 0, 0));
    flines.put("le2lha", new FLine(0, 0, 0, 0));
    flines.put("re2rha", new FLine(0, 0, 0, 0));
    flines.put("ls2torso", new FLine(0, 0, 0, 0));
    flines.put("rs2torso", new FLine(0, 0, 0, 0));
    flines.put("torso2lhi", new FLine(0, 0, 0, 0));
    flines.put("torso2rhi", new FLine(0, 0, 0, 0));
    flines.put("lhi2lk", new FLine(0, 0, 0, 0));
    flines.put("rhi2rk", new FLine(0, 0, 0, 0));
    flines.put("lk2lf", new FLine(0, 0, 0, 0));
    flines.put("rk2rf", new FLine(0, 0, 0, 0));

    for (Map.Entry me : flines.entrySet()) {
      FLine fl = (FLine) me.getValue();
      fl.setStrokeColor(fillcolor);
      fl.setStrokeWeight(30);
      fl.setFillColor(fillcolor);
      fl.setDrawable(false);
      world.add(fl);
    }

    flvelos.put("head2neck", new PVector(0, 0));
    flvelos.put("neck2ls", new PVector(0, 0));
    flvelos.put("neck2rs", new PVector(0, 0));
    flvelos.put("ls2le", new PVector(0, 0));
    flvelos.put("rs2re", new PVector(0, 0));
    flvelos.put("le2lha", new PVector(0, 0));
    flvelos.put("re2rha", new PVector(0, 0));
    flvelos.put("ls2torso", new PVector(0, 0));
    flvelos.put("rs2torso", new PVector(0, 0));
    flvelos.put("torso2lhi", new PVector(0, 0));
    flvelos.put("torso2rhi", new PVector(0, 0));
    flvelos.put("lhi2lk", new PVector(0, 0));
    flvelos.put("rhi2rk", new PVector(0, 0));
    flvelos.put("lk2lf", new PVector(0, 0));
    flvelos.put("rk2rf", new PVector(0, 0));
  }

  //================== setPos_head2neck() ==================
  void setPos_head2neck(PVector _headPos2d, PVector _neckPos2d) {
    FLine fl = flines.get("head2neck");
    PVector prepos = new PVector(fl.getX(), fl.getX());
    fl.setStart(_headPos2d.x, _headPos2d.y);
    fl.setEnd(_neckPos2d.x, _neckPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("head2neck").set(PVector.sub(curpos, prepos));
  }

  //================== setPos_neck2ls() ==================
  void setPos_neck2ls(PVector _neckPos2d, PVector _leftShoulderPos2d) {
    FLine fl = flines.get("neck2ls");
    PVector prepos = new PVector(fl.getX(), fl.getX());
    fl.setStart(_neckPos2d.x, _neckPos2d.y);
    fl.setEnd(_leftShoulderPos2d.x, _leftShoulderPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("neck2ls").set(PVector.sub(curpos, prepos));
  }

  //================== setPos_neck2rs() ==================
  void setPos_neck2rs(PVector _neckPos2d, PVector _rightShoulderPos2d) {
    FLine fl = flines.get("neck2rs");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_neckPos2d.x, _neckPos2d.y);
    fl.setEnd(_rightShoulderPos2d.x, _rightShoulderPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("neck2rs").set(PVector.sub(curpos, prepos));
  }

  //================== setPos_ls2le() ==================
  void setPos_ls2le(PVector _leftShoulderPos2d, PVector _leftElbowPos2d) {
    FLine fl = flines.get("ls2le");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_leftShoulderPos2d.x, _leftShoulderPos2d.y);
    fl.setEnd(_leftElbowPos2d.x, _leftElbowPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("ls2le").set(PVector.sub(curpos, prepos));
  }

  //================== setPos_rs2re() ==================
  void setPos_rs2re(PVector _rightShoulderPos2d, PVector _rightElbowPos2d) {
    FLine fl = flines.get("rs2re");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_rightShoulderPos2d.x, _rightShoulderPos2d.y);
    fl.setEnd(_rightElbowPos2d.x, _rightElbowPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("rs2re").set(PVector.sub(curpos, prepos));
  }

  //================== setPos_le2lha() ==================
  void setPos_le2lha(PVector _leftElbowPos2d, PVector _leftHandPos2d) {
    FLine fl = flines.get("le2lha");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_leftElbowPos2d.x, _leftElbowPos2d.y);
    fl.setEnd(_leftHandPos2d.x, _leftHandPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("le2lha").set(PVector.sub(curpos, prepos));
  }  

  //================== setPos_re2rha() ==================
  void setPos_re2rha(PVector _rightElbowPos2d, PVector _rightHandPos2d) {
    FLine fl = flines.get("re2rha");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_rightElbowPos2d.x, _rightElbowPos2d.y);
    fl.setEnd(_rightHandPos2d.x, _rightHandPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("re2rha").set(PVector.sub(curpos, prepos));
  }  

  //================== setPos_ls2torso() ==================
  void setPos_ls2torso(PVector _leftShoulderPos2d, PVector _torsoPos2d) {
    FLine fl = flines.get("ls2torso");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_leftShoulderPos2d.x, _leftShoulderPos2d.y);
    fl.setEnd(_torsoPos2d.x, _torsoPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("ls2torso").set(PVector.sub(curpos, prepos));
  }  

  //================== setPos_rs2torso() ==================
  void setPos_rs2torso(PVector _rightShoulderPos2d, PVector _torsoPos2d) {
    FLine fl = flines.get("rs2torso");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_rightShoulderPos2d.x, _rightShoulderPos2d.y);
    fl.setEnd(_torsoPos2d.x, _torsoPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("rs2torso").set(PVector.sub(curpos, prepos));    
  }  

  //================== setPos_torso2lhi() ==================
  void setPos_torso2lhi(PVector _torsoPos2d, PVector _leftHipPos2d) {
    FLine fl = flines.get("torso2lhi");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_torsoPos2d.x, _torsoPos2d.y);
    fl.setEnd(_leftHipPos2d.x, _leftHipPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("torso2lhi").set(PVector.sub(curpos, prepos));    
  }  

  //================== setPos_torso2rhi() ==================
  void setPos_torso2rhi(PVector _torsoPos2d, PVector _rightHipPos2d) {
    FLine fl = flines.get("torso2rhi");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_torsoPos2d.x, _torsoPos2d.y);
    fl.setEnd(_rightHipPos2d.x, _rightHipPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("torso2rhi").set(PVector.sub(curpos, prepos));    
  }  

  //================== setPos_lhi2lk() ==================
  void setPos_lhi2lk(PVector _leftHipPos2d, PVector _leftKneePos2d) {
    FLine fl = flines.get("lhi2lk");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_leftHipPos2d.x, _leftHipPos2d.y);
    fl.setEnd(_leftKneePos2d.x, _leftKneePos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("lhi2lk").set(PVector.sub(curpos, prepos));    
  }  

  //================== setPos_rhi2rk() ==================
  void setPos_rhi2rk(PVector _rightHipPos2d, PVector _rightKneePos2d) {
    FLine fl = flines.get("rhi2rk");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_rightHipPos2d.x, _rightHipPos2d.y);
    fl.setEnd(_rightKneePos2d.x, _rightKneePos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("rhi2rk").set(PVector.sub(curpos, prepos));        
  }  

  //================== setPos_lk2lf() ==================
  void setPos_lk2lf(PVector _leftKneePos2d, PVector _leftFootPos2d) {
    FLine fl = flines.get("lk2lf");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_leftKneePos2d.x, _leftKneePos2d.y);
    fl.setEnd(_leftFootPos2d.x, _leftFootPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("lk2lf").set(PVector.sub(curpos, prepos));        
  }  

  //================== setPos_rk2rf() ==================
  void setPos_rk2rf(PVector _rightKneePos2d, PVector _rightFootPos2d) {
    FLine fl = flines.get("rk2rf");
    PVector prepos = new PVector(fl.getX(), fl.getX());    
    fl.setStart(_rightKneePos2d.x, _rightKneePos2d.y);
    fl.setEnd(_rightFootPos2d.x, _rightFootPos2d.y);
    PVector curpos = new PVector(fl.getX(), fl.getX());
    flvelos.get("rk2rf").set(PVector.sub(curpos, prepos));        
  }
  //================== setPos_rk2rf() ==================
  PVector checkContact(FLine _human) {
    for (Map.Entry me : flines.entrySet()) {
      FLine fl = (FLine) me.getValue();
      String keystr = (String) me.getKey();
      if (fl == _human) {
        PVector speed = flvelos.get(keystr);
        return speed;
      }
    }
    return null;
  }
}

