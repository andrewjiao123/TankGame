class Projectile {
  float x,y,w,h,speed;
  float vx, vy;
  char dir;
  
 Projectile(float x, float y, float vx, float vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.w = 10;
    this.h = 10;
    speed = 8;
    dir = 'u';
  }
  
  void display() {
    fill(255,0,0);
    rect(x,y,w,h);
  }
  
  void move() {
    x += vx;
    y +=vy;
  }
  
  void fire() {}
}
