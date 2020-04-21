import processing.svg.*;
import controlP5.*;
ControlP5 cp5;

String name = "disque";
int SEED = 120;
int DIMX = 1000;
int DIMY = 1000;
Boolean record = false;

// parameters
int NX = 10;
int NY = 10;
float SPACE = 30;
float SIZE = 30;

float SW = 4;

float offs = 0;
float ROT = 0;
float shift = 0;
Slider abc;

float phase = 13;
float xoff = 0;
float yoff = 0;

Boolean display = true;

void setup() {
  size(1000,1000);  
    
  //frameRate(2);
  cp5 = new ControlP5(this);
  
  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("SEED")
     .setPosition(100,50)
     .setSize(300,10)
     .setRange(0,300)
     ;
  
  // create another slider with tick marks, now without
  // default value, the initial value will be set according to
  // the value of variable sliderTicks2 then.

   cp5.addSlider("SPACE")
     .setPosition(100,100)
     .setSize(300,10)
     .setRange(-100,255)
     ;
   cp5.addSlider("SIZE")
     .setPosition(100,120)
     .setSize(300,10)
     .setRange(1,255)
     ;
     
  cp5.addSlider("SW")
     .setPosition(100,180)
     .setSize(300,10)
     .setRange(0.1,10)
     ;
     
  cp5.addSlider("phase")
     .setPosition(100,260)
     .setSize(300,10)
     .setRange(1,300)
     ;
  cp5.addSlider("shift")
     .setPosition(100,280)
     .setSize(300,10)
     .setRange(0,30)
     ;
     



}

float[] coloration(float[] a,float[] b,float[] c,float[] d,float t){
    float[] res = new float[4];
    res[0] = a[0] + b[0]*cos(2*3.14159*(c[0]*t+d[0]));
    res[1] = a[1] + b[1]*cos(2*3.14159*(c[1]*t+d[1]));
    res[2] = a[2] + b[2]*cos(2*3.14159*(c[2]*t+d[2]));  
    res[3] = 1;
    return res;  
  }

void initColors(float[] a){
 a[0] = random(0,1);
 a[1] = random(0,1);
 a[2] = random(0,1);
 
}

void initColoration(float[] a,float[] b,float[] c,float[] d){
    initColors(a);
    initColors(b);
    initColors(c);
    initColors(d);
}

void setFillColor(float[] a, float[] b, float[] c, float[] d, float t, float transparency){
    float[] f = coloration(a,b,c,d,t);
    fill(color(f[0]*255,f[1]*255,f[2]*255,transparency));
}

void setStrokeColor(float[] a, float[] b, float[] c, float[] d, float t, float transparency){
    float[] f = coloration(a,b,c,d,t);
    stroke(color(f[0]*255,f[1]*255,f[2]*255,transparency));
}

void draw() {
  if (record == true){
    beginRecord(SVG, name + str(SEED) + ".svg");
  }
  
  if (display==false){
  cp5.hide();
  }
  else{
   cp5.show(); 
  }
  
  // Short code to initialize random colors
  randomSeed(SEED);
  float[] aa = new float[3];
  float[] bb = new float[3];
  float[] cc = new float[3];
  float[] dd = new float[3];
  initColoration(aa,bb,cc,dd);
  
 setFillColor(aa,bb,cc,dd,random(0,1),255);
 strokeWeight(SW);
  Palette Pal = new Palette(int(random(10000)));
  color back = Pal.get_random_color();
  background(back);
  color bla = Pal.get_random_color();
  stroke(bla);
// main loop
 int NOMBRE = int(DIMX/(SPACE+SIZE)-2);
  for (int i = 0; i < NOMBRE; i++){
    for (int j = 0; j < NOMBRE; j++){
        bla = Pal.get_random_color();
  stroke(bla);
      //setFillColor(aa,bb,cc,dd,random(0,1),255);
      color blou = Pal.get_random_color();
      while (blou == back){
      blou = Pal.get_random_color();
      }
      fill(blou);
      push();
      translate((SIZE+SPACE)*(i+1),(SIZE+SPACE)*(j+1));
      
      noStroke();
      if (random(0,1) > 0.3){
      square(0+random(-shift,shift),0+random(-shift,shift),SIZE);
      }
      else{
         circle(SIZE/2+random(-shift,shift),SIZE/2+random(-shift,shift),SIZE); 
      }
        stroke(back);
        translate(SIZE/2,SIZE/2);
        rotate(tan(1/phase*((i-NOMBRE/2)^2 + (j-NOMBRE/2)^2)));
       //rotate(PI*noise(xoff+i/phase,yoff+j/phase));
       line(-SIZE/1.41,0,SIZE/1.41,0);
      pop();
    }
  }

 
  if (record == true){
    endRecord();
  }
}

void keyPressed() {
  if (key == 'e') {
    exit();
  }
  if (key == 'r'){
   record = !record; 
  }
  if (key == 'g'){
   SEED = int(random(0,1000000)); 
  }
  
  if (key == 'a') {
    display = !display;
  }
}
