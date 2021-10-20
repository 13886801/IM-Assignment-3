/*
NOTE: This only works on Processing 4.

Inspiration: The parallax effect used in games.
*/

Main main;
PVector mousePos; //The position of the mouse
HashMap<String, Boolean> mouseState; //The state of the mouse

float deltaTime; //Time since last draw loop (iteration)
long time; //Time since program started

void settings() { //Allows the size of the canvas to be a variable.
  size(round(displayWidth * 0.9), round(displayHeight * 0.9));
}

void setup() {
  main = new Main();
  mouseState = new HashMap<String, Boolean>();
  mouseState.put("Left Hold", false);
  mouseState.put("Right Hold", false);
  mouseState.put("Moved", false);
  updateMouseStates();
  noStroke();
}

void draw() {
  main.blit(); //The main update function.
  updateMouseStates(); //Ensures certain mouse states.
  getDeltaTime(); //Get the time since last loop.
  
  println(frameRate);                                    //DEBUG: Simply prints the framerate, get rid of this later
}
