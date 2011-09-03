#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	// register touch events
	ofRegisterTouchEvents(this);
	
	// initialize the accelerometer
	ofxAccelerometer.setup();
	
	//iPhoneAlerts will be sent to this.
	ofxiPhoneAlerts.addListener(this);
	
	//If you want a landscape oreintation 
	//iPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	ofBackground(0,0,0);
	ofSetCircleResolution(100);
	
	
	//audio in
	//for some reason on the iphone simulator 256 doesn't work - it comes in as 512!
	//so we do 512 - otherwise we crash
	initialBufferSize	= 512;
	sampleRate 			= 44100;
	
	buffer				= new float[initialBufferSize];
	memset(buffer, 0, initialBufferSize * sizeof(float));
	
	// 0 output channels,
	// 1 input channels
	// 44100 samples per second
	// 512 samples per buffer
	// 4 num buffers (latency)
	ofSoundStreamSetup(0, 1, this, sampleRate, initialBufferSize, 4);
	ofSetFrameRate(60);
	
	ofFill();
	ofEnableSmoothing();
	
	x_pos = ofGetWidth()/2;
	y_pos = ofGetHeight()/2;

	head_size = 100;
	big_count=0;
	big_eye=0;
	green_eye=0;
	
	inside_eye=0.0;
	
	//bird image
	head_img.loadImage("bird_cos.png");
	
	//bird sound
	bird_sound.loadSound("weeee.wav");
	bird_sound.setVolume(1.0f);
	bird_sound.setMultiPlay(false);
	
}

//--------------------------------------------------------------
void testApp::update(){

}

//--------------------------------------------------------------
void testApp::draw(){
	
	for (int i = 0; i < initialBufferSize; i=i+6){
		float curr_b = buffer[i]*100.0f;
		if (curr_b>0.0) {
			head_size = 100 + big_count;
			head_img.draw(x_pos-head_size, y_pos-head_size, head_size*2, head_size*2);
			
			if (curr_b > 10.0){
				
				if(big_count <= 50){
					big_count += 1;
				}
				else{
					green_eye += 1;
				}

			}else{
				if(big_count >=1) big_count -= 1;
			}
			
			if (curr_b > 3.0) {
				
				if (big_eye <= 20) {
					big_eye += 1;
				}
			}else {
				if (big_eye >= 1) {
					big_eye -= 1;
				}
			}

			
			//EYE
			ofSetColor(255, 255, 255);
			ofCircle(x_pos-head_size*0.4, y_pos, 20+big_eye);
			ofCircle(x_pos+head_size*0.4, y_pos, 20+big_eye);
		
			if (green_eye > 50) {
				ofSetColor(59, 232, 17);
			}else{
				ofSetColor(0, 0, 0);
			}
			
			
			if (curr_b > 15.0) {
				inside_eye = 15.0;
			}else{
				inside_eye = curr_b;
			}
			ofCircle(x_pos-head_size*0.4, y_pos, 15+inside_eye);
			ofCircle(x_pos+head_size*0.4, y_pos, 15+inside_eye);
			
			
			ofSetColor(0, 0, 0);
			ofCircle(x_pos+head_size*0.4, y_pos+head_size*0.5, 6-big_count*0.08);
			ofCircle(x_pos-head_size*0.4, y_pos+head_size*0.5, 6-big_count*0.08);
			ofLine(x_pos-1-big_count*0.4,  y_pos+head_size*0.8 , x_pos+1+big_count*0.4, y_pos+head_size*0.8);
			
			
			ofSetColor(255, 255, 255);
			ofCircle(x_pos-head_size*0.4+ofxAccelerometer.getForce().x*12, y_pos+ofxAccelerometer.getForce().y*12, 6);
			ofCircle(x_pos+head_size*0.4+ofxAccelerometer.getForce().x*12, y_pos+ofxAccelerometer.getForce().y*12, 6);
			
			
		}
	}
}

//--------------------------------------------------------------
void testApp::exit(){

}


//--------------------------------------------------------------
void testApp::audioIn(float * input, int bufferSize, int nChannels){
	if( initialBufferSize != bufferSize ){
		ofLog(OF_LOG_ERROR, "your buffer size was set to %i - but the stream needs a buffer size of %i", initialBufferSize, bufferSize);
		return;
	}	
	
	// samples are "interleaved"
	for (int i = 0; i < bufferSize; i++){
		buffer[i] = input[i];
	}
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs &touch){
	
	if(ofDist(x_pos, y_pos, touch.x, touch.y) < head_size ){
		NSLog(@"yes");
		if (green_eye > 50) {
			bird_sound.play();
			green_eye = 0;
		}
		
	}else{
		NSLog(@"no");
	}
	
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs &touch){

}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}


//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs& args){

}

