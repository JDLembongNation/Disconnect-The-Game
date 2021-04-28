public class RPG{
  ArrayList<Scene> scenes;
  boolean isEventFinished;
  boolean showNextText;
  int currentTextSlot = 0;
  boolean isMapGenerated = false;
  Map map;


  public RPG(JSONObject json){ //Will load each scene accordingly.
    showNextText = false;
    scenes = new ArrayList<Scene>();
    isEventFinished = false;
    parseJSON(json);
    System.out.println(scenes.size());
  }
  
  //Will return true if event is finished.
  public boolean execScene(int scene){
    switch(scene){
      case 0: {
        execOpening(); 
        if(isEventFinished){
          isEventFinished = false;
          return true;
        }
        return false;
      }
      default: return false;
    }
  }
  
  
  /**
     - Move Around 
     - If in Contact --> Interact, Once done interacting, move around.
     
  */
  
  private void executeScene(int scene, boolean keys[]){
    if(!isMapGenerated){
      map = new Map();
      isMapGenerated = true;
    }
    if(map.isCompleted){
      isMapGenerated = false;
      //Move on to the next scene here. 
    }
    //Execute Player Movements. 
    if(keys[0])map.playerMovement(0);
    if(keys[1])map.playerMovement(1);
    if(keys[2])map.playerMovement(2);
    if(keys[3])map.playerMovement(3);
    if(keys[4]){
      //Interact!!!!
      TriggerEvent trigger = map.playerInteract();
      if(trigger!=null){
        System.out.println(trigger.text[0]);
      }
    }
    
  }
  
  void keyPressed(){
    if(key == 'k') System.out.println("OK");
  }
  
  
  private void showTextBox(String input){
   fill(255);
   rect(50,470,500,80);
   fill(0);
   textFont(font);
   text(input, 60,480,480,60);
  }
  
  //Have a separate function call for opening scene as there are a lot of cutscenes. 
  //Will follow an FSM. 
  private void execOpening(){
     Scene openingScene = scenes.get(0);
     boolean eventFinished = false;
     Event event = openingScene.events.get(0);
     int numberOfEvents = openingScene.events.size();
     int maxTextSlot = event.text.length;
     showTextBox(event.text[currentTextSlot]);
     if(showNextText){
       if(currentTextSlot < maxTextSlot-1){
         currentTextSlot +=1;
       }
       showNextText = false;
     }
  }
  
  private void showOpeningBackground(){
    
  }
  
  private void parseJSON(JSONObject json){
    JSONArray s = json.getJSONArray("scene");
    for(int i = 0; i < s.size(); i++){
      JSONObject sc = s.getJSONObject(i);
      JSONArray eventArray = sc.getJSONArray("event");
      ArrayList<Event> events = new ArrayList<Event>();
      for(int j = 0; j < eventArray.size(); j++){
        JSONObject event = eventArray.getJSONObject(j);
        JSONArray t = event.getJSONArray("text");
        String[] text = new String[t.size()]; 
        for(int k = 0; k < t.size(); k++){
          text[k] = t.getString(k);
        }
        events.add(new Event(event.getInt("eventID"), event.getInt("triggerID"),text));
      }
      scenes.add(new Scene(sc.getInt("sceneID"), sc.getString("title"),sc.getString("subtitleTop"),sc.getString("subtitleBottom"), events));
    }
  }
}
