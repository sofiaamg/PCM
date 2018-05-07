PImage img;
int pixeles;
int x,y,yinc;
void setup()
{
  background(255);
  noStroke();
  img = loadImage("PCMLab9.png");
  img.resize(220,300);
  surface.setSize(img.width, img.height);

}
void draw()
{
    //pixelateImage(20);
    pixelateImageColor("red");
    //HSB1(20,30,20);
}

void pixelateImage(int pxSize){
loadPixels();
  pixeles=pxSize;
  for(int i=0;i<pixeles;i++)
  { 
    for(int j=0;j<pixeles;j++)
    {
      
      float r = red(img.pixels[((height/pixeles)*(j))*(width)+(width/pixeles*(i))]);
      float g = green(img.pixels[((height/pixeles)*(j))*(width)+(width/pixeles*(i))]);
      float b = blue(img.pixels[((height/pixeles)*(j))*(width)+(width/pixeles*(i))]);
      fill(r,g,b);
      rect((width/pixeles*(i)),(height/pixeles)*(j),width/pixeles,height/pixeles);

      yinc=(height/pixeles)*j;
      
    }
  }
}

  void pixelateImageColor(String color1){
loadPixels();
  pixeles=100;
  for(int i=0;i<pixeles;i++)
  { 
    for(int j=0;j<pixeles;j++)
    {
      
      float r = red(img.pixels[((height/pixeles)*(j))*(width)+(width/pixeles*(i))]);
      float g = green(img.pixels[((height/pixeles)*(j))*(width)+(width/pixeles*(i))]);
      float b = blue(img.pixels[((height/pixeles)*(j))*(width)+(width/pixeles*(i))]);
      if (color1=="red"){
        fill(r,0,0);}
      else if(color1=="green"){
        fill(0,g,0);}
       else if(color1=="blue"){
        fill(0,0,b);
       }
      rect((width/pixeles*(i)),(height/pixeles)*(j),width/pixeles,height/pixeles);
      /*
      R = r/255;
      G = g/255;
      B = b/255;
      If Red is max,Hue = (G-B)/(max-min)
      If Green is max, then Hue = 2.0 + (B-R)/(max-min)
      If Blue is max, then Hue = 4.0 + (R-G)/(max-min)*/
      yinc=(height/pixeles)*j;
      
    }
  }
}
