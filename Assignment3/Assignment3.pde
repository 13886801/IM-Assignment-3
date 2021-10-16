/*
NOTE: This only works on Processing 4.

Inspiration: The parallax effect used in games.
*/

Main main;
HashMap<String, Boolean> mouseState; //The state of the mouse

void setup() {
  size(1800, 1000);
  main = new Main();
  mouseState = new HashMap<String, Boolean>();
  mouseState.put("Left Hold", false);
  mouseState.put("Right Hold", false);
  resetClick();
}

void draw() {
  main.blit(); //The main update function.
  resetClick(); //Ensures the click lasts one frame.
}
