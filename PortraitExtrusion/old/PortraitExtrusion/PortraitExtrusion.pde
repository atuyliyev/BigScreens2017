
import processing.sound.*;
import processing.video.*;

SoundFile file;
Capture video;   

int[][] videoPixels;
int[][] values;

Particle[][] particles;


//float angle;
//float motion;
//float variation;
//PImage drawing;
int i;
//float Z;
//float X;
//float Y;
//float X2;
//float Y2;
//float Z2;
int e;

void setup() {
  //size(1000, 740, P3D);
  fullScreen(P3D, 2);
  //noCursor();
  frameRate(100);

  //String[] cameras = Capture.list();
  //for (int i = 0; i < cameras.length; i++)println (i + ":"+ cameras[i]);

  //video = new Capture(this, width, height, "Logitech Webcam C930e"); 
  video = new Capture(this, width, height, "Logitech Webcam C930e"); 
  video.start();
  video.loadPixels();
  

  
  videoPixels = new int[width][height];
  values = new int[width][height];
  particles = new Particle[width][height];
  noFill();
  
    for (int i = 0; i < video.height; i++) {
    for (int j = 0; j < video.width; j++) {
      videoPixels[j][i] = video.pixels[i*video.width + j];
      values[j][i] = int(blue(videoPixels[j][i]));
      particles[j][i] = new Particle(j-video.width/2, i-video.height/2, int(blue(videoPixels[j][i])), 10);
    }
  }

  //drawing = loadImage( i + ".jpg" );  
  //drawing.resize(width, height);

  //file = new SoundFile(this, "RunawayHorses.mp3");
  //file.play();
}


void draw() {

  background(0);
  translate(width/2, height/2, -height/2-600);
  scale(1.7);
  //angle += 0.01;
  //rotateY(angle);  
  //variation += 0.01;
  //motion = noise(variation)*700;
  
  
  video.loadPixels();
  for (int i = 0; i < video.height; i += 8) {
    for (int j = 0; j < video.width; j += 8) {
      particles[j][i].update();
      particles[j][i].show();

      if (keyPressed) {
        if (key == ' ') {
          particles[j][i].goBack();
        } 
        if (key == 'e') {
          particles[j][i].extrude();
        }
      }
    }
  }
  //updatePixels();
  

}

void mousePressed() {

  video.read();
  //translate(-width/2, -height/2, 0);
  //image(video,0,0);
  
  for (int i = 0; i < video.height; i++) {
    for (int j = 0; j < video.width; j++) {
      videoPixels[j][i] = video.pixels[i*video.width + j];
      values[j][i] = int(blue(videoPixels[j][i]));
      particles[j][i] = new Particle(j-video.width/2, i-video.height/2, int(blue(videoPixels[j][i])), 10);
    }
  }
  
}

//void keyPressed() {    
//  i++;
//  if (i == 7) {
//    i=0;
//  }
//  drawing = loadImage( i + ".jpg" );  
//  drawing.resize(width, height);
//  drawing.loadPixels();

//  for (int i = 0; i < drawing.height; i++) {
//    for (int j = 0; j < drawing.width; j++) {
//      drawingsPixels[j][i] = drawing.pixels[i*drawing.width + j];
//      values[j][i] = int(blue(drawingsPixels[j][i]));
//    }
//  }
//}