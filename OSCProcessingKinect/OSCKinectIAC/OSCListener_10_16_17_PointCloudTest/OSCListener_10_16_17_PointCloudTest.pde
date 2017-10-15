/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress host;
int x, y, z;

PGraphics IAC;
PVector[] pos;

void setup() {
  //size(11520,1080);
  //fullScreen(P3D, SPAN);
  size(1024, 848, P3D);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 12001);

  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  host = new NetAddress("localhost", 12000);

  IAC = createGraphics(512, 424, P3D);
}


void draw() {

  background(0);    
  IAC.beginDraw();
  IAC.background(0);
  IAC.stroke(255);
  IAC.strokeWeight(2);
  for (int i = 0; i < pos.length; i++) {
    IAC.translate(pos[i].x, pos[i].y, pos[i].z);
    IAC.ellipse(0, 0, 100, 100);
  }
  IAC.endDraw();
  image(IAC, 0, 0, IAC.width*2, IAC.height*2);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  //print("### received an osc message.");
  //print(" addrpattern: "+ theOscMessage.addrPattern());
  //print(" typetag: "+ theOscMessage.typetag());
  //println(" value: "+ theOscMessage.get(0).intValue());
  int len = theOscMessage.get(0).intValue();
  pos = new PVector [len];

  for (int i = 1; i < len+1; i+=3) {
    int x = theOscMessage.get(i).intValue();
    int y = theOscMessage.get(i+1).intValue();
    int z = theOscMessage.get(i+2).intValue();
    println(x + "\t" + y + "\t" + z);
    pos[i] = new PVector(x, y, z);
  }
}