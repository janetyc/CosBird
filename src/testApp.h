#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"

class testApp : public ofxiPhoneApp {
	
public:
	void setup();
	void update();
	void draw();
	void exit();
	
	void touchDown(ofTouchEventArgs &touch);
	void touchMoved(ofTouchEventArgs &touch);
	void touchUp(ofTouchEventArgs &touch);
	void touchDoubleTap(ofTouchEventArgs &touch);
	void touchCancelled(ofTouchEventArgs &touch);

	void lostFocus();
	void gotFocus();
	void gotMemoryWarning();
	void deviceOrientationChanged(int newOrientation);
	
	void audioIn(float * input, int bufferSize, int nChannels);
	
	int		initialBufferSize;
	int		sampleRate;
	float 	* buffer;
	

	float x_pos, y_pos;
	
	int head_size;
	int big_count;
	int big_eye;
	int green_eye;
	
	float inside_eye;
	
	ofImage head_img;
	ofSoundPlayer bird_sound;
	
	
};


