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

void keyPressed() {
  if (keyStates.containsKey(key) && keyStates.get(key)) { //Ensures that the held button does not execute more than once.
    return;
  }
  
  keyStates.put(key, true);
  for (KeyboardComponent actor : keyExecutor) {
    actor.doInput();  
  }
}

void keyReleased() {
  keyStates.put(key, false);
}
