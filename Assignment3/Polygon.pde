class Polygon extends TangibleObject {
  int sideCount; //The number of sides on the polygon
  float radius; //The size of the polygon
  
  boolean isLeftClick; //When this spawned, was left click held down?
  boolean isFocused; //Is this polygon currently being focused?
  
  float rotation; //The current rotation of the polygon
  float rotSpd; //Rotation speed, clockwise is positive
  int tick; //Number of times update has been called.
  
  Polygon(float x, float y) {
    super(x, y);
    sideCount = int(random(3, 11));
    radius = 30; //Starting value of radius.
    
    isLeftClick = mouseState.get("Left Click");
    isFocused = true;
    
    rotSpd = random(1) * 360 * (isLeftClick ? -1 : 1);
    rotation = 0;
    
    pos.z = main.currentZ + random(15);
    main.currentZ = pos.z;
    
    palette.put("Random Colour 1", randColour());
    palette.put("Random Colour 2", randColour());
  }
  
  @Override void update() {
    rotation += rotSpd * deltaTime;
    isFocused = isFocused && mouseState.get(isLeftClick ? "Left Hold" : "Right Hold");
    if (isFocused) {
      float newRad = pos.dist(new PVector(mouseX, mouseY, pos.z));
      radius = clamp(newRad, 30, 100);
    }
    tick++;
  }
  
  @Override void display() {
    PVector location = new PVector();
    switch(main.currentMode.message) {
      case "2D Mode":
      location = pos;
      break;
      
      case "Ending Mode":
      if (main.currentZ < pos.z || pos.z < main.frontZ) {
        return;
      }
            
      case "Parallax Mode":
      float divZ = main.currentZ - pos.z;
      divZ = divZ == 0 ? 1 : divZ;
      float offsetX = (main.parallaxMouse.x - pos.x) / divZ;
      float offsetY = (main.parallaxMouse.y - pos.y) / divZ;
      
      location.x = pos.x + offsetX;
      location.y = pos.y + offsetY;
      break;
    }
    
    translate(location.x, location.y);
    
    rotate(radians(rotation));
    color col = lerpColor(palette.get("Random Colour 1"), palette.get("Random Colour 2"), abs(sin(radians(tick))));
    fill(col);
    stroke(palette.get("White"));
    
    beginShape();
    float theta = 0;
    for (int i = 0; i < sideCount; i++) {
      vertex(cos(theta) * radius, sin(theta) * radius);
      theta += TWO_PI / sideCount;
    }
    endShape(CLOSE);
    
    resetMatrix();//Reset the canvas back to its original state
  }
}
