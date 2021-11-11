/*
There should only be one.
*/
class Main extends IntangibleObject {
  Message currentMode;

  private NotificationSystem notifySystem;
  private ArrayList<DrawingArea> layers;
  private UIArea uiArea;

  Main() {
    super();
    textSize(60);
    currentMode = new Message(width * 0.5, textAscent() + textDescent(), 60, CENTER, CENTER, "Edit Mode");

    notifySystem = new NotificationSystem();
    layers = new ArrayList<DrawingArea>();
    uiArea = new CommandArea(0, height * 0.8, width * 0.2, height * 0.2);

    addLayer();

    palette.put("Background", color(24, 25, 28)); //Nearly black
  }

  @Override void update() {
    uiArea.update();
    doState(true);
  }

  @Override void display() {
    background(palette.get("Background"));
    doState(false);
    uiArea.display();
    notifySystem.blit();
    
    setColour("White");
    currentMode.display();
  }

  void addLayer() {
    layers.add(new DrawingArea(0, 0, width, height));
  }

  void crash() {
    println("Unknown mode! " + currentMode);
    exit();
  }

  void doState(Boolean justUpdate) {
    switch(currentMode.message) {
      case "Edit Mode":
      DrawingArea layer = layers.get(layers.size() - 1);
      if (justUpdate) {
        layer.update();
      } else {
        layer.display();
      }
      break;

      case "Ending Mode":
      loopThroughLayers(justUpdate);
      break;

      default:
      crash();
    }
  }
  
  void announce(String announcement) {
    notifySystem.notify(announcement);
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
