public class Battle{
  BulletSystem bs;
  boolean isPlayerDead;
  boolean isEnemyDead;
  Player player;
  Enemy enemy;
  void initialize(Player player, Enemy enemy){
    this.player = player;
    this.enemy = enemy;
  }
  
  void run(){
     enemy.run();
     player.run();
     update();  
  }
  
  void update(){
    //draw enemy and players here. 
     PVector enemyPosition = enemy.position;
     PVector playerPosition = player.position;
  }
  
  
}
