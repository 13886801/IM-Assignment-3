class DrawingArea extends InteractableObject {
  PGraphics Area;
  ArrayList<Location> locations;
  float locationSize;
  
  DrawingArea(float x, float y, int w, int h) {
    super(x, y, w, h);
    Area = createGraphics(w, h);
    
    locations = new ArrayList<Location>();
    locationSize = 15;
    
    palette.put("Light Gray", color(64, 68, 75));
  }
  
  @Override void update() {
    Area.beginDraw();
    
    Area.background(palette.get("Invisible"));
    Area.fill(palette.get("Light Gray"));
    for (Location loc : locations) {
      Area.circle(loc.x, loc.y, locationSize);
    }
    
    if (mouseOver()) { //When hovering in the area
      Area.fill(palette.get("Light Gray"));
      Area.circle(mouseX, mouseY, locationSize);
      if (mouseState.get("Left Click")) {
        locations.add(new Location(mouseX, mouseY, locationSize));
      }
    }
    
    Area.endDraw();
  }
  
  @Override void display() {
    image(Area, x, y);
  }
  
  void clearArea() {
    locations.clear();
  }
}
