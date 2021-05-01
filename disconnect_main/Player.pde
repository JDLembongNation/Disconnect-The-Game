public class Player{
  PVector position;
  boolean isDead;
  public Player(){
     position = new PVector(300,550);
  }
  void run(){
    if(keys[0]){
      if(position.x > 0) position.x -=2;
    }
    if(keys[1]){
      if(position.y > 0) position.y -=2;
    }
    if(keys[2]){
      if(position.x < width) position.x +=2;
    }
    if(keys[3]){
      if(position.y < height) position.y +=2;
    }
  }
  
  boolean isPlayerDead(){
    return false;
  }
  void deductLife(){ //make player temporarily invincible so they have chance to regain.
    if(millis() > timers[6]){
      System.out.println("DEDUCTED LIFE");
      timers[6]+=millis()+100;
    }
  }
}
