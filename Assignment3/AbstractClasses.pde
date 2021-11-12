/*
Abstract Classes to define a hierarchy.

Entity (Parent)
  IntangibleObject - The object has a colour palette
    TangibleObject - The object has a position
        NonInteractableObject - The object has a bounding box 
          InteractableObject - The object has mouse collision detection 
*/

interface Entity {
  void update(); //Called every frame before display. Updates variables
  void display(); //Called every frame. Displays objects on the screen.
}

abstract class IntangibleObject implements Entity {
  protected HashMap<String, Integer> palette; //color() is actually an integer.
  
  IntangibleObject() {
    palette = new HashMap<String, Integer>();
    palette.put("Black", color(0, 0, 0));
    palette.put("White", color(255, 255, 255));
    palette.put("Invisible", color(255, 255, 255, 0));
    
    if (this instanceof KeyboardComponent) {
      keyExecutor.add((KeyboardComponent)this);
    }
  }
  
  //Lazy method that can be overidden.
  void blit() {
    update();
    display();
  }
  
  //Set the colour and outline, it is final and thus cannot be changed.
  protected final void setColour(String colour, String outline) {
    fill(palette.get(colour));
    stroke(palette.get(outline));
  }
  
  //Overloader for setColour, auto sets no stroke.
  protected final void setColour(String colour) {
    setColour(colour, "Invisible");
    noStroke();
  }
}

abstract class TangibleObject extends IntangibleObject {
  PVector pos; //The position of the object
  TangibleObject(float x, float y) {
    super();
    pos = new PVector(x, y);
  }
}

abstract class NonInteractableObject extends TangibleObject {
  float w; //Width of the bounding box of the object
  float h; //Height of the bounding box of the object
  
  NonInteractableObject(float x, float y, float w, float h) {
    super(x, y);
    this.w = w;
    this.h = h;
  }
}

abstract class InteractableObject extends NonInteractableObject {
  protected boolean isHovering;
  protected boolean isClicked;
  
  InteractableObject(float x, float y, float w, float h) {
    super(x, y, w, h);
    isHovering = false;
  }
  
  @Override void update() {
    isHovering = isHoverCheck();
    if (isHovering) {
      mouseState.put("Raycast", false);
      doHover();
      
      isClicked = isClickedCheck();
      if (isClicked) {
        doAction();
      }
    }
  }
  
  protected void doHover() {} //Meant to be overridden
  protected void doAction() {} //Meant to be overridden
  
  protected boolean isHoverCheck() { //Can be overridden
    return mouseState.get("Raycast") && mouseState.get("OnWindow") && mouseOver();
  }
  
  protected boolean isClickedCheck() { //Can be overridden
    return mouseState.get("Left Click");
  }
  
  /*
  Is the mouse colliding with the bounding box of object?
   - It naturally goes by corner.
   - Can be overriden (not recommended, unless it is context specific)
   
   Parameters:
   offsetX - Offsets the collision detection by given float in x axis
   offsetY - Offsets the collision detection by given float in y axis
   */
  protected final boolean mouseOver(float offsetX, float offsetY) {
    boolean left = pos.x + offsetX < mouseX;
    boolean right = pos.x + offsetX + w > mouseX;
    boolean top = pos.y + offsetY < mouseY;
    boolean bottom = pos.y + offsetY + h > mouseY;

    return left && right && top && bottom;
  }
  
  //Just an overload for the mouseOver function
  protected final boolean mouseOver() {
    return mouseOver(0, 0);
  }
}
