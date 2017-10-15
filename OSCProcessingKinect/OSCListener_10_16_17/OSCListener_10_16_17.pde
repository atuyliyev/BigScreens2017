/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress host;
float pct;

void setup() {
  //size(11520,1080);
  fullScreen(P2D, SPAN);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  host = new NetAddress("localhost",12000);
}


void draw() {
  background(0);  
  fill(255);
  noStroke();
  //rect(0, 0, pct*width, height);
  fill(255,0,0);
  ellipse(pct*width, pct*height, width/8,width/8);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+ theOscMessage.addrPattern());
  print(" typetag: "+ theOscMessage.typetag());
  println(" value: "+ theOscMessage.get(0).floatValue());
  
  pct = theOscMessage.get(0).floatValue();
}