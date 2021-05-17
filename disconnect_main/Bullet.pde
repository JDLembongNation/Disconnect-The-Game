public class Bullet{
  PVector position;
  PVector velocity;
  PVector acceleration = new PVector(0,0); //DEFAULT
  PVector adder;
  boolean wait;
  boolean isPlayerBullet;
  boolean addCustomColour = false;
  int r;
  int g;
  int b;
  int life = 0; //How many times can the bullet bounce off the wall, if the bullet is to die immediately after launching, set this to 1.
  
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
  
   public Bullet(PVector pos, float theta, float extend, float multiplier){
    velocity = new PVector(0, 0);
    position = pos.copy();
    adder =new PVector(sin(theta), cos(theta));
    adder.mult(extend);
    position.add(adder);
    velocity = adder.copy();
    velocity.normalize();
    velocity.mult(multiplier);
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
  public void addColour(int r, int g, int b){
    this.r = r;
    this.g = g;
    this.b = b;
    this.addCustomColour = true;
  }
  public void setLife(int life){this.life = life;}
  
  public void displayRegularBullet(){
    stroke(255);
    fill(255);
    ellipse(position.x, position.y, 8, 8);
  }
   public void displayRegularBullet(int alpha){
    stroke(255);
    fill(255, alpha);
    ellipse(position.x, position.y, 8, 8);
  }
     public void displayRegularColouredBullet(){
    noStroke();
    fill(r,g,b);
    ellipse(position.x, position.y, 8, 8);
    stroke(255);
  }
  public void setToPlayerBullet(){isPlayerBullet = true;}
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
