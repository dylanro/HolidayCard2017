ArrayList<snowflake> snowflakes;

void setup() {
  fullScreen();
  snowflakes = new ArrayList<snowflake>();
  for (int i = 0; i<180; i++) {
    snowflakes.add(new snowflake());
  }
}

void draw() {
  background(#1A1A1D);
  for (int i =0; i<snowflakes.size(); i++) {
    snowflakes.get(i).display();
    snowflakes.get(i).fall();
    snowflakes.get(i).revert();
  }
}
class snowflake{
PVector velocity;
  PVector loc;
  float ang;
  float r;

  snowflake() {
    loc = new PVector(random(-200, width+100), random(100, 500)*-1);
    r = random(2, 8);
    velocity = new PVector(0.8,r*.38);
    ang = random(0, 360);
  }

  void fall() {
    ang+=0.07;
    loc.x+=.3*sin(ang);
    loc.add(velocity);
  }

  void revert() {
    if (loc.y > height+50) {
      loc.y = -50;
      loc.x = random(-200, width+100);
    }
  }

  void display() {
    if (r < 4) {
      fill(#FFFFFF, 100);
    } else {
      fill(#FFFFFF);
    }
    noStroke();
    ellipse(loc.x, loc.y, r, r);
  }
}
