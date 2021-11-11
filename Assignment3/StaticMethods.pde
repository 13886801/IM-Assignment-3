//Called at the end of every loop.
void updateMouseStates() {
  mouseState.put("Raycast", true); //Ensures only one button is pressed (if they were layered on top of each other.
  mouseState.put("Left Click", false); //Ensures the click lasts one frame.
  mouseState.put("Right Click", false);
  mouseState.put("Moved", !(pmouseX == mouseX && pmouseY == mouseY));
}

//Updates deltatime making timers frame independent.
void getDeltaTime() {
  long currentTime = millis(); //Miliseconds since the start of the program
  deltaTime = (currentTime - time) * 0.001f; //Multiplication needed to convert to seconds 
  time = currentTime;
}

//Returns a random colour.
Integer randColour() {
  return color(random(256), random(256), random(256));
}

//Returns a text size that scaled according to the screen size.
float scaleTextSize(float OriginalSize) {
  float size = OriginalSize;
  size *= width / OWidth;
  return size;
}

//Check for the key's state on the keyboard
boolean checkKey(char button) {
  return keyStates.containsKey(button) && keyStates.get(button);  
}
