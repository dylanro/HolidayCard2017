ArrayList<light> lights;
ArrayList<snowflake> snowflakes;
//PFont christmasfont1;
//PFont christmasfont2;
sunMoonRotation smr;
public int realhour;
public int realday;

void setup() {
  size(1000, 400);
 // christmasfont2 = createFont("/data/PWHappyChristmas.ttf", 64);

  lights = new ArrayList<light>();
  snowflakes = new ArrayList<snowflake>();
  smr = new sunMoonRotation();

  for (int i = 0; i<180; i++) {
    snowflakes.add(new snowflake());
  }

  lights.add(new light(207, 242+20));
  lights.add(new light(262, 250+20));
  lights.add(new light(277, 192+20));
  lights.add(new light(237, 204+20));
  lights.add(new light(254, 151+20));
  lights.add(new light(255, 101+20));
}

void draw() {
  realhour = hour();
  realday = day();
  changeBackground();
  //smr.displayPath();
  smr.drawSun();
  smr.drawMoon();
  smr.timeRotation();
  //smr.updateHour();
  noStroke();
  fill(215,215,215);
  rect(0,height/2+100,width,height/2+100);

  christmasTree(250, 80);
  present(173, 325+20);
  snowman(400, 250);

  for (snowflake s : snowflakes) {
    s.display();
    s.fall();
    s.revert();
  }

  fill(255);
  textSize(30);
  //textFont(christmasfont2);
  text("Christmas has already happened!", 517, 100);
}

int daysTillChristmas() {
  if (month()==12) {
    return 25-realday;
  }
 return 0;
}

class sunMoonRotation {
  float angle, sunx, suny, moonx, moony;
  int pathrad, sunrad, moonrad;

  sunMoonRotation() {
    pathrad = (width/2)+50;
    sunrad = 45;
    moonrad = 50;
  }

  void displayPath() {
    pushMatrix();
    translate(width/2, height+200);
    noFill();
    stroke(51, 51, 51, 100);
    strokeWeight(2);
    ellipse(0, 0, pathrad*2, pathrad*2);
    popMatrix();
  }

  void drawMoon() {
    pushMatrix();
    translate(width/2, height+200);
    fill(140);
    noStroke();
    moonx = pathrad*cos(radians(angle+180));//+180 moves it to the other side
    moony = pathrad*sin(radians(angle+180));
    ellipse(moonx, moony, moonrad*2, moonrad*2);
    popMatrix();
  }

