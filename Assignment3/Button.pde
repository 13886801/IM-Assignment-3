/*
Button class that when clicked shall relay it's action to main itself.
*/
class Button extends InteractableObject {
  protected UIArea UIRef; //The UIArea type variable it is attached to.
  
  protected Message buttonLabel; //The label of the button
  protected String hoverInfo; //The information that displays what this button does.
  protected float hoverInfoSize; //Size of the text.
  
  Button(UIArea UIRef, float x, float y, float size, String label) {
    super(x, y, 0, 0);
    this.UIRef = UIRef;
    buttonLabel = new Message(x, y, size, LEFT, TOP, label);
    hoverInfo = "";
    
    textSize(this.buttonLabel.messageSize);
    w = textWidth(label); //Simulated font width
    h = textAscent() + textDescent();
    
    palette.put("Body", color(88, 101, 242));
    palette.put("Hover", color(59, 165, 93));
    
    hoverInfoSize = scaleTextSize(30);
    textSize(hoverInfoSize); //Fixes a visual bug?? Might be from my laptop...
  }
  
  @Override void display() {
    setColour(isHovering ? "Hover" : "White");
    buttonLabel.display();
    
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
    int lines = ceil(textWidth(hoverInfo) / lineWidth) + 1;
    float rectH = h * lines * 1.1;
    
    float rectY = mouseY - rectH - (mouseY - triY);
    rect(mouseX, rectY, infoW, rectH + 1); // + 1 for Y to account single pixel
    
    setColour("White");
    textAlign(CORNER, CENTER);
    text(hoverInfo, mouseX + infoW * 0.1, rectY, lineWidth, rectH);
  }
  
  void doAction() { //Meant to be overidden for any children
    UIRef.doCommand(buttonLabel.message);
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
    addPage("Start a new layer where there is at least 10 shapes.");
    addPage("When there is at least 3 layers, click finish drawing to see the accumulated result.");
    addPage("At any point, feel free to toggle parallax mode. Note, no shapes can be added in this mode.");
    addPage("At any point, press space to minimize/maximise this menu.");
    doAction();
  }
  
  @Override void doAction() {
    cycleTutorial();
  }
}
