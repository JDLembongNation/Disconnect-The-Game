public class Bullet{
  PVector position;
  PVector velocity;
  PVector acceleration = new PVector(0,0); //DEFAULT
  PVector adder;
  boolean wait;
  int life; //How many times can the bullet bounce off the wall, if the bullet is to die immediately after launching, set this to 1.
  
  //Constructor for straight bullets. --> Firing in a predefined linear direction
  public Bullet(PVector position, PVector velocity, PVector acceleration){
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.acceleration = acceleration.copy();
  }
  
  //Constructor for bullets forming from pattern, but flowing in straight line from origin. Rotating around an individual. 
  public Bullet(PVector pos, float theta, float extend){
    velocity = new PVector(0, 0);
    position = pos.copy();
    adder =new PVector(sin(theta), cos(theta));
    adder.mult(extend);
    position.add(adder);
    velocity = adder.copy();
    velocity.normalize();
  }
  
    //Constructor for bullets forming from pattern, but flowing in straight line from origin. Rotating around an individual. 
  public Bullet(PVector pos, float theta, float extend, boolean wait){
    this.wait = wait;
    velocity = new PVector(0, 0);
    position = pos.copy();
    adder =new PVector(sin(theta), cos(theta));
    adder.mult(extend);
    position.add(adder);
  }
  
  public void activate(){
    if(wait){
      velocity = adder.copy();
      velocity.normalize();
    }
    wait = false;
  }
  
  public void displayRegularBullet(){
    stroke(255);
    fill(255);
    ellipse(position.x, position.y, 8, 8);
  }
  
  public void update(){
    this.position.add(this.velocity.copy());
    this.velocity.add(this.acceleration.copy());
  }
  boolean isDead() {
    if (position.x > width || position.x < 0 || position.y > height || position.y < 0) {
      life--;
      if(life<=0){
        return true;
      }
      if(position.x > width || position.x < 0) velocity.x = -velocity.x;
      if(position.y > width || position.y < 0) velocity.y = -velocity.y;
      return false;
    } else {
      return false; 
    }
  }
}
