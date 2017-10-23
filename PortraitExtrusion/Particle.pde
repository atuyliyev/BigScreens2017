class Particle {
  float x;
  float y;
  float bright;
  float len;
  float z = 0;
  float r;
  float target;



  Particle(float x_, float y_, float b_, float len_) {
    x = x_;
    y = y_;
    bright = b_;
    len = len_;
    target = 0;
  }

  void update() {
    z = lerp(z, target, 0.04);
    //z +=random(-1,1);

    //print(z + "value is");
    
  }

  void goBack() {
    target = 0;
  }

  void extrude() {
    target = bright*10;
    
    //vol = map(z, 0, 2550, 0, 5);
    //file.amp(vol);
  }


  void show() {
    stroke(bright, 255);
    strokeWeight(1);
    line(x, y, z, x, y, z - 50);
    //print(z + "      ");
  }
}