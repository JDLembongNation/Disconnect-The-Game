public class Battle {
  BulletSystem bs;
  boolean isPlayerDead;
  boolean isEnemyDead;
  Player player;
  Enemy enemy;
  boolean isBattleActive;
  void initialize(Player player, Enemy enemy) {
    isPlayerDead = false;
    isEnemyDead = false;
    this.player = player;
    this.enemy = enemy;
    bs = new BulletSystem();
    isBattleActive = true;
  }

  void run() {
    if (!enemy.isEnemyDead() && !player.isPlayerDead()) {
      update();  
      enemy.run(bs);
      player.run(bs);
      bs.run(player, enemy, 10, 20);
    } else {
      stroke(0);
      //return to RPG with appropriate sol.
      isBattleActive = false;
      if(player.isPlayerDead()) isPlayerDead = true;
      else isEnemyDead = true;
    }
  }

  void update() {
    image(battleImages[0], 0, 0);
    //draw enemy and players here. 
    fill(255);
    rect(enemy.position.x, enemy.position.y, 20, 20);
    rect(player.position.x, player.position.y, 10, 10);
    hud();   
  }

  void hud() {
    //PLAYER
    fill(0, 130);
    rect(0, 550, 100, 50);
    fill(255);
    textSize(16);
    text("Lives: " +player.lives, 10, 570);
    //ENEMY
    fill(0, 130);
    rect(0, 0, 400, 30);
    fill(255);
    rect(20, 10, enemy.health * 3, 10);
  }

}
