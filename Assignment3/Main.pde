/*
There should only be one.
*/
class Main extends IntangibleObject {
  Message currentMode;

  private NotificationSystem notifySystem;
  private ArrayList<DrawingArea> layers;
  private UIArea uiArea;

  PVector parallaxMouse; //The mouse in parallax mode.
  float mouseSensitivity; //Multiplier for polygon movement in parallax mode.
  Message sensitivity;
  
  float currentZ; //The accumulated z space
  float frontZ; //The z space in the front of the current Z
  float zDist; //The distance between frontZ and currentZ

  Main() {
    super();
    textSize(60);
    float textHeight = textAscent() + textDescent();
    currentMode = new Message(width * 0.5, textHeight, 60, CENTER, CENTER, "2D Mode");
    sensitivity = new Message(width * 0.23, height - textHeight, 50, LEFT, CENTER, "Sensitivity: " + mouseSensitivity);
    updateSensitivity(100);
    
    notifySystem = new NotificationSystem();
    layers = new ArrayList<DrawingArea>();
    uiArea = new CommandArea(0, height * 0.8, width * 0.2, height * 0.2);
    
    parallaxMouse = new PVector(mouseX, mouseY);
    currentZ = 0;
    zDist = 300;
    frontZ = 0;
    
    layers.add(new DrawingArea(0, 0, width, height));

    palette.put("Background", color(24, 25, 28)); //Nearly black
  }

  @Override void update() {
    if (!currentMode.message.equals("Ending Mode")) {
      uiArea.update();
    }
    
    
    if (!currentMode.message.equals("2D Mode")) {
      parallaxMouse = new PVector((mouseX - width * 0.5) * mouseSensitivity, (mouseY - height * 0.5) * mouseSensitivity);
    }
    
    doState(true);
  }

  @Override void display() {
    background(palette.get("Background"));
    doState(false);
    if (!currentMode.message.equals("Ending Mode")) {
      uiArea.display();
      notifySystem.blit();
    }
    
    setColour("White");
    currentMode.display();
    sensitivity.display();
  }

  void doState(Boolean justUpdate) {
    switch(currentMode.message) {
      case "2D Mode":
      case "Parallax Mode":
      DrawingArea layer = layers.get(layers.size() - 1);
      if (justUpdate) {
        layer.update();
      } else {
        layer.display();
      }
      break;

      case "Ending Mode":
      doEndingMode();
      break;

      default:
      crash();
    }
  }
  
  void updateSensitivity(float amount) {
    mouseSensitivity = clamp(mouseSensitivity + amount, 0, 200);
    sensitivity.message = "Sensitivity: " + mouseSensitivity;
  }
  
  void announce(String announcement) {
    notifySystem.notify(announcement);
  }
  
  void crash() {
    println("Unknown mode! " + currentMode);
    exit();
  }
  
  void addLayer() {
    int polyCount = layers.get(main.layers.size() - 1).polygons.size();
    if (polyCount >= 10) {
      layers.add(new DrawingArea(0, 0, width, height));
    } else {
      main.announce("Not enough polygons in layer, add " + (10 - polyCount) + " more.");
    }
  }
  
  void finishDrawing() {
    if (layers.size() < 3) {
      main.announce("Insufficient number of layers, add " + (3 - layers.size()) + " more.");
      return;
    }
    
    if (layers.size() == 3 && layers.get(main.layers.size() - 1).polygons.size() < 10) {
      main.announce("Add 1 more layer or have a minimum of 10 polygons on this layer before finishing.");
      return;
    }
    
    frontZ = currentZ - zDist; //The far distance.
    currentMode.message = "Ending Mode";
  }
  
  void doEndingMode() {
    currentZ -= 0.5;
    frontZ -= 0.5;
    Iterator itr = layers.iterator();
    while (itr.hasNext()) {
      DrawingArea area = (DrawingArea)itr.next();
      area.blit();
      if (area.polygons.size() == 0) {
        itr.remove();
      }
    }
    
    if (layers.size() == 0) {
      currentMode.message = "2D Mode";
      layers.add(new DrawingArea(0, 0, width, height));
    }
  }
}
