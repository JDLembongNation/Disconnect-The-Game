PFont font;
RPG rpg;
void setup() {
  size(600,600);
  font = createFont("monogram.ttf", 30);
  rpg = new RPG(loadJSONObject("./data/resource.json"));
}

void draw(){  
   rpg.execScene(0);
}

void keyPressed(){
  if(!rpg.isEventFinished){
     if(key == ' '){
     rpg.showNextText = true;
     //Does a relatively good job, but may need time stops. 
   }

     
  }
}
