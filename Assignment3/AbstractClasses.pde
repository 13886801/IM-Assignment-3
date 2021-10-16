/*
Abstract Classes to define a hierarchy.

Entity (Parent)
  IntangibleObject - The object has a colour palette
    TangibleObject - The object has a position
        NonInteractableObject - The object has a bounding box 
          InteractableObject - The object has mouse collision detection 
*/
interface Entity {
  void update(); //Is meant to be overridden
  void display(); //Is meant to be overridden
  void blit(); //Is defined in IntangibleObject
}

abstract class IntangibleObject implements Entity {
  HashMap<String, Integer> palette; //color() is actually an integer.
  
  IntangibleObject() {
    palette = new HashMap<String, Integer>();
    palette.put("Black", color(0, 0, 0));
    palette.put("White", color(255, 255, 255));
    palette.put("Invisible", color(255, 255, 255, 0));
  }
  
  //Lazy procedure but can be overridden
  @Override void blit() {
    update();
    display();
  }
  
  void hideStroke() { //Makes the stroke invisible.
    stroke(palette.get("Invisible"));
  }
}

abstract class TangibleObject extends IntangibleObject {
  float x; //x position of the object
  float y; //y position of the object
  TangibleObject (float x, float y) {
    super();
    this.x = x;
    this.y = y;
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
  boolean isHovering;
  
  InteractableObject(float x, float y, float w, float h) {
    super(x, y, w, h);
    isHovering = false;
  }
  
  @Override void update() {
    isHovering = mouseOver();
    if (isHovering && mouseState.get("Left Click")) {
      doAction();
    }
  }
  
  void doAction() {} //Meant to be overridden
  
  /*
    Is the mouse colliding with the bounding box of object?
   - It naturally goes by corner.
   
   Parameters:
   offsetX - Offsets the collision detection by given float in x axis
   offsetY - Offsets the collision detection by given float in y axis
   */
  boolean mouseOver(float offsetX, float offsetY) {
    boolean left = x + offsetX < mouseX;
    boolean right = x + offsetX + w > mouseX;
    boolean top = y + offsetY < mouseY;
    boolean bottom = y + offsetY + h > mouseY;

    return left && right && top && bottom;
  }
  
  //Just an overload for the mouseOver function
  boolean mouseOver() {
    return mouseOver(0, 0);
  }
}
