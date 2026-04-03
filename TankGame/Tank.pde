class Tank {
  float x,y,w,h,speed,health;
  PImage iTank;
  
  Tank() {
  x = 100.0;
  y = 100.0;
  w = 100.0;
  h = 100.0;
  speed = 2.0;
  health = 75.0;
  iTank = loadImage("tank.png");
  }
  
  void move(char dir) {
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
