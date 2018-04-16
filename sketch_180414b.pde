PImage imagePCM;

void setup(){
  imagePCM = loadImage("PCMLab7.png");
  noLoop();
  surface.setSize(imagePCM.width, imagePCM.height);
}

void draw(){
  image(imagePCM, 0, 0);

  rgb_histogram(imagePCM);
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
      // Draw half of the histogram (skip every second value)
      for (int i = 0; i < img.width; i += 2) {
        // Map i (from 0..img.width) to a location in the histogram (0..255)
        int which = int(map(i, 0, img.width, 0, 255));
        // Convert the histogram value to a location between 
        // the bottom and the top of the picture
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
