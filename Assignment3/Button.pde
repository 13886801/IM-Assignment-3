/*
Button class that when clicked shall relay it's action to main itself.
*/
class Button extends InteractableObject {
  String label; //The label of the button
  String text; //The information that displays what this button does.
  float sizeOfFont; //The size of the font of the label.
  
  Button(float x, float y, float w, float h, String label) {
    super(x, y, w, h);
    this.label = label;
    text = "";
    
    int fontSize = 0; //The simulated font size
    float fontWidth = 0; //Simulated font width
    float fontHeight = 0; //Simulated font height
    while (fontWidth < w * 0.9 && fontHeight < h * 0.9) {
      textSize(++fontSize);
      fontWidth = textWidth(label);
      fontHeight = textAscent() + textDescent();
    }
    sizeOfFont = fontSize;
    
    palette.put("Body", color(88, 101, 242));
    palette.put("Hover", color(59, 165, 93));
  }
  
  @Override void display() {
    fill(palette.get(isHovering ? "Hover" : "Body"));
    rect(pos.x, pos.y, w, h);
    
    fill(palette.get("White"));
    textAlign(CENTER, CENTER);
    textSize(sizeOfFont);
    text(label, pos.x + w * 0.5, pos.y + h * 0.5);
    
    if (!isHovering || text.equals("")) {
      return;
    }
    
    fill(palette.get("Body"));
    float triH = pos.y - h; //Also bottom of rect
    float quarter = w * 0.25;
    triangle(
      pos.x + w * 0.5, pos.y,
      pos.x + quarter, triH,
      pos.x + w * 0.75, triH
    );
    
    textSize(sizeOfFont);
    float lineWidth = w * 1.5 * 0.9;
    int lines = ceil(textWidth(text) / lineWidth) + 1;
    float textHeight = textAscent() + textDescent();
    float rectH = textHeight * lines * 1.1;
    rect(pos.x - quarter, triH - rectH, w * 1.5, rectH + 1); // + 1 for Y to account single pixel
    
    fill(palette.get("White"));
    textAlign(CORNER, CENTER);
    text(text, pos.x - w * 0.2, triH - rectH, lineWidth, rectH);
  }
  
  void doAction() { //Meant to be overidden for any children
    main.doCommand(label);
  }
  
  void setText(String text) {
    this.text = text;
  }
}

class TutorialButton extends Button {
  int part;
  String[] instructions;
  
  TutorialButton(float x, float y, float w, float h, String label) {
    super(x, y, w, h, label);
    part = -1;
    instructions = new String[] {
      "(1/4) Click this button to cycle through the pages on how to use it.",
      "(2/4) Left/right click in the space above to place shapes around. The type of click sets the rotation direction.",
      "(3/4) Once there are at least 2 shapes, generate a parallax effect with them on the screen.",
      "(4/4) Repeat 2 and 3 at least 3 times. Once done, click finish drawing to see the accumulated result."
    };
    cycleTutorial();
  }
  
  void cycleTutorial() {
    part = (part + 1) % instructions.length;
    setText(instructions[part]);
  }
}
