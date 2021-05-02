public class RPG {
  final int CITY_ITERATOR = 0;
  ArrayList<Scene> scenes;
  boolean isRPGActive;
  boolean isCityEventFinished;
  boolean isSceneFinished;
  
  boolean showNextText;
  float timeStamp;
  boolean isMapGenerated = false;
  Map map;
  
  //TEXT SLOT is 6.

  public RPG(JSONObject json) { //Will load each scene accordingly
    showNextText = false;
    scenes = new ArrayList<Scene>();
    isRPGActive = true;
    parseJSON(json);
    System.out.println(scenes.size());
  }

  //Will return true if event is finished.
  public boolean execScene(int scene) {
    switch(scene) {
    case 0: 
      {
        execOpening(); 
        return false;
      }
    default:
      executeScene(scene);
      return false;
    }
  }

  /**
   - Move Around 
   - If in Contact --> Interact, Once done interacting, move around.
   */

  private void executeScene(int scene) {
    if (!isMapGenerated) {
      map = new Map();
      isMapGenerated = true;
    }
    if (map.isCompleted) {
      isMapGenerated = false;
      //Move on to the next scene here.
    }
    //Execute Player Movements. 
    if (keys[0])map.playerMovement(0);
    if (keys[1])map.playerMovement(1);
    if (keys[2])map.playerMovement(2);
    if (keys[3])map.playerMovement(3);
    if (keys[4]) {
      //Interact!!!!
      TriggerEvent trigger = map.playerInteract();
      if (trigger!=null) {
        System.out.println(trigger.text[0]);
      }
    }
    map.render();
  }

  //Have a separate function call for opening scene as there are a lot of cutscenes. 
  //Will follow an FSM. 
  private void execOpening() {
    if(!isSceneFinished){
      if(!isCityEventFinished)
        cityEvent();
      else 
        forestEvent();
      }
  }
  
  private void cityEvent(){
    Event event = scenes.get(0).events.get(0);
    int maxTextSlot = event.text.length;
    showCityBackground();
    showTextBox(event.text[iterators[6]]);
    if (showNextText) {
      if (iterators[6] ==maxTextSlot-1) {
        isCityEventFinished = true;
        iterators[6] = 0; //RESET TEXT for next event.
      }
      if (iterators[6] < maxTextSlot-1) {
        iterators[6] +=1;
      }
      showNextText = false;
    }
  }
  
  private void forestEvent(){
    Event event = scenes.get(0).events.get(1);
    int maxTextSlot = event.text.length;
    showForestBackground();
    showTextBox(event.text[iterators[6]]);
    if(showNextText){
      if(iterators[6] == maxTextSlot-1){
        isSceneFinished=true;
      }
      else if (iterators[6] < maxTextSlot-1) {
        iterators[6] +=1;
      }
      showNextText = false;
    }
  }

  private void showCityBackground() {
    image(openingBG, -iterators[CITY_ITERATOR], 0);
    if(millis() > timers[12]){
      iterators[CITY_ITERATOR]++;
      if (iterators[CITY_ITERATOR] > 1100) iterators[CITY_ITERATOR] = 0;
      timers[12] = millis()+30;  
    }
  }

  private void showForestBackground() {
    image(forestBackground[0], -iterators[1], 0);
    image(forestBackground[1], -iterators[2], 0);
    image(forestBackground[2], -iterators[3], 0);
    image(forestBackground[3], -iterators[4], 0);
    image(forestBackground[4], -iterators[5], 0);
    if (millis() > timers[0]) {
      iterators[1]++;
      if (iterators[1] > 400) iterators[1] = 0;
      timers[0] = millis()+2000;
    }
    if (millis() > timers[1]) {
      iterators[2]++;
      if (iterators[2] > 400) iterators[2] = 0;
      timers[1] = millis()+1000;
    }
    if (millis() > timers[2]) {
      iterators[3]++;
      if (iterators[3] > 1400) iterators[3] = 0;
      timers[2] = millis()+500;
    }
    if (millis() > timers[3]) {
      iterators[4]++;
      if (iterators[4] > 1400) iterators[4] = 0;
      timers[3] = millis()+300;
    }
    if (millis() > timers[4]) {
      iterators[5]++;
      if (iterators[5] > 1400) iterators[5] = 0;
      timers[4] = millis()+2;
    }
  }

  private void showTextBox(String input) {
    fill(255, 180);
    rect(50, 450, 500, 100);
    fill(0);
    textFont(font);
    text(input, 60, 460, 480, 80);
  }

  private void parseJSON(JSONObject json) {
    JSONArray s = json.getJSONArray("scene");
    for (int i = 0; i < s.size(); i++) {
      JSONObject sc = s.getJSONObject(i);
      JSONArray eventArray = sc.getJSONArray("event");
      ArrayList<Event> events = new ArrayList<Event>();
      for (int j = 0; j < eventArray.size(); j++) {
        JSONObject event = eventArray.getJSONObject(j);
        JSONArray t = event.getJSONArray("text");
        String[] text = new String[t.size()]; 
        for (int k = 0; k < t.size(); k++) {
          text[k] = t.getString(k);
        }
        events.add(new Event(event.getInt("eventID"), event.getInt("triggerID"), text));
      }
      scenes.add(new Scene(sc.getInt("sceneID"), sc.getString("title"), sc.getString("subtitleTop"), sc.getString("subtitleBottom"), events));
    }
  }
}
