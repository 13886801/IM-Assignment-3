class DrawingArea extends InteractableObject {
  PGraphics area;
  ArrayList<Location> locations;
  float locationSize;
  
  String state;
  
  DrawingArea(float x, float y, int w, int h) {
    super(x, y, w, h);
    area = createGraphics(w, h);
    
    locations = new ArrayList<Location>();
    locationSize = 15;
    
    state = "Edit";
    
    palette.put("Light Gray", color(64, 68, 75));
  }
  
  @Override void update() {
    area.beginDraw();
    
    area.background(palette.get("Invisible"));
    doState();
    
    area.endDraw();
  }
  
  @Override void display() {
    image(area, x, y);
  }
  
  void clearArea() {
    locations.clear();
  }
  
  void connect() {
    state = "Parallax";
  }
  
  void doState() {
    switch(state) {
      case "Edit":
      editMode();
      return;
      
      case "Parallax":
      parallaxMode();
      return;
    }
  }
  
  void editMode() {
    area.fill(palette.get("Light Gray"));
    for (Location loc : locations) {
      area.circle(loc.x, loc.y, locationSize);
    }
    
    if (mouseOver()) { //When hovering in the area
      area.fill(palette.get("Light Gray"));
      area.circle(mouseX, mouseY, locationSize);
      if (mouseState.get("Left Click")) {
        locations.add(new Location(mouseX, mouseY, locationSize));
      }
    }
  }
  
  void parallaxMode() {
    area.beginShape();
    area.fill(0, 255, 0);
    //area.stroke(palette.get("White"));
    for (int i = 0; i < locations.size(); i++) {
      Location current = locations.get(i);
      area.vertex(current.x, current.y);
      //Location next = locations.get((i + 1) % locations.size());
      //area.line(current.x, current.y, next.x, next.y);
    }
    //area.stroke(palette.get("Invisible"));
    area.endShape(CLOSE);
  }
}
