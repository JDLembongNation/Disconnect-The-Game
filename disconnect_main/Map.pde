public class Map{
  boolean isCompleted;
  ArrayList<NPC> npcs;
  public Map(){
    isCompleted=false;
  }
  //List of items available.
  //Events and interactions. 
  //Mappings of images and icons
  
  //Want a function to return a map, an image of a map and interactions in the map. 
  //Function here that deals with player movement in the map. 
  //Ie. void playermove(direction); TriggerEvent playerinteract(), if theres something return something. 
   void playerMovement(int direction){
     
   }
   
   TriggerEvent playerInteract(){
     String[] text = {"You interacted with something!"};
     return new TriggerEvent(text);
   }
}
