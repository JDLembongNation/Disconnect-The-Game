public class Battle{
  BulletSystem bs;
  boolean isPlayerDead;
  boolean isEnemyDead;
  Player player;
  Enemy enemy;
  void initialize(Player player, Enemy enemy){
    this.player = player;
    this.enemy = enemy;
    bs = new BulletSystem();
  }
  
  void run(){
    if(!enemy.isEnemyDead() && !player.isPlayerDead()){
     enemy.run(bs);
     player.run();
     update();  
     bs.run(player, 10);
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
