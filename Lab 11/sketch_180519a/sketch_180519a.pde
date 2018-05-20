import processing.video.*;
Movie mov1, mov2;
int frames = 0;
float threshold = 60;

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
  fade_effect();
  //dissolve_effect();
  //chroma_key();
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
  }
  surface.setSize(mov1.width, mov1.height);
  image(mov2, 0,0, width, height);
  loadPixels();  
  for (int x = 0; x < mov1.width; x++ ) {
    for (int y = 0; y < mov1.height; y++ ) {
      int loc = x+y*mov1.width;
      color fgColor = pixels[loc]; 
      color bgColor = mov2.pixels[loc];

      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
      float b2 = blue(bgColor);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      if (diff > threshold) {
        pixels[loc] = fgColor;
      } else {
        pixels[loc] = mov1.pixels[loc];
      }
    }
  } 
  updatePixels(); 
}
