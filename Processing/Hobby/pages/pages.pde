//================== import libraries ==================
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

//================== global valuables ==================
ArrayList<Page> pages = new ArrayList<Page>();
ArrayList<Back> backs = new ArrayList<Back>();
boolean animationStay = false, animationNext = false;
Minim minim;
AudioSnippet sound;

//================== setup() ==================
void setup() {
  size(640, 480);
  colorMode(HSB, 360, 100, 100);
  minim = new Minim(this);
  sound = minim.loadSnippet("paging.mp3");

  pages.add(new Page());
  pages.add(new Page());
}

//================== draw() ==================
void draw() {
  if ((animationStay == false) && (animationNext == false)) {
    displayPages();
  }
  if ((animationStay == true) && (animationNext == false)) {
    stayThePage();
  }
  if ((animationStay == false) && (animationNext == true)) {
    goToTheNextPage();
  }
}

//================== displayPages() ==================
void displayPages() {
  for (int i = pages.size() - 1; i > pages.size() - 3; i--) {
    Page p = pages.get(i);
    p.display(i);
  }
}

//================== stayThePage() ==================
void stayThePage() {
  for (int i = pages.size() - 1; i > pages.size() - 3; i--) {
    Page p = pages.get(i);
    p.stayThePage(i);
  }
}

//================== goToTheNextPage() ==================
void goToTheNextPage() {
  for (int i = pages.size() - 1; i > pages.size() - 3; i--) {
    Page p = pages.get(i);
    p.goToTheNextPage(i);
  }
}

//================== mouseReleased() ==================
void mouseReleased() {
  if (mouseX < width/2) {
    animationStay = true;
    int i = pages.size();
    Page p = pages.get(i-2);
    p.setAniMouse();
  }
  else {
    animationNext = true;
    int i = pages.size();
    Page p = pages.get(i-2);
    p.setAniMouse();
  }
}

//================== stop() ==================
void stop() {
  sound.close();
  minim.stop();
  super.stop();
}

