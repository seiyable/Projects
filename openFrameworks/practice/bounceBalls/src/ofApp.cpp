#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(255);
    ofSetBackgroundAuto(true);
    ofEnableAlphaBlending();
    ofSetCircleResolution(64);
    ofSetFrameRate(60);
    
    //set initial positions
    for (int i = 0; i < ballN; i++){
        ballX[i] = ofRandom(40, 1024 - 40);
        ballVeloX[i] = ofRandom(-5, 5);
        ballY[i] = ofRandom(40, 768 - 40);
        ballVeloY[i] = ofRandom(-5, 5);
        ballR[i] = ofRandom(20, 40);
        ballColors[i] = ofColor::fromHsb(ofRandom(255), 200, 200);
    }
}

//--------------------------------------------------------------
void ofApp::update(){
    
    //update positions
    for (int i = 0; i < ballN; i++){
        //move the ball in x direction
        ballX[i] += ballVeloX[i];
        //bounce the ball on the window edge
        if(ballX[i] > ofGetWidth() - ballR[i] || ballX[i] < ballR[i]){
            ballVeloX[i] = -ballVeloX[i];
        }
        
        //move the ball in y direction
        ballY[i] += ballVeloY[i];
        //bounce the ball on the window edge
        if(ballY[i] > ofGetHeight() - ballR[i] || ballY[i] < ballR[i]){
            ballVeloY[i] = -ballVeloY[i];
        }
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    for (int i = 0; i < ballN; i++){
        ofSetColor(ballColors[i]);
        ofCircle(ballX[i], ballY[i], ballR[i]);
    }

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    for (int i = 0; i < ballN; i++){
        ballColors[i] = ofColor::fromHsb(ballColors[i].getHue(), ballColors[i].getSaturation() - 10, ballColors[i].getBrightness());
    }

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
