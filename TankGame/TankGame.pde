// 1 April 2026 | TankGame by Andrew Jiao
Tank t1;
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
Obstacle o1;
Obstacle o2;
Obstacle o3;
PImage bg;
int score;

void setup() {
  size(500, 500);
  score = 0;
  bg = loadImage("background.png");
  t1 = new Tank();
  o1 = new Obstacle(400, 100, 100, 50, 10, 100);
  o2 = new Obstacle(300, 100, 200, 50, 10, 100);
  o3 = new Obstacle(200, 100, 300, 50, 10, 100);
}

void draw() {
  background(127);
  imageMode(CORNER);
  image(bg, 0, 0);
  for (int i = 0; i < projectiles.size(); i++) {
    Projectile p = projectiles.get(i);
    p.display();
    p.move();
  }
  t1.display();
  o1.display();
  o2.display();
  o3.display();
  o1.move();
  o2.move();
  o3.move();
  scorePanel();
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
  projectiles.add(new Projectile(t1.x, t1.y, 4, 10));
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
