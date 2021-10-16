class UIArea extends NonInteractableObject {
  private ArrayList<Button> buttons;
  
  UIArea(float x, float y, float w, float h) {
    super(x, y, w, h);
    
    buttons = new ArrayList<Button>();
    float padX = width * 0.075; //Calculated for one side
    float spaceX = width * 0.01; //Spacing between each button
    float btnW = width * 0.2;
    
    float padY = height * 0.05;
    float btnH = height * 0.1;
    
    String[][] labels = {
      {"How to use", "(1/4) Click this button to cycle through the pages on how to use it."},
      {"Clear", "Clear all points and triangles from the screen."},
      {"Generate parallax", "Generate parallax on all triangles. At least have nine points on the screen."},
      {"End drawing", "Finish the parallax and fly through your creation."}
    };
    
    for (int i = 0; i < 4; i++) {
      float btnX = padX + (spaceX + btnW) * i;
      float btnY = height - btnH - padY;
      Button btn = new Button(btnX, btnY, btnW, btnH, labels[i][0]);
      btn.setText(labels[i][1]);
      buttons.add(btn);
      
    }
    
    palette.put("UI", color(32, 34, 37)); //Slightly lighter than background.
  }
  
  @Override void update() {
    buttons.forEach((btn)->{
      btn.update();
    });
  }
  
  @Override void display() {
    fill(palette.get("UI"));
    rect(x, y, w, h);
    
    //Simply the line dividing the drawingArea and UI.
    stroke(palette.get("White"));
    line(0, height * 0.8, width, height * 0.8);
    stroke(palette.get("Invisible"));
    
    buttons.forEach((btn)->{
      btn.display();
    });
  }
  
  void cycleTutorial() {
    Button btn = buttons.get(0); //Hard coded to be 0, which is the "How to use" button
    if (btn.text.contains("1/4")) {
      btn.text = "(2/4) Randomly click in the space above to place dots around. Place 9 or more around.";
    } else if (btn.text.contains("2/4")) {
      btn.text = "(3/4) Once there are at least 9 dots, generate a parallax effect with the triangles on the screen.";
    } else if (btn.text.contains("3/4")) {
      btn.text = "(4/4) Repeat 2 and 3 at least 3 times. Once done, click finish drawing to see the accumulated result.";
    } else if (btn.text.contains("4/4")) {
      btn.text = "(1/4) Click this button to cycle through the pages on how to use it.";
    }
  }
}
