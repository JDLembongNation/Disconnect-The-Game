public class BulletSystem{
  ArrayList<Bullet> bullets;
  PVector origin;
  
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
  
  void run(){
    for(int i = 0; i< bullets.size(); i++){
      Bullet b = bullets.get(i);
      b.update();
      if(b.isDead()){
        bullets.remove(b);
      }
    }
  }
}
