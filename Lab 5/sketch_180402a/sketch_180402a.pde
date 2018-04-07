PImage imagePCM;
String[] lines;
PShape owl;

void setup(){
  imagePCM = loadImage("pcm.jpg");
  noLoop();
  surface.setSize(imagePCM.width, imagePCM.height);
  lines = loadStrings("pcm.txt");
  owl = loadShape("owl.svg");
}

void draw(){
  tint(0, 140, 200);
  image(imagePCM, 0, 0);
  fill(#000000);
  text(lines[0], 5, imagePCM.height-5);
  smooth();
  shape(owl, 5, 5, 110, 120);
}
