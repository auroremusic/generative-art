import processing.svg.*;
import controlP5.*;
ControlP5 cp5;

String name = "subdivision-";
int SEED = 0; // random SEED
float SW = 5; // stroke weight
int DIMX = 1000; // if you change this, you need to change accordingly size(1000,1000) in "void setup()"
int DIMY = 1000; // if you change this, you need to change accordingly size(1000,1000) in "void setup()"

Slider abc;
Palette Pal;
float xoff = 0;
float yoff = 0;

float profondeur = 4; // recursion depth
float phase = 10;

Boolean record = false; // press "r" to start recording in .svg
Boolean display = true; // to be able to change the parameters

void setup() {
  size(1000, 1000);  
  cp5 = new ControlP5(this);

  cp5.addSlider("SEED")
    .setPosition(10, 20)
    .setSize(500, 20)
    .setRange(0, 255)
    ;
    
   cp5.addSlider("profondeur")
    .setPosition(10, 50)
    .setSize(500, 20)
    .setRange(0, 8)
    ;
   cp5.addSlider("phase")
    .setPosition(10, 80)
    .setSize(500, 20)
    .setRange(1, 1000)
    ;
   cp5.addSlider("SW")
    .setPosition(10, 110)
    .setSize(500, 20)
    .setRange(0, 20)
    ;
 
}

void block(float x,float y,float taille,int p, Boolean test){
  Boolean temp = false;
  if (p ==0){
     float r = random(1);
     if (r <0.1){
        p+=1;
        temp = true;
     }
  }
  
  if (p > 0){
    block(x,y,taille/2,p-1,temp);
    block(x+taille/2,y,taille/2,p-1,temp);
    block(x,y+taille/2,taille/2,p-1,temp);
    block(x+taille/2,y+taille/2,taille/2,p-1,temp);
 }
 else{
   int nb_colors = Pal.list_palettes[Pal.P].length;
   stroke(Pal.get_color(int(nb_colors*noise(xoff+x/phase,yoff+y/phase))));
   float r =random(1);
   if (test){
   strokeWeight(SW/4);
   }
   if (r <= 0.5){
     line(x,y,x+taille,y+taille);
     line(x+taille/2,y,x+taille,y+taille/2);
     line(x,y+taille/2,x+taille/2,y+taille);
     
   }

  if (r > 0.5 && r < 1){
     line(x+taille,y,x,y+taille);
     line(x,y+taille/2,x+taille/2,y);
     line(x+taille/2,y+taille,x+taille,y+taille/2);
    
  }
  if (test){
     strokeWeight(SW);
  }
}
}

void draw() {
  if (record == true) {
    beginRecord(SVG, name + "SEED" + SEED + ".svg");
  }
  if (display==false){
  cp5.hide();
  }
  else{
   cp5.show(); 
  }
  
  // Short code to initialize random colors
  randomSeed(SEED);  
  Pal = new Palette(int(random(100000)));
  background(Pal.get_random_color());
  strokeWeight(SW);
  xoff = random(1000);
  yoff = random(1000);

  //

  block(0,0,1000,int(profondeur),false);

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
