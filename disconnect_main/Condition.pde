public class Condition {
  int eventID;
  int triggerID;
  String condition;
  public Condition(int eventID, int triggerID, String condition) {
    this.eventID = eventID;
    this.triggerID = triggerID;
    this.condition = condition;
  }
  @Override
  public boolean equals(Object o){
    if(o == this) return true;
    if(!(o instanceof Condition))return false;
    Condition c = (Condition) o;
    return (this.eventID == c.eventID  && this.triggerID == c.triggerID && this.condition.equals(c.condition));
  }
}
