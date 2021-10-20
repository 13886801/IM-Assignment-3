class Polygon extends TangibleObject {
  int sideCount;
  float radius;
  PGraphics polygon;
  
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
    
    palette.put("Random Colour", color(random(256), random(256), random(256)));
  }
  
  @Override void update() {
    rotation += rotSpd * deltaTime;
    isFocused = isFocused && mouseState.get(isLeftClick ? "Left Hold" : "Right Hold");
    if (isFocused) {
      float newRad = pos.dist(new PVector(mouseX, mouseY));
      radius = min(max(30, newRad), 200);
    }
  }
  
  @Override void display() {
    translate(pos.x, pos.y);
    rotate(radians(rotation));

    float theta = 0;
    fill(palette.get("Random Colour"));
    stroke(palette.get("White"));
    
    beginShape();
    for (int i = 0; i < sideCount; i++) {
      vertex(cos(theta) * radius, sin(theta) * radius);
      theta += TWO_PI / sideCount;
    }
    endShape(CLOSE);
    
    noStroke();
    resetMatrix();//Reset the canvas back to it's original state
  }
}
