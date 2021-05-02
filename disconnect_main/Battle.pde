public class Battle{
  BulletSystem bs;
  boolean isPlayerDead;
  boolean isEnemyDead;
  Player player;
  Enemy enemy;
  boolean isBattleActive;
  void initialize(Player player, Enemy enemy){
    this.player = player;
    this.enemy = enemy;
    bs = new BulletSystem();
    isBattleActive = true;
  }
  
  void run(){
    if(!enemy.isEnemyDead() && !player.isPlayerDead()){
     enemy.run(bs);
     player.run(bs);
     update();  
     bs.run(player, enemy,10);
    }else{
      //return to RPG with appropriate sol.
    }
  }
  
  void update(){
    //draw enemy and players here. 
    fill(255);
    rect(enemy.position.x, enemy.position.y, 20,20);
    rect(player.position.x, player.position.y, 10,10);
     
  }
  
  
}
