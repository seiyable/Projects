class Music {
  //================ in-class variables ================  

  //================ constructor ================
  Music() {
  }

  //================ playBGM ================
  void playBGM(AudioPlayer _bgm) {
    _bgm.rewind();
    _bgm.play();
    _bgm.loop();
  }

  //================ pauseBGM ================  
  void pauseBGM(AudioPlayer _bgm) {
    _bgm.pause();
  }

  //================ playSE ================
  void playSE(AudioSnippet _se) {
    _se.rewind();
    _se.play();
  }  

  //================ finish ================
  void finish() {
    bgm1.close();
    jumpSE.close();
  }
}

