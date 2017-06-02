float startDist = 100;  //begin drawing when dist exceeds this number
float stopDist = 5;  //stop drawing when dist drops below this number

void triggerInput(PVector _p) {
  if(!trigger){
    triggerPressed(_p.x, _p.y);
  }
  else if(trigger){
    triggerDragged(_p.x, _p.y);
  }
}


//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void triggerPressed(float _x, float _y) {
  trigger = true;
  currentGestureID = (currentGestureID+1)%nGestures;
  Gesture G = gestureArray[currentGestureID];
  G.clear();
  G.clearPolys();
  G.addPoint(_x, _y);
}

void triggerDragged(float _x, float _y) {
  trigger = true;
  if (currentGestureID >= 0) {
    Gesture G = gestureArray[currentGestureID];
    if (G.distToLast(_x, _y) > minMove) {
      G.addPoint(_x, _y);
      G.smooth();
      G.compile();
    }
  }
}

void triggerReleased() {
  trigger = false;
}


void keyPressed() {
  //~~~~~~~~~~~~~~~
  if (key=='+'||key=='=') {
    if (currentGestureID >= 0) {
      float th = gestureArray[currentGestureID].thickness;
      gestureArray[currentGestureID].thickness = Math.min(96, th+1);
      gestureArray[currentGestureID].compile();
    }
  }
  if (key=='-') {
    if (currentGestureID >= 0) {
      float th = gestureArray[currentGestureID].thickness;
      gestureArray[currentGestureID].thickness = Math.max(2, th-1);
      gestureArray[currentGestureID].compile();
    }
  }
  
  if(key==' '){
    renderTex = !renderTex;
  }
}

void keyReleased(){
  if (keyCode==33) {
    triggerReleased();
  }
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

void mousePressed() {
  triggerPressed(mouseX, mouseY);
}

void mouseDragged() {
  triggerDragged(mouseX, mouseY);
}

void mouseReleased() {
  canvas = get();
  clearGestures();
  triggerReleased();
}

