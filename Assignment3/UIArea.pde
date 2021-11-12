abstract class UIArea extends InteractableObject {
  protected HashMap<String, Button> buttons;
  protected Button btnTextRef;
  protected Boolean isMinimised;
  
  UIArea(float x, float y, float w, float h) {
    super(x, y, w, h);
    buttons = new HashMap<String, Button>();
    isMinimised = false;
    
    palette.put("UI", color(32, 34, 37)); //Slightly lighter than background.
    palette.put("Info Area", color(88, 101, 242));
  }
  
  @Override void update() {
    super.update();
    btnTextRef = null;
    mouseState.put("Raycast", true);
    for (HashMap.Entry<String, Button> button : buttons.entrySet()) {
      button.getValue().update();
    }
    mouseState.put("Raycast", mouseState.get("Raycast") && !isHovering);
  }
  
  protected void doCommand(String command) {} //Meant to be overridden
  
  protected final void setDisplayBtn(Button btn) {
    if (btnTextRef == null) {
      btnTextRef = btn;
    }
  }
}

class CommandArea extends UIArea implements KeyboardComponent {
  private float offsetY;
  
  private Message headText;
  
  CommandArea(float x, float y, float w, float h) {
    super(x, y, w, h);
    offsetY = h * 0.8;
    
    float fontSize = 40;
    headText = new Message(pos.x + w * 0.5, pos.y, 40, CENTER, TOP, "Space to hide");
    
    PVector btnOrigin = new PVector(x + w * 0.03, y + h * 0.2);
    float btnYIncrement = h * 0.2;
    
    String btnInfo[][] = {
      {"How to use", "<This is a tutorial button.>"},
      {"New layer (n)", "Click or press n for a new layer. This hides the previous layer. Better for performance. Have at least 10 shapes per layer."},
      {"Toggle parallax mode (t)", "Press t or click to make the shapes start moving according to the mouse position. Adding shapes is not possible in parallax mode."},
      {"Finish drawing (f)", "Press f click here to see your accumulated shapes, this will reset all accumulated shapes however! You must have at least 3 layers and the first 3 layers must have at least 10 shapes."}
    };
    
    buttons.put(btnInfo[0][0], new TutorialButton(this, btnOrigin.x, btnOrigin.y, fontSize, btnInfo[0][0]));
    for (int i = 1; i < btnInfo.length; i++) {
      Button newBtn = new Button(this, btnOrigin.x, btnOrigin.y + (btnYIncrement * i), fontSize, btnInfo[i][0]);
      newBtn.setHoverInfo(btnInfo[i][1]);
      buttons.put(btnInfo[i][0], newBtn);
    }
  }
  
  @Override void display() {
    rectMode(CORNER);
    if (!isMinimised) {
      setColour("UI", "Info Area");
      rect(pos.x, pos.y, w, h);
    }
    
    setColour("Info Area", "UI");
    rect(pos.x, pos.y, w + 1, h - offsetY); //+ 1 to account for previous rect's 1px stroke.
    
    setColour("White");
    headText.display();
    
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
  
  @Override void doInput(char button) {
    if (main.currentMode.message.equals("Ending Mode")) {
      return;
    }
    
    switch (button) {
      case ' ':
      pos.y += isMinimised ? -offsetY : offsetY;
      isMinimised = !isMinimised;
      headText.pos.y = pos.y;
      headText.message = "Space to " + (isMinimised ? "show" : "hide");
      break;
      
      case 'n':
      doCommand("New layer (n)");
      break;
      
      case 't':
      doCommand("Toggle parallax mode (t)");
      break;
      
      case 'f':
      doCommand("Finish drawing (f)");
      break;
    }
  }
  
  void doCommand(String command) {
    if (main.currentMode.message.equals("Ending Mode")) {
      return;
    }
    
    switch (command) {
      case "New layer (n)":
      main.addLayer();
      return;
      
      case "Toggle parallax mode (t)":
      main.currentMode.message = main.currentMode.message.equals("Parallax Mode") ? "2D Mode" : "Parallax Mode";
      return;
      
      case "Finish drawing (f)":
      main.finishDrawing();
      return;
      
      default:
      println("Unknown command: " + command);
      exit();
    }
  }
}
