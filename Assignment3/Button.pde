/*
Button class that when clicked shall relay it's action to main itself.
*/
class Button extends InteractableObject {
  UIArea UIRef; //The UIArea type variable it is attached to.
  
  String label; //The label of the button
  float labelSize; //The size of the font of the label.
  
  String hoverInfo; //The information that displays what this button does.
  float hoverInfoSize; //Size of the text.
  
  Button(UIArea UIRef, float x, float y, float size, String label) {
    super(false, x, y, 0, 0);
    this.UIRef = UIRef;
    this.label = label;
    hoverInfo = "";
    
    labelSize = size;
    hoverInfoSize = 30;
    textSize(labelSize);
    w = textWidth(label); //Simulated font width
    h = textAscent() + textDescent();
    
    palette.put("Body", color(88, 101, 242));
    palette.put("Hover", color(59, 165, 93));
    textSize(hoverInfoSize); //Fixes a visual bug?? Might be from my laptop...
  }
  
  @Override void display() {
    setColour(isHovering ? "Hover" : "White");
    textAlign(LEFT, TOP);
    textSize(labelSize);
    text(label, pos.x, pos.y);
    
    if (!isHovering || hoverInfo.equals("")) {
      return;
    }
    
    UIRef.setDisplayBtn(this);
  }
  
  void displayText() {    
    setColour("Body");
    
    float infoW = width * 0.2;
    float triY = mouseY - height * 0.03;
    triangle(
      mouseX, mouseY,
      mouseX, triY,
      mouseX + infoW, triY
    );
    
    textSize(hoverInfoSize);
    float lineWidth = infoW * 0.8;
    int lines = ceil(textWidth(hoverInfo) / lineWidth);
    float rectH = h * lines * 1.1;
    
    float rectY = mouseY - rectH - (mouseY - triY);
    rect(mouseX, rectY, infoW, rectH + 1); // + 1 for Y to account single pixel
    
    setColour("White");
    textAlign(CORNER, CENTER);
    text(hoverInfo, mouseX + infoW * 0.1, rectY, lineWidth, rectH);
  }
  
  void doAction() { //Meant to be overidden for any children
    UIRef.doCommand(label);
  }
  
  void setHoverInfo(String text) {
    this.hoverInfo = text;
  }
}

/*
Inherits from the Button class. Is abstract as children inherits from it.
*/
abstract class DynamicInfoTextButton extends Button {
  protected int currentPage; //The current page
  protected String pageLabel; //The label of the current page out of total pages.
  protected ArrayList<String> infoPages; //The list of pages.
  
  DynamicInfoTextButton(UIArea UIRef, float x, float y, float size, String label) {
    super(UIRef, x, y, size, label);
    currentPage = -1;
    infoPages = new ArrayList<String>();
  }
  
  protected final void addPage(String text) {
    infoPages.add(text);
  }
  
  protected final void updateLabel() {
    pageLabel = "(" + (currentPage + 1) + "/" + infoPages.size() + ") ";
  }
  
  final void cycleTutorial() {
    currentPage = (currentPage + 1) % infoPages.size();
    updateLabel();
    setHoverInfo(pageLabel + infoPages.get(currentPage));
  }
}

/*
There should only be one.
*/
class TutorialButton extends DynamicInfoTextButton {
  TutorialButton(UIArea UIRef, float x, float y, float size, String label) {
    super(UIRef, x, y, size, label);
    addPage("Click this button to cycle through the pages on how to use it.");
    addPage("Left/right click in the space above to place shapes around. The type of click sets the rotation direction.");
    addPage("Once there are at least 10 shapes, you can start a new layer.");
    addPage("Repeat 2 and 3 at least 3 times. Once done, click finish drawing to see the accumulated result.");
    doAction();
  }
  
  @Override void doAction() {
    cycleTutorial();
  }
}
