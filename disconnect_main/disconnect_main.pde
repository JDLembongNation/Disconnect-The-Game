PFont font; //<>//
RPG rpg;
int scene;
PImage openingBG;
PImage titleScreenBackground[];
PImage forestBackground[];
PImage treesBackground[];
PImage transitionBackground[];
PImage mainCharacter[];
PImage battleImages[];
PImage startButton;
PImage controlButton;
PImage returnButton;
PImage quitButton;
float timers[];
int iterators[];
boolean keys[];
boolean titleScreenActive;
boolean controlScreenActive;
boolean gamePaused;
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
  mainCharacter = new PImage[10];
  treesBackground= new PImage[4];
  for (int i = 0; i < 30; i++) {
    titleScreenBackground[i] = loadImage("./data/opening-bg/main-menu/"+i+".png");
  }
  for (int i = 0; i < 5; i++) {
    forestBackground[i] = loadImage("./data/opening-bg/"+i+".png");
  }
  for (int i = 0; i < 10; i++) {
    mainCharacter[i] = loadImage("./data/characters/main-character/"+i+".png");
  }
  for (int i = 0; i < 4; i++) {
    treesBackground[i] = loadImage("./data/opening-bg/trees/"+i+".png");
  }
  openingBG = loadImage("./data/opening-bg/cyberpunk-street.png");
  battleImages = new PImage[1];
  battleImages[0] = loadImage("./data/battle/bg-1.png");
  startButton = loadImage("./data/opening-bg/main-menu/start.png");
  controlButton = loadImage("./data/opening-bg/main-menu/controls.png");
  returnButton = loadImage("./data/opening-bg/main-menu/return.png");
  quitButton = loadImage("./data/opening-bg/main-menu/quit.png");
  timers = new float[24];
  iterators = new int[16];
  scene = 0;
  battle = new Battle();
  battle.initialize(new Player(3), new Boss_Chapter_1(null, new PVector(300, 200), 2, 100));
}

void draw() {  
  background(0);

  if (!titleScreenActive) {
    if (!rpg.isSceneFinished) {
      rpg.execScene(scene); //scene
      if (gamePaused) showPausedMenu();
    } else {
      scene++;
      rpg.isSceneFinished=false;
    }
  } else {
    titleScreen();
  }
}

private void showPausedMenu() {
  fill(0, 150);
  rect(0, 0, 600, 600);
  fill(255);
  textFont(font);
    textSize(130);
  text("Paused", 150, 100);
  image(returnButton, 200, 200);
  image(quitButton, 200, 300);
}

void keyPressed() {
  if (key=='p' && timers[22] < millis()) {
    gamePaused=!gamePaused;
    timers[22] =millis()+100;
  }
  if (!gamePaused) {
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
}

void keyReleased() {
  if (!gamePaused) {
    if (rpg.isRPGActive) {
      if (key == 'm') keys[4] = false;
    }
    if (keyCode == LEFT) keys[0] = false;
    if (keyCode == UP) keys[1] = false;
    if (keyCode == RIGHT) keys[2] = false;
    if (keyCode == DOWN) keys[3] = false;
    if (battle.isBattleActive) if (key == ' ') keys[5] = false;
  }
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
    textSize(40);
    textAlign(CENTER);
    text("RPG", 300, 100);
    textSize(20);
    text(generateRPGControls(), 300, 120);
    textSize(40);
    text("Battle", 300, 250, 300);
    textSize(20);
    text(generateBattleControls(), 310, 320);
    textAlign(LEFT);
    rect(220, 450, 170, 60); //replace with image.
  }
}
void mousePressed() {
  if (gamePaused) {
    if (mouseInRegion(200, 200, 170, 60)) {
      gamePaused = false;
    }
    if (mouseInRegion(200, 300, 170, 60)) {
      exit();
    }
  } else {
    if (titleScreenActive) {
      if (controlScreenActive) {
        if (mouseInRegion(220, 450, 170, 60)) controlScreenActive=false;
      } else {
        if (mouseInRegion(100, 400, 170, 60)) {
          titleScreenActive = false;
        }
        if (mouseInRegion(350, 400, 170, 60)) {
          controlScreenActive=true;
        }
      }
    }
  }
}

boolean mouseInRegion(int x, int y, int regionWidth, int regionHeight) {
  return mouseX > x && mouseX < (x+regionWidth) && mouseY > y && mouseY < (y+regionHeight);
}

String generateRPGControls() {
  StringBuilder sb = new StringBuilder();
  sb.append("Control your character with the arrow keys.\n");
  sb.append("To interact with an item or character, press m. \n");
  sb.append("To view next text, press the space bar.");
  return sb.toString();
}

String generateBattleControls() {
  StringBuilder sb = new StringBuilder();
  sb.append("To shoot at enemy, hold SPACE. \n");
  sb.append("You have unlimited bullets. Use them. \n");
  sb.append("Dodge Incoming Bullets from the enemy and fire as many as you can. \n");
  sb.append("Your lives are indicated at the bottom left of the screen. \n");
  sb.append("Don't die!");
  return sb.toString();
}
