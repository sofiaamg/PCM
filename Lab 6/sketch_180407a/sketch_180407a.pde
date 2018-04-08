PImage imagePCM;

void setup(){
  imagePCM = loadImage("PCMLab6.png");
  noLoop();
  surface.setSize(imagePCM.width, imagePCM.height);
}

void draw(){
  image(imagePCM, 0, 0);
  
  // Comment functions we do not want to show
  
  // Set to grayscale
  grayscale(imagePCM);
  
  // Change second parameter to get different contrasts
  contrast(imagePCM, 10);
}

void grayscale(PImage imagePCM){
  int i, j;
  int where; 
  float Y;
  float r,g,b;
  
  imagePCM.loadPixels();
  loadPixels();  
  
  // Go through every pixel of the image
  for(i=0; i<imagePCM.width; i++){
    for(j=0; j<imagePCM.height; j++){
      // Calculating the 1D location froma 2D grid
      where = i+j*imagePCM.width;
      
      // Get the pixel color
      r=red(imagePCM.pixels[where]); 
      g=green(imagePCM.pixels[where]);
      b=blue(imagePCM.pixels[where]);
      
      // Make sure that color range is 0-255
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      
      // Calculate luminance
      Y = 0.3*r+0.59*g+0.11*b;
      
      // Set pixel color
      pixels[where] = color(Y);
    }
  }
  updatePixels();
}

void contrast(PImage imagePCM, float contrast){
  int i, j;
  int where; 
  float r,g,b;
  
  imagePCM.loadPixels();
  loadPixels();  
  
  // Go through every pixel of the image
  for(i=0; i<imagePCM.width; i++){
    for(j=0; j<imagePCM.height; j++){
      // Calculating the 1D location from a 2D grid
      where = i+j*imagePCM.width;
      
      // Get the pixel color
      r=red(imagePCM.pixels[where]); 
      g=green(imagePCM.pixels[where]);
      b=blue(imagePCM.pixels[where]);
      
      // multiplication for contrast and addition for brightness
      r = contrast*(r-127)+127;
      g = contrast*(g-127)+127;
      b = contrast*(b-127)+127;
      
      // Make sure that color range is 0-255
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      
      // Set pixel color
      pixels[where] = color(r,g,b);
    }
  }
  updatePixels();
}
