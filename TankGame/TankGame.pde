// 1 April 2026 | TankGame by Andrew Jiao
Tank t1;
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Obstacle o1;
Obstacle o2;
Obstacle o3;
PImage bg;
int score;
Timer objTimer;

void setup() {
  size(500, 500);
  score = 0;
  bg = loadImage("background.png");
  t1 = new Tank();
  objTimer = new Timer(1000);
  objTimer.start();
}

void draw() {
  background(127);
  imageMode(CORNER);
  image(bg, 0, 0); //
  if (objTimer.isFinished()) {
    float randomY = random(50, height - 100);
    obstacles.add(new Obstacle(-100, randomY, 100, 100, int(random(1, 10)), 10));
    objTimer.start(); 
  }
  for (int j = obstacles.size() - 1; j >= 0; j--) {
    Obstacle o = obstacles.get(j);
    o.display(); // [cite: 6]
    o.move();
    if (o.reachedSide()) {
      obstacles.remove(j);
      continue;
    }
    if (t1.intersect(o)) { 
      score = 0; 
      obstacles.remove(j); 
      continue;
    }
  }
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile p = projectiles.get(i);
    p.display(); // [cite: 9]
    p.move();
    if (p.reachedEdge()) {
      projectiles.remove(i);
      continue;
    }
    boolean hit = false;
    for (int j = obstacles.size() - 1; j >= 0; j--) {
      Obstacle o = obstacles.get(j);

      if (p.intersect(o)) { //
        score = score + 100; //
        obstacles.remove(j); //
        hit = true;
        break;
      }
    }
    if (hit) {
      projectiles.remove(i); //
    }
  }

  t1.display(); // [cite: 9]
  scorePanel(); // [cite: 9]
}

void keyPressed() {
  if (key == 'w') {
    t1.move('w');
  } else if (key == 's') {
    t1.move('s');
  } else if (key == 'a') {
    t1.move('a');
  } else if (key == 'd') {
    t1.move('d');
  }
}

void mousePressed() {
  float dx = mouseX -t1.x;
  float dy = mouseY - t1.y;
  float mag = sqrt(dx*dx + dy*dy);
  if (mag > 0) {
    dx /= mag;
    dy /= mag;

    float speed = 5;
    projectiles.add(new Projectile(t1.x, t1.y, dx * speed, dy * speed));
  }
}

void scorePanel() {
  fill(127, 200);
  rectMode(CENTER);
  noStroke();
  rect(width/2, 15, width, 30);
  fill(255);
  textSize(30);
  text("Score:" + score, width/2, 25);
}