  void drawSun() {
    pushMatrix();
    translate(width/2, height+200);
    fill(#F7B633);
    noStroke();
    sunx = pathrad*cos(radians(angle));
    suny = pathrad*sin(radians(angle));
    ellipse(sunx, suny, sunrad*2, sunrad*2);
    translate(sunx, suny);
    popMatrix();
  }

  void timeRotation() {
    angle = map(realhour, 0, 21, 90, 360+45);
  }
}

void changeBackground() {
  int h = smr.realhour;
  if (realhour == 1 || realhour == 2) {
    background(0, 57, 76);
  } else if (realhour == 3 || realhour == 4) {
    background(0, 76, 102);
  } else if (realhour == 5 || realhour == 6) {
    background(0, 114, 153);
  } else if (realhour == 7 || realhour == 8) {
    background(0, 152, 204);
  } else if (realhour == 9 || realhour == 10) {
    background(0, 171, 229);
  } else if (realhour == 11 || realhour == 12) {
    background(0, 191, 255);
  } else if (realhour == 13 || realhour == 14) {
    background(0, 171, 229);
  } else if (realhour == 15 || realhour == 16) {
    background(0, 152, 204);
  } else if (realhour == 17 || realhour == 18) {
    background(0, 114, 153);
  } else if (realhour == 19 || realhour == 20) {
    background(0, 76, 102);
  } else if (realhour == 21 || realhour == 0) {
    background(0, 38, 51);
  } else background(0);
}

void christmasTree(float x, float y) {
  //SHADOW
  noStroke();
  fill(120, 120, 120, 60);
  ellipse(x, y+250, 140, 20);

  //MAIN BODY
  fill(#25852f);
  noStroke();
  triangle(x, y, x+30, y+70, x-30, y+70);
  triangle(x, y+30, x+45, y+120, x-45, y+120);
  triangle(x, y+60, x+60, y+170, x-60, y+170);
  triangle(x, y+100, x+78, y+220, x-78, y+220);

  //CHORDS
  strokeWeight(3);
  stroke(255);
  line(263, 90+20, 229, 106+20);
  line(225, 135+20, 283, 153+20);
  line(286, 183+20, 202, 204+20);
  line(197, 235+20, 312, 250+20);

  //STAR
  star(x, y-20, .35);

  //LIGHTS
  for (light l : lights) {
    l.display();
    l.lightUp();
  }
  //STUMP
  fill(#663300);
  noStroke();
  rect(x-10, y+220, 20, 30);
}

class light {
  float x;
  float y;
  float r;
  color c;

  light(int x, int y) {
    this.x = x;
    this.y = y;
    this.r = 10;
    c = color(random(50, 255), random(50, 255), random(50, 255));
  }
  void display() {
    fill(c);
    noStroke();
    ellipse(x, y, r, r);
  }

  void lightUp() {
    if (hover()) {
      noStroke();
      fill(255, 255, 255, 2);
      ellipse(x, y, r+6, r+6);
    }
  }

  boolean hover() {
    if (dist(x, y, mouseX, mouseY) < r) {
      return true;
    }
    return false;
  }
}

void star(float x, float y, float scale) {
  noStroke();
  fill(#ffdc65);
  beginShape();
  vertex(x, y);
  vertex(x+12*scale, y+36*scale);
  vertex(x+47*scale, y+36*scale);
  vertex(x+20*scale, y+60*scale);
  vertex(x+30*scale, y+96*scale);
  vertex(x, y+73*scale);
  vertex(x-30*scale, y+96*scale);
  vertex(x-20*scale, y+60*scale);
  vertex(x-47*scale, y+36*scale);
  vertex(x-12*scale, y+36*scale);
  vertex(x, y);
  endShape(CLOSE);
}

class snowflake {
  PVector velocity;
  PVector loc;
  float ang;
  float r;

  snowflake() {
    loc = new PVector(random(-200, width+100), random(100, 500)*-1);
    r = random(2, 8);
    velocity = new PVector(0.8, r*.4);
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

void snowman(float x, float y) {
  //SHADOW
  fill(120, 120, 120, 60);
  ellipse(x, y+85, 80, 20);
  //ARMS
  stroke(#663300);
  line(x+15, y, x+62, y-30);
  line(450, 227, 450, 214);
  line(445, 231, 457, 235);
  line(x-15, y, x-62, y-30);
  line(360, 234, 357, 219);
  line(348, 227, 339, 228);

  //BODY
  fill(255);
  noStroke();
  ellipse(x, y-50, 50, 50);
  ellipse(x, y, 65, 65);
  ellipse(x, y+50, 74, 74);

  //BUTTONS
  noStroke();
  fill(51);
  ellipse(x, y, 5, 5);
  ellipse(x, y+10, 5, 5);
  ellipse(x, y-10, 5, 5);

  //NOSE
  fill(#FFC77F);
  beginShape();
  vertex(x, y-50);
  vertex(x+20, y-45);
  vertex(x, y-40);
  endShape(CLOSE);

  //HAT
  fill(#F75940);
  rect(x-18, y-100, 18*2, 20);
  fill(51);
  rect(x-28, y-86, 28*2, 20);
  rect(x-18, y-110, 18*2, 20);

  //EYES
  fill(51);
  noStroke();
  ellipse(389, 193, 5, 5);
  ellipse(411, 193, 5, 5);

  //MOUTH
  ellipse(x, y-32, 3, 3);
  ellipse(x+5, y-34, 3, 3);
  ellipse(x-5, y-34, 3, 3);
}

void present(float x, float y) {
  rectMode(CENTER);
  //SHADOW
  fill(120, 120, 120, 60);
  ellipse(x, y+15, 100, 20);
  //BODY/LID
  fill(#F54D42);
  noStroke();
  rect(x, y, 60, 30);
  fill(#FC6E5E);
  rect(x, y-15, 70, 8);
  rectMode(CORNER);
}
