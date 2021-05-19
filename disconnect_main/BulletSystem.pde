public class BulletSystem{
  ArrayList<Bullet> bullets;
  PVector origin;
  
  public BulletSystem(){
    bullets = new ArrayList<Bullet>();  
  }
  
  void addBullet(Bullet bullet){
    bullets.add(bullet);
  }
  
  void addBullet(PVector position, PVector velocity, PVector acceleration){
    bullets.add(new Bullet(position, velocity, acceleration));
  }
 
  void addBullet(PVector position, float ratio, float extend){
    if(ratio > 2*PI) ratio -= 2*PI;
    bullets.add(new Bullet(position, ratio, extend));
  }
  
  void run(Player player, Enemy enemy, int playerConstraints, int enemyConstraints){
    for(int i = 0; i< bullets.size(); i++){
      Bullet b = bullets.get(i);
      b.update();
      if(!b.isPlayerBullet){
        if(b.addCustomColour) b.displayRegularColouredBullet();
         else b.displayRegularBullet();
      if(inRegion(b, player.position, playerConstraints)){
        player.deductLife();
        }
      }else{
         b.displayRegularBullet(130);
        if(inRegion(b, enemy.position, enemyConstraints)){
          if(enemy.inSpell){
            enemy.health-=5;//0.05
          }
          else enemy.health-=5; //0.2
        }
      }
      if(b.isDead()){
        bullets.remove(b);
      }
    }
  }
  
  void clear(){
    bullets.clear();
  }
  
  boolean inRegion(Bullet subject, PVector character, int regionSize){
    PVector result = subject.position.copy().sub(character);
    return (result.mag() < (regionSize+subject.radius));
  }
}
