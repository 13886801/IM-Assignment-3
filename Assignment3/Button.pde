/*
Button class that when clicked shall relay it's action to main itself.
*/
class Button extends InteractableObject {
  String label;
  String text; //The information that displays what this button does.
  float sizeOfFont;
  
  Button(float x, float y, float w, float h, String label) {
    super(x, y, w, h);
    this.label = label;
    text = "Use var.setText(String text) to change this text"; //Fodder text.
    sizeOfFont = w * 0.1;
    
    palette.put("Body", color(88, 101, 242));
    palette.put("Hover", color(59, 165, 93));
  }
  
  @Override void display() {
    fill(palette.get(isHovering ? "Hover" : "Body"));
    rect(x, y, w, h);
    
    fill(palette.get("White"));
    textAlign(CENTER, CENTER);
    textSize(sizeOfFont);
    text(label, x + w * 0.5, y + h * 0.5);
    
    if (!isHovering) {
      return;
    }
    
    fill(palette.get("Body"));
    float midX = x + w / 2;
    float triH = y - h;
    triangle(
      midX, y,
      midX + w / 4, triH,
      midX - w / 4, triH
    );
    
    float rectY = height * 0.55;
    rect(width * 0.05, rectY, width * 0.9, triH - rectY);
    
    fill(palette.get("White"));
    textAlign(CORNER, CENTER);
    textSize(sizeOfFont);
    text(text, width * 0.07, rectY + height * 0.05);
  }
  
  void doAction() { //Meant to be overidden for any children
    main.doCommand(label);
  }
  
  void setText(String text) {
    this.text = text;
  }
}
