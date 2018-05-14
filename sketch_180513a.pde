 /*
import processing.video.*;
Movie myMovie;


int numPixels;
int[] previousFrame;
Movie video;

void setup() {
  size(640, 480);
  video = new Movie(this, "PCMLab10.mov");
  video.loop();
  numPixels = video.width * video.height;
  // Create an array to store the previously captured frame
  previousFrame = new int[numPixels];
  loadPixels();
}


void draw() {
    image(video, 0, 0);
    surface.setSize(video.width, video.height);
    H_Diff();
    video.loadPixels(); // Make its pixels[] array available
    

}

void movieEvent(Movie m) {
  m.read();
}


void H_Diff(){//){

    int Histogram_differences = 0; // Amount of movement in the frame
    for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
      color currColor = video.pixels[i];
      color prevColor = previousFrame[i];
      // Extract the red, green, and blue components from current pixel
      int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract red, green, and blue components from previous pixel
      int prevR = (prevColor >> 16) & 0xFF;
      int prevG = (prevColor >> 8) & 0xFF;
      int prevB = prevColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);
      
      // Add these differences to the running tally
      //Histogram_differences += diffR + diffG + diffB;
      // Render the difference image to the screen
      //previousFrame[i] = currColor;
      println(diffR); // Print the total amount of movement to the console
      //if(Histogram_differences>Ts)
    }
}*/



import processing.video.*;
// Variable for capture device
Movie video;
// Previous Frame
PImage prevFrame;
float threshold = 50;

void setup() {
  size(640, 480);
  video = new Movie(this, "PCMLab10.mov");
  video.loop();
  // Create an array to store the previously captured frame
  loadPixels();
  prevFrame = createImage(video.width, video.height, RGB);
}

void captureEvent(Capture video) {
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height); 
  prevFrame.updatePixels();  // Read image from the video
  video.read();
}

void draw() {

  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {

      int loc = x + y*video.width;           
      color current = video.pixels[loc];    
      color previous = prevFrame.pixels[loc]; 

      float r1 = red(current); 
      float g1 = green(current); 
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous); 
      float b2 = blue(previous);
      
      float diff = dist(r1, g1, b1, r2, g2, b2);

      println(diff);
    }
  }
  updatePixels();
}
