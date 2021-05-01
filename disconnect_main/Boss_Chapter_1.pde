public class Boss_Chapter_1 extends Enemy{
  int maxBullet = 500;
  float theta[];
  float[] ratios = {(2*PI * 1/((1 + sqrt(5)) / 2)),(2*PI * 1/PI)};
  public Boss_Chapter_1(PImage character, PVector position, int lives, float health){
    super(character, position, lives, health);
    this.theta = new float[3];
  }
  
  void run(BulletSystem bs){
    if(super.health > 50) normalMove(bs);
    else if(super.health > 0){
      if(super.lives == 3) spellCard1(bs);
      if(super.lives == 2) spellCard2(bs);
      if(super.lives == 1) spellCard3(bs);
    }else{
      lives--;
      super.health = super.maxHealth;
    }
    move();
  }
  
  void spellCard1(BulletSystem bs){
  
  }
  void spellCard2(BulletSystem bs){
  
  }
  
  void spellCard3(BulletSystem bs){
  
  }
  
  void normalMove(BulletSystem bs){
    if(bs.bullets.size()<maxBullet){
      theta[0]+=ratios[0];
      theta[1] +=ratios[1];
      if(theta[0] > 2*PI) theta[0]-=2*PI;
      if(theta[1] > 2*PI) theta[1]-=2*PI;
      bs.addBullet(new Bullet(super.position, theta[0], 30));
      bs.addBullet(new Bullet(super.position, theta[1], 30, 3));
    }else{
      //time with timer[]
    }
  }
  
  void move(){
    int randomNumber = (int) random(4) + 1;
    if(randomNumber%4 == 0) super.position.x +=2;
        if(randomNumber%4 == 1) super.position.y +=2;
    if(randomNumber%4 == 2) super.position.x -=2;
    if(randomNumber%4 == 3) super.position.y -=2;

  }
}
