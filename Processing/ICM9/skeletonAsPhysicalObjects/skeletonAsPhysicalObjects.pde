//================== import libraries ==================
import SimpleOpenNI.*;
import fisica.*;
import geomerative.*;
import org.apache.batik.svggen.font.table.*;
import org.apache.batik.svggen.font.*;
import java.util.Map;

import com.getflourish.stt.*;
import ddf.minim.*;
import javax.sound.sampled.*;

//=================== global variables ===================
SimpleOpenNI kinect;

FWorld world;
STT stt;
Status status = new Status();
float posX = 0;
RFont font;
ArrayList<Word> words = new ArrayList<Word>();
HashMap<Integer, UserLine> uLines = new HashMap<Integer, UserLine>();
color[] userClr = new color[] { 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};

//=================== setup() ======================================
void setup() {
  size(640, 480, P2D);
  frameRate(30);
  smooth();
  background(255);

  settingKinect();
  settingFisica();
  settingSTT();
}

//----------------- setting for kinect -----------------
void settingKinect() {
  kinect = new SimpleOpenNI(this);
  kinect.setMirror(true);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser();
  kinect.alternativeViewPointDepthToImage();
}

//----------------- setting for phisics engine -----------------  
void settingFisica() {
  Fisica.init(this);
  Fisica.setScale(4);
  world = new FWorld();
  world.setEdges(this, color(255));
  world.setGravity(0, 200);
  RG.init(this);
  RG.setPolygonizer(RG.ADAPTATIVE);
  font = RG.loadFont("MYRIADPRO-REGULAR.ttf");
}

//----------------- setting for voice recognition -----------------  
void settingSTT() {
  // Init STT automatically starts listening
  stt = new STT(this);
  stt.enableDebug();
  stt.setLanguage("en");

  // Display available Inputs with id and name
  Mixer.Info[] mixerInfo = AudioSystem.getMixerInfo();

  for (int i = 0; i < mixerInfo.length; i++)
  {
    println("### " + i + ": " + mixerInfo[i].getName());
  }  

  // Set input (e.g. 0)  
  Mixer mixer = AudioSystem.getMixer(mixerInfo[1]);

  // Update the Minim instance that STT is using
  Minim minim = stt.getMinimInstance();
  minim.setInputMixer(mixer);
  println("### Source set to: " + mixerInfo[0]);
}

//================ draw() ===================================
void draw() {
  kinect.update();

  //  image(kinect.depthImage(),0,0);
  //  image(kinect.userImage(), 0, 0);
  image(kinect.rgbImage(), 0, 0);

  //-------- draw the skeleton if it's available --------
  int[] userList = kinect.getUsers();
  for (int i=0;i<userList.length;i++) {
    if (kinect.isTrackingSkeleton(userList[i])) {
      stroke(userClr[ (userList[i] - 1) % userClr.length ] );
      drawSkeleton(userList[i]);
    }
  }

  status.check();
  status.display();

  world.step();
  world.draw();
}

//================ drawSkeleton() ================
// draw the skeleton as a physical object with the selected joints
void drawSkeleton(int userId) {

  PVector headPos3d = new PVector();
  PVector headPos2d = new PVector();
  PVector neckPos3d = new PVector();
  PVector neckPos2d = new PVector();
  PVector leftShoulderPos3d = new PVector();
  PVector leftShoulderPos2d = new PVector();
  PVector rightShoulderPos3d = new PVector();
  PVector rightShoulderPos2d = new PVector();
  PVector leftElbowPos3d = new PVector();
  PVector leftElbowPos2d = new PVector();
  PVector rightElbowPos3d = new PVector();
  PVector rightElbowPos2d = new PVector();
  PVector leftHandPos3d = new PVector();
  PVector leftHandPos2d = new PVector();
  PVector rightHandPos3d = new PVector();
  PVector rightHandPos2d = new PVector();
  PVector torsoPos3d = new PVector();
  PVector torsoPos2d = new PVector();
  PVector leftHipPos3d = new PVector();
  PVector leftHipPos2d = new PVector();
  PVector rightHipPos3d = new PVector();
  PVector rightHipPos2d = new PVector();
  PVector leftKneePos3d = new PVector();
  PVector leftKneePos2d = new PVector();
  PVector rightKneePos3d = new PVector();
  PVector rightKneePos2d = new PVector();
  PVector leftFootPos3d = new PVector();
  PVector leftFootPos2d = new PVector();
  PVector rightFootPos3d = new PVector();
  PVector rightFootPos2d = new PVector();

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, headPos3d);
  kinect.convertRealWorldToProjective(headPos3d, headPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, neckPos3d);
  kinect.convertRealWorldToProjective(neckPos3d, neckPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, leftShoulderPos3d);
  kinect.convertRealWorldToProjective(leftShoulderPos3d, leftShoulderPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, rightShoulderPos3d);
  kinect.convertRealWorldToProjective(rightShoulderPos3d, rightShoulderPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, leftElbowPos3d);
  kinect.convertRealWorldToProjective(leftElbowPos3d, leftElbowPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, rightElbowPos3d);
  kinect.convertRealWorldToProjective(rightElbowPos3d, rightElbowPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHandPos3d);
  kinect.convertRealWorldToProjective(leftHandPos3d, leftHandPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHandPos3d);
  kinect.convertRealWorldToProjective(rightHandPos3d, rightHandPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, torsoPos3d);
  kinect.convertRealWorldToProjective(torsoPos3d, torsoPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, leftHipPos3d);
  kinect.convertRealWorldToProjective(leftHipPos3d, leftHipPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, rightHipPos3d);
  kinect.convertRealWorldToProjective(rightHipPos3d, rightHipPos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, leftKneePos3d);
  kinect.convertRealWorldToProjective(leftKneePos3d, leftKneePos2d);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, rightKneePos3d);
  kinect.convertRealWorldToProjective(rightKneePos3d, rightKneePos2d);  
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, leftFootPos3d);
  kinect.convertRealWorldToProjective(leftFootPos3d, leftFootPos2d);  
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, rightFootPos3d);
  kinect.convertRealWorldToProjective(rightFootPos3d, rightFootPos2d);  

  uLines.get(userId).setPos_head2neck(headPos2d, neckPos2d);
  uLines.get(userId).setPos_neck2ls(neckPos2d, leftShoulderPos2d);
  uLines.get(userId).setPos_neck2rs(neckPos2d, rightShoulderPos2d);
  uLines.get(userId).setPos_ls2le(leftShoulderPos2d, leftElbowPos2d);  
  uLines.get(userId).setPos_rs2re(rightShoulderPos2d, rightElbowPos2d);
  uLines.get(userId).setPos_le2lha(leftElbowPos2d, leftHandPos2d);
  uLines.get(userId).setPos_re2rha(rightElbowPos2d, rightHandPos2d);
  uLines.get(userId).setPos_ls2torso(leftShoulderPos2d, torsoPos2d);  
  uLines.get(userId).setPos_rs2torso(rightShoulderPos2d, torsoPos2d);
  uLines.get(userId).setPos_torso2lhi(torsoPos2d, leftHipPos2d);
  uLines.get(userId).setPos_torso2rhi(torsoPos2d, rightHipPos2d);
  uLines.get(userId).setPos_lhi2lk(leftHipPos2d, leftKneePos2d);
  uLines.get(userId).setPos_rhi2rk(rightHipPos2d, rightKneePos2d);
  uLines.get(userId).setPos_lk2lf(leftKneePos2d, leftFootPos2d);
  uLines.get(userId).setPos_rk2rf(rightKneePos2d, rightFootPos2d);

  //-------------------------------------------------------
  
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
   
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
   
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
   
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
   
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
   
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
   kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
   
}

