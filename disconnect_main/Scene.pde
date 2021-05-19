public class Scene{
  ArrayList<Event> events;
  int sceneID;
  String title;
  String subtitleTop;
  String subtitleBottom;
  ArrayList<NPC> npcList;
  PImage backgroundImages[];
  
  public Scene(int sceneID, String title, String subtitleTop, String subtitleBottom, ArrayList<Event> events, ArrayList<NPC> npcList, JSONArray objects){
    backgroundImages = new PImage[7];
    this.sceneID = sceneID;
    this.title = title;
    this.subtitleTop = subtitleTop;
    this.subtitleBottom = subtitleBottom;
    this.events = events;
    this.npcList = npcList;
    for(int i = 0; i < objects.size(); i++){
      backgroundImages[i] = loadImage("./data/background/"+sceneID+"/"+i+".png");
    }
  } 
}
