
import processing.sound.*;
import processing.video.*;

SoundFile file, file2, file3, file4;
Capture video;   

int[][] videoPixels;
int[][] values;

Particle[][] particles;

int i;
int e;
float vol;
int counter = 0;

float vole = 0;
float volb = 1;


void setup() {
 //size(1280, 720, P3D);
 size(640, 360, P3D);
  //size(1024,576);
  
  
  //fullScreen(P3D, 1);
  //noCursor();
  frameRate(30);

//  String[] cameras = Capture.list();
//  for (int i = 0; i < cameras.length; i++)println (i + ":"+ cameras[i]);

  //video = new Capture(this, width, height, "Logitech Webcam C930e"); 
  video = new Capture(this, width, height, "FaceTime HD Camera"); 
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

  //file = new SoundFile(this, "insideYourMind.mp3");
  //file.play();
  //file.amp(0);
  

}


void draw() {

  background(0);
  translate(width/2, height/2, -height/2);
  scale(1.7);


  //angle += 0.01;
  //rotateY(angle);  
  //variation += 0.01;
  //motion = noise(variation)*700;


  video.loadPixels();
  for (int i = 0; i < video.height; i += 10) {
    for (int j = 0; j < video.width; j += 10) {
      particles[j][i].update();
      particles[j][i].show();

      if (keyPressed) {
        if (key == 'b') {
          particles[j][i].goBack();
          file.amp(volb);
          
          volb = lerp(volb, 0, 0.9);
        } 
        if (key == 'e') {
          particles[j][i].extrude();
          file.amp(vole);
          
           vole = lerp(0, 1, 0.7);
          
        }
      }
    }
  }
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