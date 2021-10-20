class UIArea extends NonInteractableObject {
  private ArrayList<Button> buttons;
  
  UIArea(float x, float y, float w, float h) {
    super(x, y, w, h);
    
    buttons = new ArrayList<Button>();
    float padX = width * 0.075; //Calculated for one side
    float spaceX = width * 0.01; //Spacing between each button
    float btnW = width * 0.1;
    
    float padY = height * 0.03;
    float btnY = pos.y + padY;
    
    float btnH = height * 0.05;
    
    buttons.add(new TutorialButton(padX, btnY, btnW, btnH, "How to use"));
    String[][] labels = {
      {"Clear", "Clear all points and triangles from the screen."},
      {"Generate parallax", "Generate parallax on all triangles. At least have nine points on the screen."},
      {"End drawing", "Finish the parallax and fly through your creation."}
    };
    
    float smallFS = Integer.MAX_VALUE; //Smallest font size
    for (int i = 0; i < labels.length; i++) {
      float btnX = padX + (spaceX + btnW) * (i + 1);
      Button btn = new Button(btnX, btnY, btnW, btnH, labels[i][0]);
      btn.setText(labels[i][1]);
      buttons.add(btn);
      smallFS = btn.sizeOfFont < smallFS ? btn.sizeOfFont : smallFS;
    }
    
    //Helps make all the buttons a consistent size
    for (Button btn : buttons) {
      btn.sizeOfFont = smallFS;
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
    rect(pos.x, pos.y, w, h);
    
    //Simply the line dividing the drawingArea and UI.
    stroke(palette.get("White"));
    line(0, height * 0.8, width, height * 0.8);
    noStroke();
    
    buttons.forEach((btn)->{
      btn.display();
    });
  }
  
  void cycleTutorial() {
    TutorialButton btn = (TutorialButton)buttons.get(0); //Hard coded to be 0, which is the "How to use" button
    btn.cycleTutorial();
  }
}
