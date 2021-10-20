//Called at the end of every loop.
void updateMouseStates() {
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
