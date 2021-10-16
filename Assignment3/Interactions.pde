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
