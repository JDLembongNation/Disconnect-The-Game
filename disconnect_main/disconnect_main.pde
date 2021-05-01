PFont font;
RPG rpg;
PImage openingBG;
PImage forestBackground[];
PImage rpgBackground[];
PImage mainCharacter[];
  float timers[];
  int iterators[];
boolean keys[];
void setup() {
  size(600,600);
  keys = new boolean[5];
  font = createFont("monogram.ttf", 30);
  rpg = new RPG(loadJSONObject("./data/resource.json"));
  forestBackground = new PImage[5];
  rpgBackground = new PImage[3];
  mainCharacter = new PImage[4];
  for(int i = 0; i < 5; i++){
    forestBackground[i] = loadImage("./data/opening-bg/"+i+".png");
  }
  for(int i = 0; i < 3; i++){
    rpgBackground[i] = loadImage("./data/background/"+i+".png");
  }
  for(int i = 0; i < 4; i++){
    mainCharacter[i] = loadImage("./data/characters/"+i+".png");
  }
  openingBG = loadImage("./data/opening-bg/cyberpunk-street.png");
   timers = new float[6];
    iterators = new int[7];
}

void draw(){  
   rpg.execScene(1);
}

void keyPressed(){
  if(rpg.isRPGActive){
     if(key == ' '){
     rpg.showNextText = true;
     //Does a relatively good job, but may need time stops. 
   }
     if(keyCode == LEFT) keys[0] = true;
     if(keyCode == UP) keys[1] = true;
     if(keyCode == RIGHT) keys[2] = true;
     if(keyCode == DOWN) keys[3] = true;
     if(key == 'm') keys[4] = true;
  }
}

void keyReleased(){
  if(rpg.isRPGActive){
     if(keyCode == LEFT) keys[0] = false;
     if(keyCode == UP) keys[1] = false;
     if(keyCode == RIGHT) keys[2] = false;
     if(keyCode == DOWN) keys[3] = false;
     if(key == 'm') keys[4] = false;

  }
}
