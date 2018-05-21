import processing.video.*;
Movie mov1, mov2;
PImage m;
int frames = 0;

void setup() {
  size(960,540);
  frameRate(60);
  mov1 = new Movie(this, "PCMLab11-1.mov");
  mov2 = new Movie(this, "PCMLab11-2.mov");
  mov1.play();
  mov2.play();
}

void draw() {
  //wipe_effect();
  //fade_effect();
  //dissolve_effect();
  chroma_key();
}

void wipe_effect(){
  if(mov1.available()){
    mov1.read();
  }
  if(mov2.available()){
    mov2.read();
  }
  surface.setSize(mov1.width, mov1.height);
  image(mov2, 0,0, width, height);
  loadPixels();  
  if(frames<mov1.width){
    for (int x = 0; x < frames; x++ ) {
      for (int y = 0; y < mov1.height; y++ ) {
        int loc = x+y*mov1.width;
        color val = mov1.get(x,y);
        color c = color(red(val), green(val), blue(val));
        pixels[loc] = c;
      }
    }
    frames++;
  } else{
    for (int x = 0; x < mov1.width; x++ ) {
      for (int y = 0; y < mov1.height; y++ ) {
        int loc = x+y*mov1.width;
        color val = mov1.get(x,y);
        color c = color(red(val), green(val), blue(val));
        pixels[loc] = c;
      }
    }
  } 
  updatePixels(); 
}
void fade_effect(){
  if(mov1.available()){
    mov1.read();
  }
  if(mov2.available()){
    mov2.read();
  }
  fill(0,0,0);
  rect(0,0,mov1.width,mov1.width);
  surface.setSize(mov1.width, mov1.height);
  loadPixels();  
  if(mov2.time()>2){
    for (int x = 0; x < mov1.width; x++ ) {
      for (int y = 0; y < mov1.height; y++ ) {
        int loc = x+y*mov1.width;
        color val = mov1.get(x,y);
        color c = color(red(val), green(val), blue(val), (alpha(val)*0.5*frames)/255);
        pixels[loc] = c;
      }
    }
    frames++;
  } 
  updatePixels(); 
}

void dissolve_effect(){
  if(mov1.available()){
    mov1.read();
  }
  if(mov2.available()){
    mov2.read();
  }
  surface.setSize(mov1.width, mov1.height);
  image(mov2, 0,0, width, height);
  loadPixels();  
  if(mov2.time()>2){
    for (int x = 0; x < mov1.width; x++ ) {
      for (int y = 0; y < mov1.height; y++ ) {
        int loc = x+y*mov1.width;
        color val = mov1.get(x,y);
        color c = color(red(val), green(val), blue(val), (alpha(val)*0.5*frames)/255);
        pixels[loc] = c;
      }
    }
    frames++;
  } 
  updatePixels(); 
}

void chroma_key(){
  if(mov1.available()){
    mov1.read();
  }
  if(mov2.available()){
    mov2.read();
    m=mov2.get();
  }
  
  m.resize(mov1.width, mov1.height);
  
  surface.setSize(mov1.width, mov1.height);
  image(mov2, 0,0, width, height);
  loadPixels();  
  for (int x = 0; x < m.width; x++ ) {
    for (int y = 0; y < m.height; y++ ) {
      int loc = x+y*m.width;
      
      int red = (0xff0000&m.pixels[loc])>>16; // Get red
      int green = (0xff00&m.pixels[loc])>>8; // Get green
      int blue = 0xff&m.pixels[loc]; // Get blue
      
      if (green >= 215 && green >= red && green >= blue){
        pixels[loc] = mov1.pixels[loc];
      }
      
    }
  } 
  updatePixels(); 
}
