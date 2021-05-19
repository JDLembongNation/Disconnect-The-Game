public class Boss_Chapter_1 extends Enemy {
  int alpha = 0;
  boolean reverse = false;
  boolean spellCardActive = false;
  int spellCardCurr = 0;
  int spellCardLaser = 50;
  float theta[];
  float[] ratios = {(2*PI * 1/((1 + sqrt(5)) / 2)), (2*PI * 1/PI), (2*PI * 1/4)};
  public Boss_Chapter_1(PImage character, PVector position, int lives, float health) {
    super(character, position, lives, health);
    this.theta = new float[3];
  }

  void run(BulletSystem bs) {
    if (super.health > 25) { 
      normalMove(bs);
      move();
    } else if (super.health > 0) {
      if (!spellCardActive) {
        bs.clear();
        spellCardActive = true;
      }
      if (super.lives == 2) {
        spellCard1(bs);
        moveAnimation("Ripples Of Time");
      }
      if (super.lives == 1) {
        moveAnimation("Final Fight");
        spellCard2(bs);
      }
    } else {
      lives--;
      super.health = super.maxHealth;
      reverse = false;
      spellCardActive = false;  
      bs.clear();
    }
  }

  //timer 10
  void spellCard2(BulletSystem bs) {
    super.inSpell = true;
    if (timers[23] < millis()) {
      Bullet b = new Bullet(30, super.position.copy(), new PVector(-3, 2), new PVector(0, 0));
      b.setLife(2);
      bs.addBullet(b);
      b =new Bullet(30, super.position.copy(), new PVector(-1.5, 2), new PVector(0, 0));
      b.setLife(2);
      bs.addBullet(b);
      b =new Bullet(30, super.position.copy(), new PVector(-0, 2), new PVector(0, 0));
      b.setLife(2);
      bs.addBullet(b);
      b =new Bullet(30, super.position.copy(), new PVector(1.5, 2), new PVector(0, 0));
      b.setLife(2);
      bs.addBullet(b);
      b =new Bullet(30, super.position.copy(), new PVector(3, 2), new PVector(0, 0));
      b.setLife(2);
      bs.addBullet(b);
      timers[23] = millis() + 1000;
    }
    if (timers[10] < millis()) {
      for (int i = 0; i < 30; i++) {
        theta[0] += ratios[1];
        if (theta[0] > 2*PI) theta[0]-=2*PI;
        Bullet b = new Bullet(super.position.copy(), theta[0], 30);
        b.setLife(2);
        bs.addBullet(b);
      }
      timers[10] = millis()+800;
    }
    if (timers[11] < millis()) {
      if (spellCardCurr < spellCardLaser) {
        bs.addBullet(new Bullet(super.position.copy(), new PVector(-2, 2), new PVector(0, 0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(-1, 2), new PVector(0, 0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(-0, 2), new PVector(0, 0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(1, 2), new PVector(0, 0)));
        bs.addBullet(new Bullet(super.position.copy(), new PVector(2, 2), new PVector(0, 0)));
        spellCardCurr++;
      } else {
        timers[11] = millis()+400;
        spellCardCurr = 0;
      }
    }
  }
  void spellCard1(BulletSystem bs) {
    super.inSpell = true;
    if (timers[13] < millis()) {
      theta[0]+=PI/32;
      for (int i = 0; i < 4; i++) {
        theta[0] += ratios[2];
        if (theta[0] > 2*PI) theta[0]-=2*PI;
        Bullet b = new Bullet(super.position.copy(), theta[0], 30, 2);
        b.setLife(3);
        bs.addBullet(b);
      }
      timers[13] = millis()+100;
    }
  }

  void normalMove(BulletSystem bs) {
    super.inSpell = false;
    theta[0]+=ratios[0];
    theta[1] +=ratios[1];
    if (theta[0] > 2*PI) theta[0]-=2*PI;
    if (theta[1] > 2*PI) theta[1]-=2*PI;
    Bullet b1 = new Bullet(super.position, theta[0], 30, 3-(super.lives));
    Bullet b2 = new Bullet(super.position, theta[1], 30, 5-(super.lives));
    b1.addColour(255, 255, 255);
    b2.addColour(146, 55, 77);
    bs.addBullet(b1);
    bs.addBullet(b2);
  }

  void move() {
    int randomNumber = (int) random(4) + 1;
    if (randomNumber%4 == 0) super.position.x +=2;
    if (randomNumber%4 == 1) super.position.y +=2;
    if (randomNumber%4 == 2) super.position.x -=2;
    if (randomNumber%4 == 3) super.position.y -=2;
  }
  void moveAnimation(String name) {
    if (timers[8] < millis()) {
      if (!reverse) {
        if (alpha < 210) {
          alpha+=5;
          timers[8]=millis()+10;
        } else {
          timers[8]=millis()+3000;
          reverse = true;
        }
      } else {
        if (alpha > 4) {
          alpha-=4;
        } else {
          alpha=0;
        }
      }
    }
    noStroke();
    fill(0, 0, 0, alpha);
    rect(0, 300, 600, 100);
    fill(255, alpha);
    text(name, 200, 330);
    stroke(0);
  }
}
