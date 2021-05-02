public class Player{
  PVector position;
  boolean isDead;
  public Player(){
     position = new PVector(300,550);
  }
  void run(BulletSystem bs){
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
    if(keys[5]){
      //FIRE THAT SHIT
      if(timers[7] < millis()){
      Bullet b = new Bullet(position.copy(), new PVector(0, -5), new PVector(0,0));
      b.setToPlayerBullet();
      bs.addBullet(b);
      timers[7] = millis() + 75;
      }
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
