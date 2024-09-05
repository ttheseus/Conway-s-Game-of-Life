import processing.sound.*;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// Global Variables /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

boolean startSim;
boolean periodEnd;
boolean cellAlive;
int add = 0;
float timer = 0;
int periods = 0;

// SFX
SoundFile select;
SoundFile start;
SoundFile pause;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////// Prelims //////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  size(900, 990);
  background(255);
  frameRate(3);
}

void draw() {
  fill(205, 174, 232);
  rect(0, 0, 900, 60);
  stroke(0);
  textSize(35);
  fill(0);
  text("Conway's Game of Life", 280, 40);
  for (int i = 0; i <= 30; i++) {
    // line(x1,y1,x2,y2)
    // x-lines
    line(0, i*30+60, 900, i*30+60);
    stroke(192);
    //y-lines
    line(i*30, 60, i*30, 990);
    stroke(192);
  }

  if (startSim == true) {
    timer += 0.01;
    /////////////////////

    fill(205, 174, 232);
    rect(250, 70, 400, 50);
    stroke(0);
    fill(0);
    text("Periods: " + periods, 365, 105);

    /////////////////////
    //check for black cell

    for (int i = 0; i <= 900; i += 30) {
      for (int j = 0; j <= 990; j += 30) {
        println("i position is " + i + " j position is " + j);
        color cell = get(i-1, j-1);
        if (cell == 0) {
          cellAlive = true;
          cellGrowth(i, j);
        }
      }
    }

    if (periods >= 20) {
      startSim = false;
    }
  } else {
    fill(205, 174, 232);
    rect(350, 70, 160, 50);
    stroke(0);
    fill(0);
    text("Start", 395, 105);
  }
}

void mousePressed() {
  println(mouseX, mouseY);

  if (mouseX >= 350 && mouseX <= 508 && mouseY >= 71 && mouseY <= 118) {
    startSim = true;
    println("hellO");
  }

  if (startSim == false) {
    cellAdded();
  }
}

void keyPressed() {
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////// UTIL ////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void cellAdded() {
  // add black to the nearest factor of 60 to snap to grid
  int w = 30; // rectangle width
  int h = 30; // rectangle height

  int snapX = round(mouseX / w) * w; // '+ w/2' is offset to center of cell
  int snapY = round(mouseY / h) * h;   // '+ h/2' is offset to center of cell

  rect(snapX, snapY, 30, 30);
}

void cellGrowth(int a, int b) {
  /*
  All rules:
   - Live cells with >2 live neighbors dies
   - Live cells with 2-3 live neighbors lives
   - Live cells with >3 live neighbors dies
   - Dead cells with 3 live neighbors becomes alive
   
   if cell is black, it is alive
   if cell is white, it is dead
   */
   rect(a, b, 30, 30);
}

void perPeriod() {
  if (periodEnd == true) {
    periods += 1;
  }
}
