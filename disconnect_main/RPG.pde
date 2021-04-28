public class RPG{
  ArrayList<Scene> scenes;
  boolean isEventFinished;

  public RPG(JSONObject json){ //Will load each scene accordingly.
    scenes = new ArrayList<>();
    isEventFinished = false;
    parseJSON(json);
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
  private void showTextBox(String input){
   fill(255);
   rect(50,470,500,80);
   fill(0);
   textFont(font);
   text(input, 60,480,480,60);
  }
  
  private void execOpening(){
    
  }
  
  private void parseJSON(JSONObject json){
    JSONArray s = json.getJSONArray("scene");
    for(int i = 0; i < s.size(); i++){
      JSONObject sc = s.getJSONObject(i);
      JSONArray eventArray = sc.getJSONArray("event");
      ArrayList<Event> events = new ArrayList<>();
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