// =================================================
// SimpleOpenNI events

void onNewUser(SimpleOpenNI curkinect, int userId) {
  println("onNewUser - userId: " + userId);
  println("\tstart tracking skeleton");
  curkinect.startTrackingSkeleton(userId);

  color fillcolor = userClr[ (userId - 1) % userClr.length ];
  uLines.put(userId, new UserLine(fillcolor));
}

void onLostUser(SimpleOpenNI curkinect, int userId) {
  println("onLostUser - userId: " + userId);

  color cirfill = userClr[ (userId - 1) % userClr.length ];
  ArrayList<FBody> fBodies = world.getBodies();
  for (FBody fb : fBodies) {
    Class cls = fb.getClass();
    String clsname = cls.getName();
    if (clsname == "fisica.FLine") {
      FLine fl = (FLine) fb;
      if (fl.getFillColor() == cirfill) { 
        world.remove(fl);
      }
    }
  }
  uLines.remove(userId);
}

void onVisibleUser(SimpleOpenNI curkinect, int userId) {
  //println("onVisibleUser - userId: " + userId);
}

//================ contactStarted() ================
//physics engine event
void contactStarted(FContact fcon) {
  FChar ball = null;
  FLine human = null;
  FBody fbdy1 = fcon.getBody1();
  FBody fbdy2 = fcon.getBody2();

  Class cls1 = fbdy1.getClass();
  Class cls2 = fbdy2.getClass();
  String clsname1 = cls1.getName();
  String clsname2 = cls2.getName();

  if ((clsname1 == "fisica.FLine") && (clsname2 == "fisica.FLine")) {
    return;
  } 
  else if ((clsname1 == "skeletonAsPhysicalObjects$FChar") || (clsname2 == "skeletonAsPhysicalObjects$FChar")) {
    if (clsname1 == "fisica.FLine") {
      ball = (FChar) fbdy2;
      human = (FLine) fbdy1;
    } 
    else if (clsname2 == "fisica.FLine") {
      ball = (FChar) fbdy1;
      human = (FLine) fbdy2;
    }
  }
  if ((ball == null) || (human == null)) {
    return;
  } 
  else {
    //    println(human.getVelocityX());
    //    ball.addImpulse(human.getVelocityX()*10, human.getVelocityY()*10);

    for (Map.Entry me : uLines.entrySet()) {
      UserLine ul = (UserLine) me.getValue();
      if (ul.checkContact(human) != null) {
        PVector speed = ul.checkContact(human);
        ball.addImpulse(speed.x*100, speed.y*100);
        println("hello");
        return;
      }
    }
  }
}

//================== transcribe() ==================
// voice recognition event which is called if transcription was successfull 
void transcribe (String utterance, float confidence) {
  println(utterance);
  words.add(new Word(utterance));
}

//================ keyPressed() ================
public void keyPressed() {
  if (key == '`') {
    stt.begin();
  } 
  else {
    /*
    FChar fchr = new FChar(key);
     if (fchr.bodyCreated()) {
     world.add(fchr);
     }
     */

    if (key == '=') {
      world.clear();
      world.setEdges(this, color(255));
      posX = 0;
    }

    if (key == '-') {
      String s = "hello";
      words.add(new Word(s));
    }

    try {
      if (keyCode==CONTROL) {
        saveFrame("screenshot.png");
      }
    } 
    catch (Exception e) {
    }
  }
}

//================ keyReleased() ================
public void keyReleased () {
  if (key == '`') {
    stt.end();
  }
}

