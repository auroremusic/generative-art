import processing.svg.*;
import controlP5.*;
ControlP5 cp5;

String name = "glitch";
int SEED = 0;
int DIMX = 1000;
int DIMY = 1000;
Boolean record = false;
Boolean display = true;
Slider abc;

float space = 30;
float pas = 2;
float phasex = 0.1;
float phasey = 0.1;
float phasext = 0.1;
float phaseyt = 0.1;
float r = 30;

float xoff = 0;
float yoff = 0;
float xoff2 = 0;
float yoff2 = 0;
float shift = 0.5;
float bend = 0;
float blaoff = 0;
float blaoff2 = 0;
float phasebend = 0.1;
float phasebend2 = 0.1;

void setup() {
  size(1000, 1000);  
  cp5 = new ControlP5(this);

  cp5.addSlider("SEED")
    .setPosition(10, 20)
    .setSize(500, 20)
    .setRange(0, 255)
    ;

  cp5.addSlider("space")
    .setPosition(10, 40)
    .setSize(500, 20)
    .setRange(2, 100)
    ;
  cp5.addSlider("pas")
    .setPosition(10, 60)
    .setSize(500, 20)
    .setRange(1, 30)
    ;

  cp5.addSlider("phasex")
    .setPosition(10, 80)
    .setSize(500, 20)
    .setRange(0.001, 0.5)
    ;
  cp5.addSlider("phasey")
    .setPosition(10, 100)
    .setSize(500, 20)
    .setRange(0.001, 0.5)
    ;
    
  cp5.addSlider("r")
    .setPosition(10, 120)
    .setSize(500, 20)
    .setRange(1,100)
    ;

  cp5.addSlider("phasext")
    .setPosition(10, 140)
    .setSize(500, 20)
    .setRange(0.001, 0.5)
    ;
  cp5.addSlider("phaseyt")
    .setPosition(10, 160)
    .setSize(500, 20)
    .setRange(0.001, 0.5)
    ;
    
  cp5.addSlider("shift")
    .setPosition(10, 180)
    .setSize(500, 20)
    .setRange(0, 1)
    ;
  cp5.addSlider("bend")
    .setPosition(10, 200)
    .setSize(500, 20)
    .setRange(0, 20)
    ;

  cp5.addSlider("phasebend")
    .setPosition(10, 220)
    .setSize(500, 20)
    .setRange(0, 0.3)
    ;
  cp5.addSlider("phasebend2")
    .setPosition(10, 240)
    .setSize(500, 20)
    .setRange(0, 0.3)
    ;

}

void ligne(float x,float y,float l, float r, float pas, Palette P){
  int c = int(random(P.S));
  float bli = 0;
  float t = 0;
  while (t < l){
    fill(P.get_color(c,int(355*noise(phasext*(xoff2 + x + t),phaseyt*(yoff2 + y)))));
    circle(x+t,y+ bli,r*(shift-noise(phasex*(xoff+x+t),phasey*(yoff+y))));
    t+=pas;
    bli+=bend*(0.5-noise(phasebend2*y + blaoff2, phasebend*t+blaoff));
  }
}

void draw() {
  if (record == true) {
    beginRecord(SVG, name + "Seed" + SEED + ".svg");
  }
  if (display==false){
  cp5.hide();
  }
  else{
   cp5.show(); 
  }
  
  // Short code to initialize random colors
  randomSeed(SEED);  
  Palette Pal = new Palette(int(random(100000)));
  background(Pal.get_random_color(255));
  noStroke();
  xoff = random(0,1000);
  yoff = random(0,1000);
  xoff2 = random(0,1000);
  yoff2 = random(0,1000);
  blaoff = random(0,1000);
  blaoff2 = random(0,1000);
  //
  push();
  translate(DIMX/2,DIMY/2);
  rotate(-PI/2);
  translate(-DIMX/2,-DIMY/2);
  for (float y = 100; y < DIMY-100; y+=space){ 
    fill(Pal.get_random_color(100));
  ligne(100,y,DIMX-200,r,pas, Pal);
  }
  pop();
  if (record == true) {
    endRecord();
  }
}

void keyPressed() {
  if (key == 'e') {
    exit();
  }
  if (key == 'r') {
    record = !record;
  }
  if (key == 'g') {
    SEED = int(random(0, 90000000));
  }
  if (key == 'a') {
    display = !display;
  }
}
