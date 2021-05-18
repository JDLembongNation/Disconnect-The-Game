public class RPG {
  final int CITY_ITERATOR = 0;
  int alpha = 255;
  ArrayList<Scene> scenes;
  boolean reverse = false;
  boolean transitionComplete = false;
  String currentText = "";
  char[] currentCharText;
  String textString = "";
  int textBoxIterator;
  boolean isRPGActive;
  boolean isCityEventFinished;
  boolean isForestEventFinished;
  boolean isSceneFinished;
  boolean isTextBoxActive = false;
  boolean isInteractionActive = false;
  boolean isBattleActive = false;
  TriggerEvent trigger;
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

  private void executeScene(int scene) {
    if (this.isBattleActive) {
      if (!battle.isBattleActive) {
        this.isBattleActive = false;
        if (battle.isPlayerDead) {
        } else {
          map.globalEventID++;
          System.out.println("THE NEW GLOBAL ID:" + map.globalEventID);
        }
      } else battle.run();
    } else {
      if (!isMapGenerated) {
        map = new Map(scenes.get(scene));
        isMapGenerated = true;
      }
      if (map.isCompleted) {
        isMapGenerated = false;
        //Move on to the next scene here.
      }
      map.render();
      //Execute Player Movements. 
      if (keys[0])map.playerMovement(0);
      if (keys[1])map.playerMovement(1);
      if (keys[2])map.playerMovement(2);
      if (keys[3])map.playerMovement(3);
      if (keys[4]) {
        if (timers[14] < millis()) {
          timers[14] = millis()+100;
          if (!isInteractionActive) {
            trigger = map.playerInteract();
            if (trigger!=null) {
              isInteractionActive=true;
              isTextBoxActive=true;
            }
          }
        }
      }
      if (isTextBoxActive) {
        if(trigger.name!=null) showNameBox(trigger.name);
        showTextBox(trigger.text[iterators[7]]);
        if (showNextText) {
          if (iterators[7] == trigger.text.length-1) {
            isInteractionActive = false;
            isTextBoxActive =false;
            iterators[7] = 0;
            if (trigger.isTransition) {
              System.out.println("Battle Triggerd");
              triggerBattle();
            }
          } else if (iterators[7] <trigger.text.length-1)iterators[7]++;
          showNextText = false;
        }
      }
    }
  }

  public void triggerBattle() {
    battle.initialize(new Player(3), new Boss_Chapter_1(null, new PVector(300, 200), 2, 100)); // Change this later.
    isBattleActive = true;
  }

  //Have a separate function call for opening scene as there are a lot of cutscenes. 
  //Will follow an FSM. 
  private void execOpening() {
    if (!isSceneFinished) {
      if (!isCityEventFinished)
        cityEvent();
      else {
        if (!isForestEventFinished) {
          forestEvent();
        } else {
          if (!transitionComplete)
            showChapter();
          else isSceneFinished = true;
        }
      }
    }
    //Transition.
  }

  private void cityEvent() {
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

  private void forestEvent() {
    Event event = scenes.get(0).events.get(1);
    int maxTextSlot = event.text.length;
    showForestBackground();
    showTextBox(event.text[iterators[6]]);
    if (showNextText) {
      if (iterators[6] == maxTextSlot-1) {
        isForestEventFinished=true;
      } else if (iterators[6] < maxTextSlot-1) {
        iterators[6] +=1;
      }
      showNextText = false;
    }
  }

  private void showCityBackground() {
    image(openingBG, -iterators[CITY_ITERATOR], 0);
    if (millis() > timers[12]) {
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
    String resultant = "";
    if (input.equals(currentText)) {
      for (int i = 0; i < textBoxIterator; i++) {
        resultant += currentCharText[i];
      }
      if (timers[16] < millis()) { //add letter
        if (textBoxIterator < input.length())
          textBoxIterator++;
        timers[16] = millis()+5;
      }
    } else {
      currentText = input;
      currentCharText = input.toCharArray();
      textBoxIterator = 0;
    }
    fill(255, 180);
    rect(50, 450, 500, 100);
    fill(0);
    textFont(font);
    text(resultant, 60, 460, 480, 80);
  }
  private void showNameBox(String name) {
    fill(255, 180);
    rect(50, 410, 200, 40);
    fill(0);
    textFont(font);
    text(name, 55, 415, 190, 25);
  }

  private void showChapter() {
    if (timers[15] < millis()) {
      if (!reverse) {
        if (alpha>4) {
          alpha-=3;
          timers[15] = millis()+10;
        } else {
          timers[15] = millis()+3000;
          reverse = true;
        }
      } else {
        if (alpha < 240) {
          alpha+=2;
          timers[15] = millis()+10;
        } else {
          alpha = 255;
          transitionComplete = true;
        }
      }
    }
    noStroke();
    image(transitionBackground[0], 0, 0);
    fill(0, alpha);
    rect(0, 0, 600, 600);
    stroke(0);
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
      JSONObject npcObject = sc.getJSONObject("npc");
      ArrayList<NPC> npcs = new ArrayList<NPC>();
      JSONArray mainStoryNPC = npcObject.getJSONArray("storyCharacters");
      for (int j = 0; j < mainStoryNPC.size(); j++) {
        String name = mainStoryNPC.getJSONObject(j).getString("name");
        JSONArray e = mainStoryNPC.getJSONObject(j).getJSONArray("event");
        ArrayList<Event> npcEvent = new ArrayList<Event>();
        for (int k = 0; k < e.size(); k++) {
          JSONObject eo = e.getJSONObject(k);
          JSONArray mainText = eo.getJSONArray("text");
          String[] text = new String[mainText.size()];
          for (int l = 0; l < mainText.size(); l++) {
            text[l] = mainText.getString(l);
          }
          npcEvent.add(new Event(eo.getInt("eventID"), eo.getInt("triggerID"), text));
        }
        npcs.add(new NPC(true, name, mainStoryNPC.getJSONObject(j).getString("position"), npcEvent, mainStoryNPC.getJSONObject(j).getJSONArray("conditions"), 
          mainStoryNPC.getJSONObject(j).getJSONArray("endOfEvent"), mainStoryNPC.getJSONObject(j).getJSONObject("battleTrigger"), mainStoryNPC.getJSONObject(j).getString("movement")));
      }
      JSONArray sideStoryNPC = npcObject.getJSONArray("sideCharacters");
      for (int j = 0; j < sideStoryNPC.size(); j++) {
        String name = sideStoryNPC.getJSONObject(j).getString("name");
        JSONArray t = sideStoryNPC.getJSONObject(j).getJSONArray("text");
        String[] text  = new String[t.size()];
        for (int k = 0; k < t.size(); k++) {
          text[k] = t.getString(k);
        }
        npcs.add(new NPC(false, name, text));
      }
      scenes.add(new Scene(sc.getInt("sceneID"), sc.getString("title"), sc.getString("subtitleTop"), sc.getString("subtitleBottom"), events, npcs));
    }
  }
}
