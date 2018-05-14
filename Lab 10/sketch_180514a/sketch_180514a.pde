import processing.video.*;
Movie myMovie;
String[] times = {};
String aux;
int segment = 1;

void setup() {
  size(960, 540);
  frameRate(60);
  myMovie = new Movie(this, "PCMLab10.mov");
  myMovie.play();
  //noLoop();
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
  }
  image(myMovie, 0, 0, myMovie.width, myMovie.height);
  stroboscopic_segmentation();
}

void stroboscopic_segmentation(){
  float md = myMovie.duration();
  float mt = myMovie.time();

  if((floor(mt)%4) == 0){
    saveFrame("frame-######.png");
    
    aux = "Segment "+segment+": 00:00:"+nf(mt, 0, 2);
    append(times, aux);
    print(times[segment-1]);
    print(aux+"\n");
    myMovie.jump(ceil(mt)+4);
    segment++;
    aux = "";
  }
  
  if(ceil(mt) == ceil(md)){
    print("fim");
    saveStrings("#1.txt", times);
    exit();
  }

}
