PImage imagePCM;

void setup(){
  imagePCM = loadImage("PCMLab6.png");
  noLoop();
  surface.setSize(imagePCM.width, imagePCM.height);
}

void draw(){
  image(imagePCM, 0, 0);
  grayscale(imagePCM);
}

void grayscale(PImage imagePCM){
  int i, j;
  int where; 
  float r,g,b;
  
  imagePCM.loadPixels();
  loadPixels();  
  
  for(i=0; i<imagePCM.width; i++){
    for(j=0; j<imagePCM.height; j++){
      where = i+j*imagePCM.width;
      
      r=red(imagePCM.pixels[where]); 
      g=green(imagePCM.pixels[where]);
      b=blue(imagePCM.pixels[where]);
      
      r = constrain(0.3*r, 0, 255);
      g = constrain(0.59*g, 0, 255);
      b = constrain(0.11*b, 0, 255);
      
      pixels[where] = color(r,g,b);
    }
  }
  updatePixels();
}
