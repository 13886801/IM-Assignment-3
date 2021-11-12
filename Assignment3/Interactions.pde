void mousePressed() {
  switch(mouseButton) {
    case LEFT:
      mouseState.put("Left Click", mouseButton == LEFT);
      mouseState.put("Left Hold", mouseButton == LEFT);
      return;
    case RIGHT:
      mouseState.put("Right Click", mouseButton == RIGHT);
      mouseState.put("Right Hold", mouseButton == RIGHT);
      return;
  }
}

void mouseReleased() {
  switch (mouseButton) {
    case LEFT:
      mouseState.put("Left Hold", false);
      return;
    case RIGHT:
      mouseState.put("Right Hold", false);
      return;
  }
}

void mouseWheel(MouseEvent event) { //This might get reversed on other platforms
  main.updateSensitivity(-event.getCount() * 20);
}

//Detects if the mouse is on the window or not.
//Helps get rid of the bug when hovering over a button and leaving the window.
void mouseEntered() {
  mouseState.put("OnWindow", true);
}

void mouseExited() {
  mouseState.put("OnWindow", false);
}

void keyPressed() {
  if (keyStates.containsKey(key) && keyStates.get(key)) { //Ensures that the held button does not execute more than once.
    return;
  }
  
  keyStates.put(key, true);
  for (KeyboardComponent actor : keyExecutor) {
    actor.doInput(key);  
  }
}

void keyReleased() {
  keyStates.put(key, false);
}
