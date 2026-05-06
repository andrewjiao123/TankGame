// 1 April 2026 | TankGame | Andrew Jiao
Tank t1;
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<PowerUp> powerups = new ArrayList<PowerUp>();
PImage bg;
int score, health;
int ammo = 20; 
int gameState = 0; 
Timer objTimer, puTimer;

void setup() {
  size(500, 500);
  score = 0;
  health = 10;
  bg = loadImage("background.png");
  t1 = new Tank();
  objTimer = new Timer(1000); 
  objTimer.start();
  

  puTimer = new Timer(2000); 
  puTimer.start();
}

void draw() {
  if (gameState == 0) {
    displayStartScreen();
  } else if (gameState == 1) {
    playGame();
  } else if (gameState == 2) {
    displayGameOver();
  }
}

void displayStartScreen() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("TANK GAME", width/2, height/2 - 30);
  textSize(20);
  text("Click Mouse to Begin", width/2, height/2 + 30); 
}

void displayGameOver() {
  background(0);
  fill(255, 0, 0); 
  textAlign(CENTER, CENTER);
  textSize(50);
  text("GAME OVER", width/2, height/2); 
  noLoop();
}

void playGame() {
  background(127);
  imageMode(CORNER);
  if (bg != null) image(bg, 0, 0);

  // SPAWNING
  if (objTimer.isFinished()) {
    float randomY = random(50, height - 100);
    obstacles.add(new Obstacle(-100, randomY, 100, 100, int(random(1, 10)), 10)); 
    objTimer.start();
  }
  
  if (puTimer.isFinished()) {
    powerups.add(new PowerUp(50, 50, 'd'));  
    puTimer.start();
  }

  // POWERUP LOGIC
  for (int i = powerups.size() - 1; i >= 0; i--) {
    PowerUp pu = powerups.get(i);
    pu.display(); 
    pu.move(); 

    if (dist(t1.x, t1.y, pu.x, pu.y) < 60) {
      if (pu.type == 'h') {
        health = min(health + 2, 10); 
      } else if (pu.type == 'a') {
        ammo += 50; 
      } else if (pu.type == 't') {
        spawnTurretWave(); 
      }
      powerups.remove(i);
    } else if (pu.reachedSide()) { // [cite: 20]
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
    
    if (t1.intersect(o)) { 
      health -= 1; 
      obstacles.remove(j);
      if (health <= 0) gameState = 2;
    }
  }

  // PROJECTILE LOGIC
  for (int i = projectiles.size() - 1; i >= 0; i--) {
    Projectile p = projectiles.get(i);
    p.display(); // [cite: 25]
    p.move(); // [cite: 26]
    
    if (p.reachedEdge()) { // [cite: 30]
      projectiles.remove(i);
      continue;
    }

    for (int j = obstacles.size() - 1; j >= 0; j--) {
      Obstacle o = obstacles.get(j);
      if (p.intersect(o)) { 
        score += 100;
        obstacles.remove(j);
        projectiles.remove(i);
        break; 
      }
    }
  }

  t1.display(); 
  scorePanel();
}

// --- MECHANICS ---

void spawnTurretWave() {
  int bullets = 16; 
  for (int i = 0; i < bullets; i++) {
    float angle = TWO_PI / bullets * i;
    float vx = cos(angle) * 7;
    float vy = sin(angle) * 7;
    projectiles.add(new Projectile(t1.x, t1.y, vx, vy)); 
  }
}

void keyPressed() {
  if (gameState == 1) {
    t1.move(key); 
  }
}

void mousePressed() {
  if (gameState == 0) {
    gameState = 1; 
  } else if (gameState == 1 && ammo > 0) { 
    float dx = mouseX - t1.x;
    float dy = mouseY - t1.y;
    float mag = sqrt(dx*dx + dy*dy);
    if (mag > 0) {
      projectiles.add(new Projectile(t1.x, t1.y, (dx/mag)*8, (dy/mag)*8)); 
      ammo--; 
    }
  }
}

void scorePanel() {
  fill(127, 200);
  rectMode(CENTER);
  noStroke();
  rect(width/2, 20, width, 40);
  
  fill(255);
  textSize(16);
  textAlign(CENTER, CENTER);
  // Displays Score, Ammo, and Health at the top
  text("Score: " + score, width * 0.2, 20);
  text("Ammo: " + ammo, width * 0.5, 20); 
  text("Health: " + health, width * 0.8, 20);
}
