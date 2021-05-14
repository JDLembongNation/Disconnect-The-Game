public class NPC{
  PVector position;
  String name;
  boolean isInStory;
  int eventTicker = 0;
  ArrayList<String[]> speeches;
  String[] speech;
  public NPC(boolean isInStory, String name, ArrayList<String[]> speeches){
    this.isInStory = isInStory;
    this.speeches = speeches;
    this.name = name;
  }
    public NPC(boolean isInStory, String name, String[] speech){
    this.isInStory = isInStory;
    this.speech = speech;
    this.name = name;
  }
  public String[] getSpeech(){
    if(isInStory){
     String[] res = speeches.get(eventTicker);
     if(eventTicker <speeches.size()-1) eventTicker++;
     return res;
    }else{
     return speech;   
    }
  }
}
