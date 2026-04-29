// 1 April 2026 | TankGame by Andrew Jiao
Tank t1;
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
PImage bg;
int score, health;
Timer objTimer, puTimer;

void setup() {
  size(500, 500);
  score = 0;
  health = 10;
  bg = loadImage("background.png");
  t1 = new Tank();
  objTimer = new Timer(1000);
  objTimer.start();
  puTimer = new Timer(5000);
  puTimer.start();
}

void draw() {
  // GAME OVER CHECK
  if (health <= 0) {
    background(0);
    fill(255, 0, 0);
    textAlign(CENTER, CENTER);
    textSize(50);
    text("GAME OVER", width/2, height/2);
    noLoop();
    return;
  }

  background(127);
  imageMode(CORNER);
  image(bg, 0, 0);

  // SPAWNING
  if (objTimer.isFinished()) {
    float randomY = random(50, height - 100);
    // Obstacle constructor: x, y, w, h, speed, health [cite: 2]
    obstacles.add(new Obstacle(-100, randomY, 100, 100, int(random(1, 10)), 10));
    objTimer.start();
  }
  
  if (puTimer.isFinished()) {
    // PowerUp constructor now requires idir [cite: 9]
    powerups.add(new PowerUp(50, 50, 'd')); 
    puTimer.start();
  }

  // POWERUP LOGIC
  for (int i = powerups.size() - 1; i >= 0; i--) {
    PowerUp pu = powerups.get(i);
    pu.display();
    pu.move();

    // Collision detection using distance [cite: 44]
    if (dist(t1.x, t1.y, pu.x, pu.y) < 60) {
      if (pu.type == 'h') {
        health = min(health + 2, 10); // Heal 2
      } else if (pu.type == 'a') {
        score += 500; // Ammo bonus
      } else if (pu.type == 't') {
        t1.speed += 5; // Turret/Speed boost
      }
      powerups.remove(i);
    } else if (pu.reachedSide()) {
      powerups.remove(i);
    }
  }

  // OBSTACLE LOGIC
  for (int j = obstacles.size() - 1; j >= 0; j--) {
    Obstacle o = obstacles.get(j);
    o.display(); 
    o.move();
    
    if (o.reachedSide()) {
      obstacles.remove(j);
      continue;
    }
    
    if (t1.intersect(o)) { // [cite: 44]
      health -= 1;
      obstacles.remove(j);
    }
  }

  // PROJECTILE LOGIC
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile p = projectiles.get(i);
    p.display();
    p.move();
    
    if (p.reachedEdge()) {
      projectiles.remove(i);
      continue;
    }

    for (int j = obstacles.size() - 1; j >= 0; j--) {
      Obstacle o = obstacles.get(j);
      if (p.intersect(o)) { // [cite: 27]
        score += 100;
        obstacles.remove(j);
        projectiles.remove(i);
        break; 
      }
    }
  }

  t1.display(); 
  scorePanel();
} // THIS BRACE CLOSES DRAW() - Without this, you get errors below!

void keyPressed() {
  if (key == 'w') t1.move('w');
  else if (key == 's') t1.move('s');
  else if (key == 'a') t1.move('a');
  else if (key == 'd') t1.move('d');
}

void mousePressed() {
  float dx = mouseX - t1.x;
  float dy = mouseY - t1.y;
  float mag = sqrt(dx*dx + dy*dy);
  if (mag > 0) {
    dx /= mag;
    dy /= mag;
    projectiles.add(new Projectile(t1.x, t1.y, dx * 8, dy * 8)); // [cite: 22]
  }
}

void scorePanel() {
  fill(127, 200);
  rectMode(CENTER);
  noStroke();
  rect(width/2, 15, width, 30);
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text("Score: " + score, width/4, 25);
  text("Health: " + health, 3 * width/4, 25);
}
