class PowerUp {
  // Member Variable
  float x, y, w, h, speed, health;
  //PImage obs;
  char type;
  char idir;

  // Constructor
  PowerUp(float w, float h, char idir) {
    this.w = w;
    this.h = h;
    speed = 5;

    if (int(random(4))==2) {
      type = 'h';
      x = random(width);
      y = height + 100;
    } else if (int(random(3))==1) {
      type = 't';
      x = -100;
      y = random(width);
    } else if (int(random(2))==1) {
      type = 'a';
      x = width +100;
      y = random(width);
    }
  }

  void display() {
    if (type == 'h') {
      fill(0, 200, 0);
      ellipse(x, y, w, h);
      fill(255);
      text("Health", x, y);
      textAlign(CENTER, CENTER);
    } else if (type == 't') {
      fill(0, 200, 0);
      ellipse(x, y, w, h);
      fill(255);
      text("Turret", x, y);
      textAlign(CENTER, CENTER);
    } else if (type == 'a') {
      fill(0, 200, 0);
      ellipse(x, y, w, h);
      fill(255);
      text("Ammo", x, y);
      textAlign(CENTER, CENTER);
    }
  }

  void move() {
    switch(idir) {
    case 'w':
      y=y-speed;
      break;
    case 'a':
      x=x-speed;
      break;
    case 's':
      y=y+speed;
      break;
    case 'd':
      x=x+speed;
      break;
    }

    x=x+speed;
    if (x>width) {
      x=0;
    }
  }

  void fire() {
  }

  boolean reachedSide() {
    return (x < -200 || x >= width + 200 || y < -200 || y>= height+200);
  }
  boolean intersect(Tank t) {
    float d = dist(x, y, t.x, t.y);
    return (d < (w/2 + 20)); // Adjust 20 based on tank size
  }
}
