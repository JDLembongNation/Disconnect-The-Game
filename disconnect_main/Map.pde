public class Map{
  final int unitLength = 30;
  PVector playerPosition;
  boolean isCompleted;
  ArrayList<NPC> npcs;
  MapNode root;
  MapNode current;
  int currentPosition = 0;
  public Map(){
    isCompleted=false;
    playerPosition = new PVector(0,0);
  }
  //List of items available.
  //Events and interactions. 
  //Mappings of images and icons
  
  //Want a function to return a map, an image of a map and interactions in the map. 
  //Function here that deals with player movement in the map. 
  //Ie. void playermove(direction); TriggerEvent playerinteract(), if theres something return something. 
   void playerMovement(int direction){
     if(timers[5] < millis()){
     switch(direction){
       case 0: {
         if(playerPosition.x >0) playerPosition.x -= unitLength;
         currentPosition = 0;
         break;
       }case 1: {
         if(playerPosition.y > 0)playerPosition.y -=unitLength;
         currentPosition=1;
         break;
       }case 2: {
       if(playerPosition.x <width-unitLength) playerPosition.x += unitLength;
         currentPosition=2;
         break;
       }case 3: {
         if(playerPosition.y < height-60)playerPosition.y +=unitLength;
         currentPosition=3;
         break;
       }case 4: 
         break;
     }
     timers[5] = millis()+150;
     }
   }
   
   void render(){
     //Display all the assets etc. 
     //hard code for now. 
     spawnFloor(0);
     renderCharacter();
   }
   
   TriggerEvent playerInteract(){
     String[] text = {"You interacted with something!"};
     return new TriggerEvent(text);
   }
   
   public class MapNode{
     //Each map node will have a fixed size of 600x600. 
      MapNode nodes[] = new MapNode[4];
      int entryPoints[] = new int[8]; //LEFT UP RIGHT DOWN
      void addTopNode(){
        nodes[1] = new MapNode();
        //generate entry point.
      }
      void addLeftNode(){
        nodes[0] = new MapNode();
      }
      void addRightNode(){
        nodes[2] = new MapNode();
      }
      
      void addBottomNode(){
        nodes[3] = new MapNode();
      }
   }
   
   void spawnFloor(int floorType){
     for(int i = 0; i < width; i+=unitLength){
       for(int j = 0; j < height; j+=unitLength){
          image(rpgBackground[floorType], i,j);
       }
     }
   }
   void renderCharacter(){
     image(mainCharacter[currentPosition], playerPosition.x, playerPosition.y);
     
   }
   
}
