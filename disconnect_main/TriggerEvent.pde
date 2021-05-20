//To be called when the player hits something in the RPG.
public class TriggerEvent{
  String[] text;//Text for textbox. 
  boolean isMoney;
  boolean isTransition; //Converting between battle and RPG
  String name; //Person who sent the message.
  int coins;
  boolean isSceneFinished;
  //Item 
  //Stat changes 
  //Any upgrades? 
  //New weapons??
  public TriggerEvent(){
    
  }
  public TriggerEvent(int coins){
    this.isMoney = true;
    this.text = new String[1];
    if(coins > 0) this.text[1]="You won " + coins +" coins!";
    else this.text[1]="You lost " + coins +" coins...";
  }
    public TriggerEvent(String[] text){
     this.text = text; 
  }
  public TriggerEvent(String[] text,String name){
    this.name=  name;
    this.text = text;
  }
  public TriggerEvent(String t){
    this.text = new String[1];
    this.text[0] = t;    
  }
}
