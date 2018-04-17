PImage imagePCM;
String[] lines;

// We made some changes on the display of the image:
// Now we can see each histogram labeled according to its representations
// We changed the colors of the bars and now they're ordered by hue
// We fixed the representation of the CMYK histograms 

void setup(){
  imagePCM = loadImage("PCMLab7.png");
  lines = loadStrings("lab7.txt");
  noLoop();
  surface.setSize(imagePCM.width*5+25, imagePCM.height*2+40);
  background(51);
}

void draw(){
  image(imagePCM, 0, 0);
  lum_hist(imagePCM);
  rgb_histogram(imagePCM);
  cmy_histogram(imagePCM);
}

void lum_hist(PImage imagePCM){
  int where;
  float r,g,b;
  float Y;
  int[] hist = new int[256];
  
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
  
  int hMax = max(hist);

  for (int i = 0; i < imagePCM.width; i ++) {
    int which = int(map(i, 0, imagePCM.width, 0, 255));
    int y = int(map(hist[which], 0, hMax, imagePCM.height, 0));
    stroke((hist[i]*255)/hMax);
    line(i+imagePCM.width+5, imagePCM.height, i+imagePCM.width+5, y);
  }
  
  fill(0);
  text(lines[0], imagePCM.width+textWidth(lines[0])/2-5, imagePCM.height+15);
}

void rgb_histogram(PImage img){
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
      
      for (int i = 0; i < img.width; i ++) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_r[which], 0, histMax_r, img.height, 0));
        stroke((hist_r[i]*255)/histMax_r, 0, 0);
        line(i+img.width*2+10, img.height, i+img.width*2+10, y);
      }
      
      fill(0);
      text(lines[1], imagePCM.width*2+textWidth(lines[1])-10, imagePCM.height+15);
      
      for (int i = 0; i < img.width; i ++) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_g[which], 0, histMax_g, img.height, 0));
        stroke(0,(hist_g[i]*255)/histMax_g,0);
        line(i+img.width*3+15, img.height, i+img.width*3+15, y);
      }
      
      fill(0);
      text(lines[2], imagePCM.width*3+textWidth(lines[2])-15, imagePCM.height+15);
      
      for (int i = 0; i < img.width; i ++) {
        int which = int(map(i, 0, img.width, 0, 255));
        int y = int(map(hist_b[which], 0, histMax_b, img.height, 0));
        stroke(0,0,(hist_b[i]*255)/histMax_b);
        line(i+img.width*4+20, img.height, i+img.width*4+20, y);
      }
      
      fill(0);
      text(lines[3], imagePCM.width*4+textWidth(lines[3])-20, imagePCM.height+15);
      
}

void cmy_histogram(PImage img){
  int where;
  float r,g,b;
  float C,M,Y,K;
  int[] hist_c = new int[256];
  int[] hist_m = new int[256];
  int[] hist_y = new int[256];
  int[] hist_k = new int[256];
  
  img.loadPixels();
  loadPixels(); 
  
  // Calculate the histogram
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      where = i+j*imagePCM.width;
  
      // Get the pixel color
      r=red(imagePCM.pixels[where]); 
      g=green(imagePCM.pixels[where]);
      b=blue(imagePCM.pixels[where]);
      
      C = 1 - ( r/ 255 );
      M = 1 - ( g / 255 );
      Y = 1 - ( b / 255 );
      
      float var_K = 1;
        
      if ( C < var_K )   var_K = C;
      if ( M < var_K )   var_K = M;
      if ( Y < var_K )   var_K = Y;
      
      if(var_K == 0){
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
  
  
  for (int i = 0; i < img.width; i++) {
    int which = int(map(i, 0, img.width, 0, 255));
    int y = int(map(hist_c[which], 0, histMax_c, img.height, 0));
    stroke(0,(hist_c[i]*255)/histMax_c,(hist_y[i]*255)/histMax_y);
    line(i, img.height*2+20, i, y+img.height+20);
  }
  
  fill(0);
  text(lines[4], textWidth(lines[4])/2, imagePCM.height*2+35);
  
  for (int i = 0; i < img.width; i++) {
    int which = int(map(i, 0, img.width, 0, 255));
    int y = int(map(hist_m[which], 0, histMax_m, img.height, 0));
    stroke((hist_m[i]*255)/histMax_m, 0, (hist_m[i]*255)/histMax_m);
    line(i+img.width+5, img.height*2+20, i+img.width+5, y+img.height+20);
  }
  
  fill(0);
  text(lines[5],imagePCM.width+textWidth(lines[5])/2, imagePCM.height*2+35);
  
  for (int i = 0; i < img.width; i++) {
    int which = int(map(i, 0, img.width, 0, 255));
    int y = int(map(hist_y[which], 0, histMax_y, img.height, 0));
    stroke((hist_c[i]*255)/histMax_c, (hist_c[i]*255)/histMax_c, 0);
    line(i+img.width*2+10, img.height*2+20, i+img.width*2+10, y+img.height+20);
  }
  
  fill(0);
  text(lines[6],imagePCM.width*2+textWidth(lines[6])/2, imagePCM.height*2+35);
   
  for (int i = 0; i < img.width; i++) {
    int which = int(map(i, 0, img.width, 0, 255));
    int y = int(map(hist_k[which], 0, histMax_k, img.height, 0));
    stroke((hist_k[i]*255)/histMax_k);
    line(i+img.width*3+15, img.height*2+20, i+img.width*3+15, y+img.height+20);
  }
  
  fill(0);
  text(lines[7],imagePCM.width*3+textWidth(lines[7])/2, imagePCM.height*2+35);

}
