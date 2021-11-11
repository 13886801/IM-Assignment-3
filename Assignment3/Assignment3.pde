/*
NOTE: This only works on Processing 4.

Inspiration: The parallax effect used in games.
*/

HashMap<Character, Boolean> keyStates; //Keeps track of the states for all the keyboard keys.
ArrayList<Entity> keyExecutor; //Executes all things added into the list.
PVector mousePos; //The position of the mouse
HashMap<String, Boolean> mouseState; //The state of the mouse

Main main;

float deltaTime; //Time since last draw loop (iteration)
long time; //Time since program started

void settings() { //Allows the size of the canvas to be a variable.
  size(round(displayWidth * 0.9), round(displayHeight * 0.9));
}

void setup() {
  keyStates = new HashMap<Character, Boolean>();
  keyExecutor = new ArrayList<Entity>();
  
  mouseState = new HashMap<String, Boolean>();
  mouseState.put("Left Hold", false);
  mouseState.put("Right Hold", false);
  mouseState.put("Moved", false);
  updateMouseStates();
  
  main = new Main();
}

void draw() {
  main.blit(); //The main update function.
  updateMouseStates(); //Ensures certain mouse states.
  getDeltaTime(); //Get the time since last loop.
}
