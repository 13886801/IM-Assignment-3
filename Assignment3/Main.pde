/*
There should only be one.
*/
class Main extends IntangibleObject {
  String currentMode; //The current mode of the program
  float modeTextSize; //The size of the text indicating the current mode.

  private ArrayList<DrawingArea> layers;
  private UIArea uiArea;

  Main() {
    super(false);
    currentMode = "Edit Mode";
    modeTextSize = scaleTextSize(33);

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

    setColour("White");
    textAlign(CENTER, CENTER);
    textSize(modeTextSize);
    text(currentMode, width * 0.5, textAscent() + textDescent());
  }

  void addLayer() {
    layers.add(new DrawingArea(0, 0, width, height));
  }

  void crash() {
    println("Unknown mode! " + currentMode);
    exit();
  }

  void doState(Boolean justUpdate) {
    switch(currentMode) {
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
