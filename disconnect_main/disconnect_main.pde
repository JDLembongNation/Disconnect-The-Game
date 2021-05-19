PFont font;
RPG rpg;
int scene;
PImage openingBG;
PImage titleScreenBackground[];
PImage forestBackground[];
PImage transitionBackground[];
PImage rpgBackground[];
PImage mainCharacter[];
PImage battleImages[];
PImage startButton;
PImage controlButton;
float timers[];
int iterators[];
boolean keys[];
boolean titleScreenActive;
boolean controlScreenActive;
Battle battle;
String title;
String subtitle;
void setup() {
  size(600, 600);
  title="DISCONNECT";
  subtitle="The Game";
  controlScreenActive = false;
  titleScreenActive = false;
  keys = new boolean[6];
  font = createFont("monogram.ttf", 30);
  rpg = new RPG(loadJSONObject("./data/resource.json"));
  forestBackground = new PImage[5];
  transitionBackground = new PImage[1];
  transitionBackground[0] = loadImage("./data/transition/1.png");
  titleScreenBackground = new PImage[30];
  rpgBackground = new PImage[7];
  mainCharacter = new PImage[10];
  for (int i = 0; i < 30; i++) {
    titleScreenBackground[i] = loadImage("./data/opening-bg/main-menu/"+i+".png");
  }
  for (int i = 0; i < 5; i++) {
    forestBackground[i] = loadImage("./data/opening-bg/"+i+".png");
  }
  for (int i = 0; i < 7; i++) {
    rpgBackground[i] = loadImage("./data/background/1/"+i+".png");
  }
  for (int i = 0; i < 10; i++) {
    mainCharacter[i] = loadImage("./data/characters/main-character/"+i+".png");
  }
  openingBG = loadImage("./data/opening-bg/cyberpunk-street.png");
  battleImages = new PImage[1];
  battleImages[0] = loadImage("./data/battle/bg-1.png");
  startButton = loadImage("./data/opening-bg/main-menu/start.png");
  controlButton = loadImage("./data/opening-bg/main-menu/controls.png");
  timers = new float[19];
  iterators = new int[11];
  scene = 0;
  battle = new Battle();
  battle.initialize(new Player(3), new Boss_Chapter_1(null, new PVector(300, 200), 2, 100));
}

void draw() {  
  background(0);
  if (!titleScreenActive) {
    if (!rpg.isSceneFinished) {
      rpg.execScene(1); //scene
    } else {
      scene++;
      rpg.isSceneFinished=false;
    }
  } else {
    titleScreen();
  }
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

void titleScreen() {
  image(titleScreenBackground[iterators[8]], 0, 0);
  if (millis() > timers[17]) {
    iterators[8]++;
    if (iterators[8] > 29) iterators[8] = 0;
    timers[17] = millis()+50;
  }
  fill(0, 120);
  rect(0, 0, 600, 600);
  //words iterators 9 and 10
  String t = "";
  String st = "";
  if (millis() > timers[18]) {
    timers[18] = millis() +100;
    if (iterators[9] < title.length()) {
      iterators[9]++;
    }
    if (iterators[10] < subtitle.length()) {
      iterators[10]++;
    }
  }
  for (int i = 0; i< iterators[9]; i++) {
    t += title.toCharArray()[i];
  }
  for (int i = 0; i< iterators[10]; i++) {
    st += subtitle.toCharArray()[i];
  }
  if (!controlScreenActive) {
    fill(255);
    textFont(font);
    textSize(100);
    text(t, 110, 100);
    textSize(50);
    text(st, 225, 150);
    //buttons
    image(startButton, 100, 400);
    image(controlButton, 350, 400);
  } else {
    fill(255);
    textFont(font);
    text("You dont need instructions, Fuck you!",50,500);
  }
}
void mousePressed() {
  if (titleScreenActive) {
    if (mouseX > 100 && mouseX < 270 && mouseY > 400 && mouseY < 460) {
      titleScreenActive = false;
    }
    if (mouseX > 350 && mouseX < 520 && mouseY > 400 && mouseY < 460) {
      controlScreenActive=true;
    }
  }
}
