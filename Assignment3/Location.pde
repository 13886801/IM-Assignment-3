class Location extends TangibleObject {
  float size;
  
  Location(float x, float y, float size) {
    super(x, y);
    this.size = size;
  }
  
  @Override void update() {}
  
  @Override void display() {
    fill(palette.get("White"));
    circle(x, y, size);
  }
}
