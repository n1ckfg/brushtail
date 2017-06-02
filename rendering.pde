void renderGesture (Gesture gesture, int w, int h){
  if (gesture.exists){
    if (gesture.nPolys > 0){
      Polygon polygons[] = gesture.polygons;
      int crosses[] = gesture.crosses;

      int xpts[];
      int ypts[];
      Polygon p;
      int cr;

      beginShape(QUADS);
      if(renderTex) texture(tex);
      int gnp = gesture.nPolys;
      for (int i=0; i<gnp; i++){

        p = polygons[i];
        xpts = p.xpoints;
        ypts = p.ypoints;

        vertex(xpts[0], ypts[0], xpts[2], ypts[1]);
        vertex(xpts[1], ypts[1], xpts[3], ypts[2]);
        vertex(xpts[2], ypts[2], xpts[0], ypts[3]);
        vertex(xpts[3], ypts[3], xpts[1], ypts[0]);

        if ((cr = crosses[i]) > 0){
          if ((cr & 3)>0){
            vertex(xpts[0]+w, ypts[0], xpts[2]+w, ypts[0]);
            vertex(xpts[1]+w, ypts[1], xpts[3]+w, ypts[1]);
            vertex(xpts[2]+w, ypts[2], xpts[0]+w, ypts[2]);
            vertex(xpts[3]+w, ypts[3], xpts[1]+w, ypts[3]);

            vertex(xpts[0]-w, ypts[0], xpts[2]-w, ypts[0]);
            vertex(xpts[1]-w, ypts[1], xpts[3]-w, ypts[1]);
            vertex(xpts[2]-w, ypts[2], xpts[0]-w, ypts[2]);
            vertex(xpts[3]-w, ypts[3], xpts[1]-w, ypts[3]);
          }
          if ((cr & 12)>0){
            vertex(xpts[0], ypts[0]+h, xpts[2], ypts[0]+h);
            vertex(xpts[1], ypts[1]+h, xpts[3], ypts[1]+h);
            vertex(xpts[2], ypts[2]+h, xpts[0], ypts[2]+h);
            vertex(xpts[3], ypts[3]+h, xpts[1], ypts[3]+h);

            vertex(xpts[0], ypts[0]-h, xpts[2], ypts[0]-h);
            vertex(xpts[1], ypts[1]-h, xpts[3], ypts[1]-h);
            vertex(xpts[2], ypts[2]-h, xpts[0], ypts[2]-h);
            vertex(xpts[3], ypts[3]-h, xpts[1], ypts[3]-h);
          }

          // I have knowingly retained the small flaw of not
          // completely dealing with the corner conditions
          // (the case in which both of the above are true).
        }
      }
      endShape();
    }
  }
}

private void updateGeometry(){
  Gesture J;
  for (int g=0; g<nGestures; g++){
    if ((J=gestureArray[g]).exists){
      if (g!=currentGestureID){
        advanceGesture(J);
      } else if (!trigger){
        advanceGesture(J);
      }
    }
  }
}

void advanceGesture(Gesture gesture){
  // move a Gesture one step
  if (gesture.exists){ // check
    int nPts = gesture.nPoints;
    int nPts1 = nPts-1;
    Vec3f path[];
    float jx = gesture.jumpDx;
    float jy = gesture.jumpDy;

    if (nPts > 0){
      path = gesture.path;
      for (int i=nPts1; i>0; i--){
        path[i].x = path[i-1].x;
        path[i].y = path[i-1].y;
      }
      path[0].x = path[nPts1].x - jx;
      path[0].y = path[nPts1].y - jy;
      gesture.compile();
    }
  }
}

void clearGestures(){
  for (int i=0; i<nGestures; i++){
    gestureArray[i].clear();
  }
}

