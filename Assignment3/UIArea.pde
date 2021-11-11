abstract class UIArea extends InteractableObject {
  protected HashMap<String, Button> buttons;
  protected Button btnTextRef;
  
  UIArea(Boolean keyboardBindable, float x, float y, float w, float h) {
    super(keyboardBindable, x, y, w, h);
    buttons = new HashMap<String, Button>();
    
    palette.put("UI", color(32, 34, 37)); //Slightly lighter than background.
    palette.put("Info Area", color(88, 101, 242));
  }
  
  @Override void doHover() {
    mouseState.put("Raycast", true);
    btnTextRef = null;
    for (HashMap.Entry<String, Button> button : buttons.entrySet()) {
      button.getValue().update();
    }
    mouseState.put("Raycast", false);
  }
  
  protected void doCommand(String command) {} //Meant to be overridden
  
  protected final void setDisplayBtn(Button btn) {
    if (btnTextRef == null) {
      btnTextRef = btn;
    }
  }
}

class CommandArea extends UIArea {
  private float fontSize;
  
  private Boolean isMinimised;
  private float offsetY;
  
  private String headText;
  
  CommandArea(float x, float y, float w, float h) {
    super(true, x, y, w, h);
    isMinimised = false;
    offsetY = h * 0.8;
    headText = "Space to minimise";
    
    PVector btnOrigin = new PVector(x + w * 0.03, y + h * 0.2);
    float btnYIncrement = h * 0.2;
    fontSize = 50;
    String btnInfo[][] = {
      {"How to use", "<This is a tutorial button.>"},
      {"New layer", "Adds a new layer hiding the previous layer. Better for performance. Have at least 10 shapes per layer."},
      {"Toggle parallax mode", "Make the shapes start moving according to the mouse position. Adding shapes is not possible in this mode."},
      {"Finish drawing", "Have at least 3 layers for before finishing."}
    };
    
    buttons.put(btnInfo[0][0], new TutorialButton(this, btnOrigin.x, btnOrigin.y, fontSize, btnInfo[0][0]));
    for (int i = 1; i < btnInfo.length; i++) {
      Button newBtn = new Button(this, btnOrigin.x, btnOrigin.y + (btnYIncrement * i), fontSize, btnInfo[i][0]);
      newBtn.setHoverInfo(btnInfo[i][1]);
      buttons.put(btnInfo[i][0], newBtn);
    }
  }
  
  @Override void update() {
    if (isMinimised) {
      return;
    }
    super.update();
  }
  
  @Override void display() {
    if (!isMinimised) {
      setColour("UI", "Info Area");
      rect(pos.x, pos.y, w, h);
    }
    
    setColour("Info Area", "UI");
    rect(pos.x, pos.y, w + 1, h - offsetY); //+ 1 to account for previous rect's 1px stroke.
    
    setColour("White");
    textSize(fontSize);
    textAlign(CENTER, TOP);
    text(headText, pos.x + w * 0.5, pos.y); 
    
    if (isMinimised) {
      return;
    }
    
    for (HashMap.Entry<String, Button> button : buttons.entrySet()) {
      button.getValue().display();
    }
    
    if (btnTextRef != null) {
      btnTextRef.displayText();
    }
  }
  
  @Override void doInput() {
    if (keyStates.get(' ')) {
      pos.y += isMinimised ? -offsetY : offsetY;
      isMinimised = !isMinimised;
      headText = "Space to " + (isMinimised ? "maximise" : "minimise");
    }
  }
  
  void doCommand(String command) {
    switch (command) {
      case "New layer":
      if (main.layers.get(main.layers.size() - 1).polygons.size() >= 10) {
        main.addLayer();
      }
      return;
      
      case "Toggle parallax mode":
      println("Ok");
      return;
      
      default:
      println("Unknown command: " + command);
      exit();
    }
  }
}
