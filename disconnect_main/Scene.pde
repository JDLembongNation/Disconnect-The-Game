public class Scene{
  ArrayList<Event> events;
  int sceneID;
  String title;
  String subtitleTop;
  String subtitleBottom;
  ArrayList<NPC> npcList;
  
  public Scene(int sceneID, String title, String subtitleTop, String subtitleBottom, ArrayList<Event> events, ArrayList<NPC> npcList){
    this.sceneID = sceneID;
    this.title = title;
    this.subtitleTop = subtitleTop;
    this.subtitleBottom = subtitleBottom;
    this.events = events;
    this.npcList = npcList;
  }
  
  
}
