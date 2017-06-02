// based on "Yellowtail," by Golan Levin. 

import java.awt.*;
//import processing.opengl.*;

PShader fx;

int sW = 960;
int sH = 540;
int fps = 60;
boolean trigger = false;
boolean renderTex = false;

Gesture gestureArray[];
final int nGestures = 1;  // Number of gestures
final int minMove = 3;     // Minimum travel for a new point
int currentGestureID;

PImage canvas;
PImage tex;

color bgColor = color(235);
color fgColor = color(0,245);

Polygon tempP;
int tmpXp[];
int tmpYp[];

void setup(){
  size(50,50,P3D);
  surface.setSize(sW, sH);
  frameRate(fps);

  currentGestureID = -1;
  gestureArray = new Gesture[nGestures];
  for (int i=0; i<nGestures; i++){
    gestureArray[i] = new Gesture(sW, sH);
  }
  clearGestures();
  background(bgColor);
  canvas = createImage(width,height,RGB);
  //canvas = get(0,0,width,height);
  tex = loadImage("test.png");
  textureMode(NORMAL);
  fx = loadShader("bloom.glsl");
  fx.set("samples", 5);
  fx.set("quality", 2.5);
  //fx.set("samples", 10);
}

void draw(){
  //image(canvas,0,0);
 
  updateGeometry();
  noStroke();
  fill(fgColor);
  for (int G=0; G<nGestures; G++){
    renderGesture(gestureArray[G],sW,sH);
  }
  
  //fx.set("texture", get());
  //filter(fx);
}