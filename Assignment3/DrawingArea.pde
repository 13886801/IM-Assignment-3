class DrawingArea extends InteractableObject {
  ArrayList<Polygon> polygons; //The polygons in the area
  float locationSize; //The size of the circle
  
  DrawingArea(float x, float y, int w, int h) {
    super(x, y, w, h);
    
    polygons = new ArrayList<Polygon>();
    locationSize = 15;
    
    palette.put("Light Gray", color(64, 68, 75));
  }
  
  @Override boolean isClickedCheck() {
    return mouseState.get("Left Click") || mouseState.get("Right Click");
  }
  
  @Override void update() {
    super.update();
    if (isClicked) { //Either left or right click.
      polygons.add(new Polygon(mouseX, mouseY));
    }
    
    for (int i = 0; i < polygons.size(); i++) {
      Polygon shape = polygons.get(i);
      shape.update();
      shape.newOffsetZ(polygons.size() - 1 - i);
    }
  }
  
  @Override void display() {
    for (Polygon shapes : polygons) {
      shapes.display();
    }
    
    if (isHovering) { //When hovering in the area
      setColour("Light Gray");
      circle(mouseX, mouseY, locationSize);
    }
  }
  
  void clearArea() {
    polygons.clear();
  }
}
