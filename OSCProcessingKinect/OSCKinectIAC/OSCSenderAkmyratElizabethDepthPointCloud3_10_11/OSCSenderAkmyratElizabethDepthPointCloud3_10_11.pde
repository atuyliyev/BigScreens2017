import processing.video.*; //<>// //<>//

// Daniel Shiffman
// Thomas Sanchez Lengeling
// Kinect Point Cloud example

// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/

import org.openkinect.processing.*;
import java.nio.FloatBuffer;


// Kinect Library object
Kinect2 kinect2;

// Angle for rotation
float a = 3.1;

PImage img;
Movie movie;

int minDepth = 50;
int maxDepth = 2705;

//change render mode between openGL and CPU
int renderMode = 1;

//for openGL render
PGL pgl;
PShader sh;
int  vertLoc;


import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress host;
//int z;

void setup() {

  // Rendering in P3D
  //size(800, 600, P3D);
  //fullScreen(P3D);
  size(1920, 1080, P3D);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();

  oscP5 = new OscP5(this, 12000);

  //movie = new Movie(this, "2.mov");

  //load shaders
  sh = loadShader("frag.glsl", "vert.glsl");

  smooth(16);

  frameRate(24);
  
    host = new NetAddress("localhost",12001);
  //@IAC 
  //host = new NetAddress("192.168.130.174",12000);
  //@ITP
  //host = new NetAddress("128.122.151.60",12000);
}


void draw() {
  background(0);

  // Translate and rotate
  pushMatrix();
  translate(width/2, height/2, 50);
  rotateY(a);


  // We're just going to calculate and draw every 2nd pixel
  int skip = 1;

  // Get the raw depth as array of integers
  int[] depth = kinect2.getRawDepth();

  stroke(255);
  beginShape(POINTS);

  OscMessage message = new OscMessage("/avgPoint");
  ArrayList<PVector>points2Send = new ArrayList<PVector>();

  for (int x = 0; x < kinect2.depthWidth; x+=skip) {
    for (int y = 0; y < kinect2.depthHeight; y+=skip) {
      int offset = x + y * kinect2.depthWidth;

      //calculte the x, y, z camera position based on the depth information
      PVector point = depthToPointCloudPos(x, y, depth[offset]);

      if (depth[offset] >= minDepth && depth[offset] <= maxDepth) {

        // Draw a point
        vertex(point.x*1.7, point.y*1.7-290, point.z);
        points2Send.add(point);
        //pushMatrix();
        ////color c = movie.pixels[offset];
        //color c = img.pixels[offset];
        //fill(c);
        //translate(point.x, point.y, point.z);
        ////rotateY(frameCount*0.1);
        //strokeWeight(0.1);
        //stroke(255);
        //ellipse(0,0,random(30),random(30));
        //popMatrix();
      }
    }
  }
  endShape();

  popMatrix();

  // First message is number of points
  message.add(points2Send.size()*3);
  for (int i = 0; i < points2Send.size(); i++) {
    PVector point = points2Send.get(i);
    message.add(point.x);
    message.add(point.y);
    message.add(point.z);
  }
  
    oscP5.send(message, host); 

  //saveFrame("content/E4####.png");
  // Rotate
  //a += 0.0015f;
}


//calculte the xyz camera position based on the depth data
PVector depthToPointCloudPos(int x, int y, float depthValue) {
  PVector point = new PVector();
  point.z = (depthValue);// / (1.0f); // Convert from mm to meters
  point.x = (x - CameraParams.cx) * point.z / CameraParams.fx;
  point.y = (y - CameraParams.cy) * point.z / CameraParams.fy;
  return point;
}

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+ theOscMessage.addrPattern());
  print(" typetag: "+ theOscMessage.typetag());
  println(" value: "+ theOscMessage.get(0).intValue());
  println(" value: "+ theOscMessage.get(1).intValue());
  println(" value: "+ theOscMessage.get(2).intValue());
  
}