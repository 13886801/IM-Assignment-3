class NotificationSystem extends IntangibleObject {
  private ArrayList<Notification> notifications;
  
  NotificationSystem() {
    super();
    notifications = new ArrayList<Notification>(); 
    
    palette.put("Warning", color(250, 168, 26));
  }
  
  void notify(String msg) {
    notifications.add(new Notification(width * 0.03, 0, 3, 50, LEFT, TOP, msg));
  }
  
  @Override void update() {
    Iterator itr = notifications.iterator();
    while (itr.hasNext()) {
      Notification notification = (Notification)itr.next();
      notification.update();
      if (notification.lifespan <= 0) {
        itr.remove();
      }
    }
  }
  
  @Override void display() {
    setColour("Warning");
    
    textSize(50);
    float startY = height * 0.1;
    float textHeight = textAscent() + textDescent();
    for (int i = 0; i < notifications.size(); i++) {
      Notification notification = notifications.get(i); 
      notification.pos.y = startY + (textHeight * i);
      notification.display();
    }
  }
}

class Message extends TangibleObject {
  float messageSize;
  String message;
  protected int alignA;
  protected int alignB;
  
  Message(float x, float y, float fontSize, int align1, int align2, String msg) {
    super(x, y);
    messageSize = fontSize;
    message = msg;
    alignA = align1;
    alignB = align2;
  }
  
  @Override void update() {}
  
  @Override void display() {
    textAlign(alignA, alignB);
    textSize(messageSize);
    text(message, pos.x, pos.y);
  }
}

class Notification extends Message {
  float lifespan;
  
  Notification(float x, float y, float duration, float fontSize, int align1, int align2, String msg) {
    super(x, y, fontSize, align1, align2, msg);
    lifespan = duration;
  }
  
  @Override void update() {
    lifespan -= deltaTime;
  }
}
