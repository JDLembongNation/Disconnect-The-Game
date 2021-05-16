PFont font;
RPG rpg;
int scene;
PImage openingBG;
PImage forestBackground[];
PImage rpgBackground[];
PImage mainCharacter[];
PImage battleImages[];
float timers[];
int iterators[];
boolean keys[];
Battle battle;
void setup() {
  size(600, 600);
  keys = new boolean[6];
  font = createFont("monogram.ttf", 30);
  rpg = new RPG(loadJSONObject("./data/resource.json"));
  forestBackground = new PImage[5];
  rpgBackground = new PImage[7];
  mainCharacter = new PImage[4];
  for (int i = 0; i < 5; i++) {
    forestBackground[i] = loadImage("./data/opening-bg/"+i+".png");
  }
  for (int i = 0; i < 7; i++) {
    rpgBackground[i] = loadImage("./data/background/"+i+".png");
  }
  for (int i = 0; i < 4; i++) {
    mainCharacter[i] = loadImage("./data/characters/"+i+".png");
  }
  openingBG = loadImage("./data/opening-bg/cyberpunk-street.png");
  battleImages = new PImage[1];
  battleImages[0] = loadImage("./data/battle/bg-1.png");
  timers = new float[15];
  iterators = new int[8];
  scene = 0;
  battle = new Battle();
  battle.initialize(new Player(3), new Boss_Chapter_1(null, new PVector(300, 200), 2, 100));
}

void draw() {  
  background(0);
  
   if(!rpg.isSceneFinished){
   rpg.execScene(1); //scene
   
   }else{
   scene++;
   rpg.isSceneFinished=false;
   }
   
  //b.run();
}

void keyPressed() {
  if (rpg.isRPGActive) {
    if (key == ' ') {
      rpg.showNextText = true;
      //Does a relatively good job, but may need time stops.
    }
    if (key == 'm') keys[4] = true;
  }
  if (battle.isBattleActive) if (key == ' ') keys[5] = true;
  if (keyCode == LEFT) keys[0] = true;
  if (keyCode == UP) keys[1] = true;
  if (keyCode == RIGHT) keys[2] = true;
  if (keyCode == DOWN) keys[3] = true;
}

void keyReleased() {
  if (rpg.isRPGActive) {
    if (key == 'm') keys[4] = false;
  }
  if (keyCode == LEFT) keys[0] = false;
  if (keyCode == UP) keys[1] = false;
  if (keyCode == RIGHT) keys[2] = false;
  if (keyCode == DOWN) keys[3] = false;
  if (battle.isBattleActive) if (key == ' ') keys[5] = false;
}
