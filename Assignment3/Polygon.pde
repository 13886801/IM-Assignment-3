class Polygon extends TangibleObject {
  int sideCount;
  float radius;
  
  boolean isLeftClick;
  boolean isFocused;
  
  float rotation;
  float rotSpd; //Rotation speed, clockwise is positive
  
  Polygon(float x, float y) {
    super(x, y);
    sideCount = int(random(3, 11)); //TODO: Somehow link this to the UIArea for the sliders.
    radius = 30; //Starting value of radius.
    
    isLeftClick = mouseState.get("Left Click");
    isFocused = true;
    
    rotSpd = random(1) * 360 * (isLeftClick ? -1 : 1);
    rotation = 0;
    
    palette.put("Random Colour", color(randomColour(), randomColour(), randomColour()));
  }
  
  @Override void update() {
    rotation += rotSpd * deltaTime;
    isFocused = isFocused && mouseState.get(isLeftClick ? "Left Hold" : "Right Hold");
  }
  
  @Override void display() {
    float theta = 0;
    translate(x, y);
    rotate(radians(rotation));
    fill(palette.get("Random Colour"));
    stroke(palette.get("White"));
    beginShape();
    for (int i = 0; i < sideCount; i++) {
      vertex(cos(theta) * radius, sin(theta) * radius);
      theta += TWO_PI/sideCount;
    }
    endShape(CLOSE);
    hideStroke();
    resetMatrix();//Reset the canvas back to it's original state
  }
}
