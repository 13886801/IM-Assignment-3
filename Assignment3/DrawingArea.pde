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
    return super.isClickedCheck() || mouseState.get("Right Click");
  }
  
  @Override void update() {
    super.update();
    
    if (isClicked && !main.currentMode.message.equals("Ending Mode")) { //Either left or right click.
      if (main.currentMode.message.equals("2D Mode")) {
        polygons.add(new Polygon(mouseX, mouseY));
      } else {
        main.announce("Go back to edit mode to add more shapes.");
      }
    }
    
    for (int i = 0; i < polygons.size(); i++) {
      Polygon shape = polygons.get(i);
      shape.update();
    }
  }
  
  @Override void display() {
    Iterator itr = polygons.iterator();
    while (itr.hasNext()) {
      Polygon shape = (Polygon)itr.next();
      shape.display();
      if (main.z < shape.pos.z) {
        itr.remove();
      }
    }
    
    if (isHovering && !main.currentMode.message.equals("Ending Mode")) { //When hovering in the area
      setColour("Light Gray");
      circle(mouseX, mouseY, locationSize);
    }
  }
  
  void clearArea() {
    polygons.clear();
  }
}
