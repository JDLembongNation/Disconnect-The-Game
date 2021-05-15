public class NPC{
  String initialPosition;
  PVector position;
  String name;
  boolean isInStory;
  int eventTicker = 0;
  int triggerTicker = 0;
  ArrayList<Event> eventList;
  String[] speech;
  public NPC(boolean isInStory, String name, String initialPosition,ArrayList<Event> eventList){
    this.isInStory = isInStory;
    this.name = name;
    this.initialPosition = initialPosition;
    this.eventList = eventList;  
  }
    public NPC(boolean isInStory, String name, String[] speech){
    this.isInStory = isInStory;
    this.speech = speech;
    this.name = name;
  }
  public String[] getSpeech(){
    if(isInStory){
     for(int i = 0; i < eventList.size();i++){
       if(eventList.get(i).eventID == eventTicker){
         if(eventList.get(i).triggerID == triggerTicker){
           return eventList.get(i).text;
         }
       }
     }
     return null;
    }else{
     return speech;   
    }
  }
}
