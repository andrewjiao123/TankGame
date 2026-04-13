class Tank {
  float x,y,w,h,speed,health;
  PImage iTankW,iTankA,iTankS,iTankD;
  char idir;
  
 Tank() {
    x = 100.0;
    y = 100.0;
    w = 100.0;
    h = 100.0;
    speed = 7.0;
    health = 75.0;
    iTankW = loadImage("tank.png");
    iTankA = loadImage("tank_a.png");
    iTankS = loadImage("tank_s.png");
    iTankD = loadImage("tank_d.png");
    idir = 'w';
  }
  
  void display() {
    imageMode(CENTER);
    if(idir == 'w') {
      image(iTankW,x,y);
    } else if (idir == 'a') {
      image(iTankA,x,y);
    } else if (idir == 's') {
      image(iTankS,x,y);
    } else if (idir == 'd') {
      image(iTankD,x,y);
    }

  }
  
  void move(char dir) {
    idir = dir;
    if(dir == 'w') {
      y = y - speed;
    } else if (dir == 's') {
      y = y + speed;
    } else if (dir == 'a') {
      x = x - speed;
    } else if (dir == 'd') {
      x = x + speed;
    }
  }
  
  void fire() {}
}
