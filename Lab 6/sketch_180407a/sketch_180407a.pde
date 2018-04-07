PImage imagePCM;

void setup(){
  imagePCM = loadImage("PCMLab6.jpg");
  noLoop();
  surface.setSize(imagePCM.width, imagePCM.height);
}

void draw(){
  image(imagePCM, 0, 0);
}
