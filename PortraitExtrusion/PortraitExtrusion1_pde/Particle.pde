class Particle {
  float x;
  float y;
  float bright;
  float len;
  float z = 0;
  float r;
  float target;
 
  
  Particle(float x_, float y_, float b_, float len_){
    x = x_;
    y = y_;
    bright = b_;
    len = len_;
    target = bright*10;

  }
  
  void update(){
  z = lerp(z, target, 0.04);
  //z +=random(-1,1);
  
    fill(255);
  
  text("your future is bright", 0,0);
  }
   
  void goBack(){
  target = 0;
  }
  
  void extrude(){
  target = bright*10;
  }
 

  void show(){
    stroke(bright, 255);
    strokeWeight(0.5);
    line(x, y, z, x, y, z - 50);
  }
}