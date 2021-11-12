/*
NOTE:
  - This only works on Processing 4.
  - This program scales according to your screen resolution.
    - The text however does not scale properly. However, algorithms were made to "try" to scale.
      - Most resolution should be fine. A safe resolution would be: size(1366, 768)
    - The program takes 80% of your screen resolution (both width and height)
      - During development, the program scaled to size(2189, 1459).

Inspiration: The parallax effect used in games.
*/

import java.util.Iterator; //Needed to iterate through the arraylist and delete references.

HashMap<Character, Boolean> keyStates; //Keeps track of the states for all the keyboard keys.
ArrayList<KeyboardComponent> keyExecutor; //Executes all things added into the list.
PVector mousePos; //The position of the mouse
HashMap<String, Boolean> mouseState; //The state of the mouse

Main main; //The main program

float deltaTime; //Time since last draw loop (iteration)
long time; //Time since program started

//The program was created with 80% of the screen width, this is used to scale to support other resolutions
final float OWidth = 2189;

void settings() { //Allows the size of the canvas to be a variable. Scales accoring to screen resolution.
  size(round(displayWidth * 0.8), round(displayHeight * 0.8));
}

void setup() {
  keyStates = new HashMap<Character, Boolean>();
  keyExecutor = new ArrayList<KeyboardComponent>();
  
  mouseState = new HashMap<String, Boolean>();
  mouseState.put("Left Hold", false);
  mouseState.put("Right Hold", false);
  mouseState.put("Moved", false);
  mouseState.put("OnWindow", true);
  updateMouseStates();
  
  main = new Main();
}

void draw() {
  main.blit(); //The main update function.
  updateMouseStates(); //Ensures certain mouse states.
  getDeltaTime(); //Get the time since last loop.
}
