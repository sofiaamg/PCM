import processing.video.*;
 
Movie movie;
Movie movie2;
int fadeStartTime = 0;
int fadeDuration = 3000; // 3 seconds
 
void setup() {
  size(640, 720);
  textAlign(CENTER,CENTER);
 
  // Load and play each video in a loop
  movie = new Movie(this, "PCMLab11-1.mov");
  movie.loop();
  movie.volume(0);
  movie2 = new Movie(this, "PCMLab11-2.mov");
  movie2.loop();
  movie2.volume(0);
}
 
void movieEvent(Movie m) {
  m.read();
}
 
void draw() {
  // clear screen
  background(0);
 
  // calculate fader level 0-255 based on time since last keypress
  float fader = map( millis()-fadeStartTime, 0, fadeDuration, 255, 0 );
  fader = constrain( fader, 0, 255 );
 
  if(fader < 255){
    // fade movie image and display
    tint(255, 255-fader);
    image(movie, 0, 0, width, height/2);
  }
 
  if(fader > 0){
    // fade movie image and display
    tint(255, fader);
    image(movie2, 0, height/2, width, height);
  }

  text("Press any key to reset fades", width/2, height/2);
}

void keyPressed(){
  fadeStartTime = millis();
}
