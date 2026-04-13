class Obstacle {
  float x,y,w,h,speed,health;
  //PImage iTankW;
  char idir;
  
 Obstacle(float x, float y, float w, float h, float speed, float health) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.speed = speed;
    this.health = health;
    speed = 7.0;
    health = 75.0;;
    idir = 'w';
  }
  
  void display() {
    fill(128);
    rect(x,y,w,h);
  }
  
  void move(char dir) {

  }
  
  void fire() {}
}
