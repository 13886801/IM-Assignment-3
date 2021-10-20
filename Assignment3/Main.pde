/*
There should only be one.
*/
class Main extends IntangibleObject {
  private ArrayList<DrawingArea> layers;
  private UIArea uiArea;
  
  
  Main() {
    super();
    layers = new ArrayList<DrawingArea>();
    AddLayer();
    uiArea = new UIArea(0, height * 0.8, width, height * 0.2);
    
    palette.put("Background", color(24, 25, 28)); //Nearly black
  }
  
  @Override void update() {
    for (DrawingArea area : layers) {
      area.update();
    }
    
    uiArea.update();
  }
  
  @Override void display() {
    background(palette.get("Background"));
    for (DrawingArea area : layers) {
      area.display();
    }
    
    uiArea.display();
  }
  
  void AddLayer() {
    layers.add(new DrawingArea(0, 0, width, round(height * 0.8)));
  }
  
  void doCommand(String command) {
    switch (command) {
      case "How to use":
      uiArea.cycleTutorial();
      return;
      
      case "Clear":
      layers.get(layers.size() - 1).clearArea();
      return;
      
      case "Generate parallax":
      println("Ok");
      return;
      
      default:
      println("Unknown command: " + command);
      return;
    }
  }
}
