import processing.sound.*;
import processing.video.*;

SoundFile file;
Capture video;   

int[][] videoPixels;
int[][] values;

Particle[][] particles;

int i;

int e;

void setup() {
  size(1000, 740, P3D);
  //fullScreen(P3D, 2);
  
  frameRate(100);
  
  video = new Capture(this, width, height, "FaceTime HD Camera"); 
  video.start();
  video.loadPixels();
  
  //videoPixels = new int[width][height];
  //values = new int[width][height];
  //particles = new Particle[width][height];
  //noFill();
  
  //  for (int i = 0; i < video.height; i++) {
  //  for (int j = 0; j < video.width; j++) {
  //    videoPixels[j][i] = video.pixels[i*video.width + j];
  //    values[j][i] = int(blue(videoPixels[j][i]));
  //    particles[j][i] = new Particle(j-video.width/2, i-video.height/2, int(blue(videoPixels[j][i])), 10);
  //  }
  //}
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