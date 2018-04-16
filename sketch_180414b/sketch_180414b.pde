PImage imagePCM;

void setup(){
  imagePCM = loadImage("PCMLab7.png");
  noLoop();
  surface.setSize(imagePCM.width, imagePCM.height);
}

void draw(){
  image(imagePCM, 0, 0);
  //lum_hist(imagePCM);
  //rgb_histogram(imagePCM);
  cmy_histogram(imagePCM);
}

void lum_hist(PImage imagePCM){
  int where;
  float r,g,b;
  float Y;
  int[] hist = new int[256];
  
  grayscale(imagePCM);
  
  imagePCM.loadPixels();
  loadPixels();  
  
  for (int i = 0; i < imagePCM.width; i++) {
    for (int j = 0; j < imagePCM.height; j++) {
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
      
      hist[int(Y)]++; 
    }
  }
  
  // Find the biggest value
  int hMax = max(hist);
  int[] sorted = sort(hist);
  
  stroke(255);
  for (int i = 0; i < imagePCM.width; i +=2) {
    int which = int(map(i, 0, imagePCM.width, 0, 255));
    int y = int(map(hist[which], 0, hMax, imagePCM.height, 0));
    line(i, imagePCM.height, i, y);
  }
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

void rgb_histogram(PImage img){
      image(img, 0, 0);
      int[] hist_r = new int[256];
      int[] hist_g = new int[256];
      int[] hist_b = new int[256];
      
      // Calculate the histogram
      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          int red = int(red(get(i, j)));
          int green = int(green(get(i, j)));
          int blue = int(blue(get(i, j)));
          hist_r[red]++; 
          hist_g[green]++; 
          hist_b[blue]++; 
        }
      }
      
      // Find the largest value in the histogram
      int histMax_r = max(hist_r);
      int histMax_g = max(hist_g);
      int histMax_b= max(hist_b);
      
      stroke(255,000,000);
      for (int i = 0; i < img.width; i += 2) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_r[which], 0, histMax_r, img.height, 0));
        line(i, img.height, i, y);
      }
      
      stroke(000,255,000);
      for (int i = 0; i < img.width; i += 2) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_g[which], 0, histMax_g, img.height, 0));
        line(i, img.height, i, y);
      }
      
      stroke(000,000,255);
      for (int i = 0; i < img.width; i += 2) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_b[which], 0, histMax_b, img.height, 0));
        line(i, img.height, i, y);
      }
}

void cmy_image(PImage img){

      int i, j;
      int where; 
      float r,g,b;
      float C,M,Y,K;
      imagePCM.loadPixels();
      loadPixels();  
      
      for(i=0; i<img.width; i++){
        for(j=0; j<img.height; j++){
          where = i+j*img.width;
          
          r=red(img.pixels[where]); 
          g=green(img.pixels[where]);
          b=blue(img.pixels[where]);
          
          r = constrain(r, 0, 255);
          g = constrain(g, 0, 255);
          b = constrain(b, 0, 255);
          
          C = 1 - ( r/ 255 );
          M = 1 - ( g / 255 );
          Y = 1 - ( b / 255 );
          
          float var_K = 1;
            
            if ( C < var_K )   var_K = C;
            if ( M < var_K )   var_K = M;
            if ( Y < var_K )   var_K = Y;
            if ( var_K == 1 ) {
                C = 0;       //Black only
                M = 0;
                Y = 0;
            }
            else {
                C = ( C - var_K ) / ( 1 - var_K );
                M = ( M - var_K ) / ( 1 - var_K );
                Y = ( Y - var_K ) / ( 1 - var_K );
            }
            K = var_K;
          
          C=C*255;
          M=M*255;
          Y=Y*255;
          K=K*255;
          
          pixels[where] = color(C,M,Y,K);
        }
      }
      updatePixels();
}

void cmy_histogram(PImage img){
      float r,g,b;
      float C,M,Y,K;
      int[] hist_c = new int[256];
      int[] hist_m = new int[256];
      int[] hist_y = new int[256];
      int[] hist_k = new int[256];
      
      //cmy_image(img);
      img.loadPixels();
      loadPixels(); 
  
      // Calculate the histogram
      for (int i = 0; i < img.width; i++) {
        for (int j = 0; j < img.height; j++) {
          r = int(red(get(i, j)));
          g = int(green(get(i, j)));
          b = int(blue(get(i, j)));
          
          r = constrain(r, 0, 255);
          g = constrain(g, 0, 255);
          b = constrain(b, 0, 255);
          
          C = 1 - ( r/ 255 );
          M = 1 - ( g / 255 );
          Y = 1 - ( b / 255 );
          
          float var_K = 1;
            
            if ( C < var_K )   var_K = C;
            if ( M < var_K )   var_K = M;
            if ( Y < var_K )   var_K = Y;
            if ( var_K == 1 ) {
                C = 0;       //Black only
                M = 0;
                Y = 0;
            }
            else {
                C = ( C - var_K ) / ( 1 - var_K );
                M = ( M - var_K ) / ( 1 - var_K );
                Y = ( Y - var_K ) / ( 1 - var_K );
            }
            K = var_K;
          
          C=C*255;
          M=M*255;
          Y=Y*255;
          K=K*255;
          
          hist_c[int(C)]++; 
          hist_m[int(M)]++; 
          hist_y[int(Y)]++; 
          hist_k[int(K)]++; 
        }
      }
      
      // Find the largest value in the histogram
      int histMax_c = max(hist_c);
      int histMax_m = max(hist_m);
      int histMax_y = max(hist_y);
      int histMax_k = max(hist_k);
      
      stroke(0);
      for (int i = 0; i < img.width; i += 2) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_k[which], 0, histMax_k, img.height, 0));
        line(i, img.height, i, y);
      }
      
      stroke(0,0,255);
      for (int i = 0; i < img.width; i += 2) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_c[which], 0, histMax_c, img.height, 0));
        line(i, img.height, i, y);
      }
      
      stroke(255,255,0);
      for (int i = 0; i < img.width; i += 2) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_m[which], 0, histMax_m, img.height, 0));
        line(i, img.height, i, y);
      }
      
      stroke(0,0,255);
      for (int i = 0; i < img.width; i += 2) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_y[which], 0, histMax_y, img.height, 0));
        line(i, img.height, i, y);
      }
 
}
