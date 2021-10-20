class DrawingArea extends InteractableObject {
  PGraphics area;
  ArrayList<Polygon> polygons;
  float locationSize;
  
  DrawingArea(float x, float y, int w, int h) {
    super(x, y, w, h);
    area = createGraphics(w, h);
    
    polygons = new ArrayList<Polygon>();
    locationSize = 15;
    
    palette.put("Light Gray", color(64, 68, 75));
  }
  
  @Override boolean isClickedCheck() {
    return isHovering && mouseState.get("Left Click") || mouseState.get("Right Click");
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
    area.beginDraw();
    
    area.background(palette.get("Invisible"));
    area.fill(palette.get("Light Gray"));
    for (Polygon shapes : polygons) {
      shapes.display();
    }
    
    if (isHovering) { //When hovering in the area
      area.fill(palette.get("Light Gray"));
      area.circle(mouseX, mouseY, locationSize);
    }
    
    area.endDraw();
    
    image(area, pos.x, pos.y);
  }
  
  void clearArea() {
    polygons.clear();
  }
}
