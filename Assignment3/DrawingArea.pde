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
  
  @Override void update() {
    for (Polygon shapes : polygons) {
      shapes.update();
    }
  }
  
  @Override void display() {
    area.beginDraw();
    
    area.background(palette.get("Invisible"));
    area.fill(palette.get("Light Gray"));
    for (Polygon shapes : polygons) {
      shapes.display();
    }
    
    if (polygons.size() != 0) {
      Polygon shape = polygons.get(polygons.size() - 1);
      if (shape.isFocused) {
        float newRad = sqrt(pow(mouseX - shape.x, 2) + pow(mouseY - shape.y, 2)); 
        shape.radius = min(max(30, newRad), 200);
      }
    }
    
    if (mouseOver()) { //When hovering in the area
      area.fill(palette.get("Light Gray"));
      area.circle(mouseX, mouseY, locationSize);
      if (mouseState.get("Left Click") || mouseState.get("Right Click")) { //Either left or right click.
        polygons.add(new Polygon(mouseX, mouseY));
      }
    }
    
    area.endDraw();
    
    image(area, x, y);
  }
  
  void clearArea() {
    polygons.clear();
  }
}
