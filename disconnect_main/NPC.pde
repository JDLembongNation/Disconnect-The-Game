public class NPC{
  boolean isInStory;
  int eventTicker = 0;
  ArrayList<String[]> speech;
  public NPC(boolean isInStory, ArrayList<String[]> speech){
    this.isInStory = isInStory;
    this.speech = speech;
  }
  public String[] getSpeech(){
     String[] res = speech.get(eventTicker);
     if(eventTicker <speech.size()-1) eventTicker++;
     return res;
  }
}
