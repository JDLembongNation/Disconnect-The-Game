public class Condition {
  int conditionID;
  int eventID;
  int triggerID;
  String condition;
  ArrayList<Item> items;
  public Condition(int conditionID,int eventID, int triggerID, String condition, JSONArray itemList) {
    this.conditionID= conditionID;
    this.eventID = eventID;
    this.triggerID = triggerID;
    this.condition = condition;
    items = new ArrayList<Item>();
    for(int i = 0; i < itemList.size(); i++){
      items.add(new Item(conditionID,itemList.getJSONObject(i)));
    }
  }
  
  public void removeItem(Item item){
    for(int i = 0; i < items.size(); i++){
      if(items.get(i).equals(item)) items.remove(i);
    }
  }
 
  @Override
  public boolean equals(Object o){
    if(o == this) return true;
    if(!(o instanceof Condition))return false;
    Condition c = (Condition) o;
    return (this.eventID == c.eventID  && this.triggerID == c.triggerID && this.condition.equals(c.condition));
  }
  
}
