public class Boss_Chapter_1 extends Enemy{
  boolean spellCardActive = false;
  int spellCardCurr = 0;
  int spellCardLaser = 100;
  float theta[];
  float[] ratios = {(2*PI * 1/((1 + sqrt(5)) / 2)),(2*PI * 1/PI)};
  public Boss_Chapter_1(PImage character, PVector position, int lives, float health){
    super(character, position, lives, health);
    this.theta = new float[3];
  }
  
  void run(BulletSystem bs){
    if(super.health > 50){ normalMove(bs);
        move();
    }
    else if(super.health > 0){
      if(!spellCardActive){
        bs.clear();
        spellCardActive = true;
      }
      if(super.lives == 2) spellCard1(bs);
      if(super.lives == 1) spellCard2(bs);
    }else{
      lives--;
      super.health = super.maxHealth;
      spellCardActive = false;  
      bs.clear();
  }
  }
  
  //timer 10
  void spellCard1(BulletSystem bs){
    super.inSpell = true;
    if(timers[10] < millis()){
    for(int i = 0; i < 30; i++){
      theta[0] += ratios[1];
      if(theta[0] > 2*PI) theta[0]-=2*PI;
      Bullet b = new Bullet(super.position.copy(), theta[0],30);
      b.setLife(2);
      bs.addBullet(b);
    }
    timers[10] = millis()+800;
    }
    if(timers[11] < millis()){
      if(spellCardCurr < spellCardLaser){
        bs.addBullet(new Bullet(super.position.copy(), new PVector(-2,2), new PVector(0,0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(-1,2), new PVector(0,0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(-0,2), new PVector(0,0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(1,2), new PVector(0,0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(2,2), new PVector(0,0)));
        spellCardCurr++;
      }else{
        timers[11] = millis()+400;
        spellCardCurr = 0;
      }
    }
    
    
  }
  void spellCard2(BulletSystem bs){
    super.inSpell = true;
  }
 
  void normalMove(BulletSystem bs){
    super.inSpell = false;
      theta[0]+=ratios[0];
      theta[1] +=ratios[1];
      if(theta[0] > 2*PI) theta[0]-=2*PI;
      if(theta[1] > 2*PI) theta[1]-=2*PI;
      bs.addBullet(new Bullet(super.position, theta[0], 30, 3-(super.lives)));
      bs.addBullet(new Bullet(super.position, theta[1], 30, 5-(super.lives)));
    
  }
  
  void move(){
    int randomNumber = (int) random(4) + 1;
    if(randomNumber%4 == 0) super.position.x +=2;
        if(randomNumber%4 == 1) super.position.y +=2;
    if(randomNumber%4 == 2) super.position.x -=2;
    if(randomNumber%4 == 3) super.position.y -=2;

  }
}
