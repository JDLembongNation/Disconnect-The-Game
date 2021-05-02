public abstract class Enemy{
  PImage character;
  int spellCards;
  float health;
  float maxHealth;
  PVector position;
  int lives;
  boolean inSpell;
  //Method: Invoke Spellcards. (enemy position)
  public Enemy(PImage character, PVector position, int lives, float health){
    this.character = character;
    this.position = position;
    this.lives = lives;
    this.health = health;
    this.maxHealth = health;
  }
  
  public boolean isEnemyDead(){
    return (lives == 0);
  }
  abstract void run(BulletSystem bs);

}
