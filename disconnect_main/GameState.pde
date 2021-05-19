//Both RPG and Battle will communicate through Gamestate. 
public class GameState{
    ArrayList<Condition> objectivesActive;
  boolean didWin;
  int coins;
  void addObjective(Condition c){
    objectivesActive.add(c);
  }
  boolean hasObjective(Condition c){
    for(int i = 0; i < objectivesActive.size(); i++){
      if(objectivesActive.get(i).equals(c)) return true;
    }
    return false;
  }
}
