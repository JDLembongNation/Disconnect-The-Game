//To be called when the player hits something in the RPG.
public class TriggerEvent{
  String[] text;//Text for textbox. 
  boolean isTransition; //Converting between battle and RPG
  //Item 
  //Stat changes 
  //Any upgrades? 
  //New weapons??
  public TriggerEvent(){
    
  }
    public TriggerEvent(String[] text){
     this.text = text; 
  }
}
