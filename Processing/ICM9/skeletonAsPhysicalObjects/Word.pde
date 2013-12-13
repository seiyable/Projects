class Word {
//================== class-in variables ==================
  ArrayList<FChar> fchars = new ArrayList<FChar>();
  FCompound fword = new FCompound();
  float totalWidth = 0;

//================== constructor ==================
  Word(String _str) {    
    for (int i = 0; i < _str.length(); i++) {
      char c = _str.charAt(i);
      FChar fchr = new FChar(c);
      textSize(80);
      float cWidth = textWidth(c);

      /* ---------------------
       if (fchr.bodyCreated()) {
       fchr.setPosition(cWidth + gap*i, height/4);
       fword.addBody(fchr);
       }
       --------------------- */

      if (fchr.bodyCreated()) {
        fchr.setPosition(totalWidth, height/4);
        world.add(fchr);
      }
      totalWidth += cWidth;
    }
    //   world.add(fword);
  }
}

