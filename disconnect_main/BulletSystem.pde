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
  
  void run(Player player, int constraints){
    for(int i = 0; i< bullets.size(); i++){
      Bullet b = bullets.get(i);
      b.update();
      b.displayRegularBullet();
      if(inRegion(b.position, player.position, constraints)){
        player.deductLife();
      }
      if(b.isDead()){
        bullets.remove(b);
      }
    }
  }
  
  boolean inRegion(PVector subject, PVector region, int regionSize){
    return (subject.x > region.x && subject.x < region.x +regionSize && subject.y > region.y && subject.y < region.y + regionSize);
  }
}
