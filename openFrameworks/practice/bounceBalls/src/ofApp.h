#pragma once

#include "ofMain.h"
#define ballN 100

class ofApp : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw();

		void keyPressed(int key);
		void keyReleased(int key);
		void mouseMoved(int x, int y );
		void mouseDragged(int x, int y, int button);
		void mousePressed(int x, int y, int button);
		void mouseReleased(int x, int y, int button);
		void windowResized(int w, int h);
		void dragEvent(ofDragInfo dragInfo);
		void gotMessage(ofMessage msg);

    float ballX[ballN];
    float ballVeloX[ballN];
    float ballY[ballN];
    float ballVeloY[ballN];
    float ballR[ballN];
    ofColor ballColors[ballN];
};
