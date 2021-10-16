//Called at the end of every loop. Ensures the click lasts one frame.
void resetClick() {
  mouseState.put("Left Click", false);
  mouseState.put("Right Click", false);
}

//Updates deltatime making timers frame independent.
void getDeltaTime() {
  long currentTime = millis(); //Miliseconds since the start of the program
  deltaTime = (currentTime - time) * 0.001f; //Multiplication needed to convert to seconds 
  time = currentTime;
}
