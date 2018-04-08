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
  contrast(imagePCM, 5);
  
  // Global thresholding
  thresholding(imagePCM);
  
  // Extra effect
  extra(imagePCM);
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
      // Calculating the 1D location from a 2D grid
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

void thresholding(PImage imagePCM){
  int i, j;
  int where; 
  float c;
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
      
      // We summed the 3 values to get the color and divided by 255*3 since each of them has a range 0-255
      c = (r+g+b)/(255*3);
                  
      if(c<0.5){
        // If it's lower than the threshold, set to white
        pixels[where] = color(0,0,0);
      } else{
        // If it's higher than the threshold, set to white
        pixels[where] = color(255,255,255);
      }
    }
  }
  updatePixels();
}

void extra(PImage imagePCM){
  int i, j;
  int where; 
  float c;
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
                  
      if(i<imagePCM.width/2){
        // Half of the image is colored as original image
        pixels[where] = color(r,g,b);
      } else{
        // The other half is a negative of the original
        r=255-r;
        g=255-g;
        b=255-b;
        
        // Make sure that color range is 0-255
        r = constrain(r, 0, 255);
        g = constrain(g, 0, 255);
        b = constrain(b, 0, 255);
        
        pixels[where] = color(r,g,b);
      }
    }
  }
  updatePixels();
}
