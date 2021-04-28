public class Scene{
  ArrayList<Event> events;
  int sceneID;
  String title;
  String subtitleTop;
  String subtitleBottom;
  NPC npc;
  
  public Scene(int sceneID, String title, String subtitleTop, String subtitleBottom, ArrayList<Event> events){
    this.sceneID = sceneID;
    this.title = title;
    this.subtitleTop = subtitleTop;
    this.subtitleBottom = subtitleBottom;
    this.events = events;
  }
  
  
  class Map{
  }
}
