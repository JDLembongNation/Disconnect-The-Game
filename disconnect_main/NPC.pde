public class NPC {
  String initialPosition;
  String movement;
  PVector position;
  String name;
  boolean isInStory;
  boolean canBattle;
  int battleEventID;
  int eventTicker = 0;
  int triggerTicker = 0;
  int[] eventChanger;
  ArrayList<Event> eventList;
  ArrayList<Condition> conditions;
  String[] speech;
  public NPC(boolean isInStory, String name, String initialPosition, ArrayList<Event> eventList, JSONArray conditions, JSONArray eventChanger, JSONObject battleEvent, String movement) {
    this.canBattle= true;
    this.conditions = new ArrayList<Condition>();
    this.isInStory = isInStory;
    this.name = name;
    this.initialPosition = initialPosition;
    this.eventList = eventList;  
    this.movement = movement;
    this.battleEventID = battleEvent.getInt("eventID");
    this.eventChanger = new int[eventChanger.size()];
    for (int i = 0; i < eventChanger.size(); i++) {
      this.eventChanger[i] = eventChanger.getInt(i);
    }
    //parse conditions.
    for (int i = 0; i < conditions.size(); i++) {
      this.conditions.add(new Condition(conditions.getJSONObject(i).getInt("eventID"), conditions.getJSONObject(i).getInt("triggerID"), conditions.getJSONObject(i).getString("condition")));
    }
  }
  public NPC(boolean isInStory, String name, String[] speech) {
    this.canBattle= false;

    this.isInStory = isInStory;
    this.speech = speech;
    this.name = name;
  }
  public String[] getSpeech() {
    if (isInStory) {
      for (int i = 0; i < eventList.size(); i++) {
        if (eventList.get(i).eventID == eventTicker) {
          if (eventList.get(i).triggerID == triggerTicker) {
            iterateTrigger(eventList.get(i).eventID, eventList.get(i).triggerID);
            return eventList.get(i).text;
          }
        }
      }
      return null;
    } else {
      return speech;
    }
  }

  private void iterateTrigger(int eventID, int triggerID) {
    boolean canIterate = true;
    for (int i = 0; i < conditions.size(); i++) {
      if (eventID == conditions.get(i).eventID && triggerID == conditions.get(i).triggerID) {
        //Certain condition must be met to iterate
        //canIterate = false;
      }
    }
    if (canIterate) {
      //check final trigger. If so, move to next event, otherwise just iterate trigger.
      boolean justIterate = false;
      for (int i = 0; i < eventList.size(); i++) {
        if (eventID == eventList.get(i).eventID && triggerID < eventList.get(i).triggerID) {
          justIterate = true;
        }
      }
      if (justIterate) triggerTicker++;
      else {
        boolean canChangeEvent = false;
        for (int i = 0; i < eventChanger.length; i++) { 
          if (eventChanger[i]==eventID) canChangeEvent = true;
        }
        if (canChangeEvent) {
          eventTicker++;
          triggerTicker=0;
        } //otherwise dont change anything.
      }
    }
  }

  class Condition {
    int eventID;
    int triggerID;
    String condition;
    public Condition(int eventID, int triggerID, String condition) {
      this.eventID = eventID;
      this.triggerID = triggerID;
      this.condition = condition;
    }
  }
}
