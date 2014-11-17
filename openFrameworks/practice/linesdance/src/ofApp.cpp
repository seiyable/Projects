#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetFrameRate( 60 );
    ofBackground( 255 );
    ofSetBackgroundAuto( true );
    ofEnableAlphaBlending();
    ofSetColor( 0 );
    
    for (int i = 0; i < 1024; i++){
        lines[i] = ofRandom( ofGetHeight() );
        freaqencies[i] = ofRandom(10);
    }
}

//--------------------------------------------------------------
void ofApp::update(){
}

//--------------------------------------------------------------
void ofApp::draw(){
    for (int i = 0; i < 1024; i++){
        float t = ofGetElapsedTimef();
        float expansion = ofMap( sin(t * freaqencies[i]) , -1 , 1 , 0, 1);
//        ofSetColor( ofColor::fromHsb( ofMap( expansion*lines[i] , 0 , ofGetHeight() , 0 , 255 ), 80 , 80 ) );
        ofLine( i , 0 , i , expansion*lines[i]);
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
