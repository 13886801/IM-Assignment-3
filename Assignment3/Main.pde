/*
There should only be one.
*/
class Main extends IntangibleObject {
  private ArrayList<DrawingArea> layers;
  private UIArea uiArea;
  private String currentMode;
  
  Main() {
    super(false);
    layers = new ArrayList<DrawingArea>();
    addLayer();
    
    currentMode = "Edit";
    
    uiArea = new CommandArea(0, height * 0.8, width * 0.2, height * 0.2);
    
    palette.put("Background", color(24, 25, 28)); //Nearly black
  }
  
  @Override void update() {
    uiArea.update();
    
    switch(currentMode) {
      case "Edit":
      layers.get(layers.size() - 1).update();
      break;
      
      case "Fly":
      loopThroughLayers(true);
      break;
      
      default:
      crash();
    }
  }
  
  @Override void display() {
    background(palette.get("Background"));
    
    switch(currentMode) {
      case "Edit":
      layers.get(layers.size() - 1).display();
      break;
      
      case "Fly":
      loopThroughLayers(false);
      break;
      
      default:
      crash();
    }
    
    uiArea.display();
  }
  
  void addLayer() {
    layers.add(new DrawingArea(0, 0, width, height));
  }
  
  void crash() {
    println("Unknown mode! " + currentMode);
    exit();
  }
  
  void loopThroughLayers(Boolean justUpdate) {
    for (DrawingArea area : layers) {
      if (justUpdate) {
        area.update();
      } else {
        area.display();
      }
    }
  }
}
