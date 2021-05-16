import java.util.*; //<>// //<>//
public class Map {
  int globalEventID;
  Scene scene;
  final int unitLength = 30;
  PVector playerPosition;
  boolean isCompleted;
  MapNode[][] nodeMap;
  int currentPosition = 0;
  int mapPosX;
  int mapPosY;
  MapNode endNode;
  public Map(Scene scene) {
    this.endNode = null;
    this.scene = scene;
    globalEventID = 0;
    mapPosX = 0;
    mapPosY = 0;
    isCompleted=false;
    playerPosition = new PVector(90, 90);
    nodeMap = new MapNode[5][5]; //Can make dynamic?
    nodeMap[0][0] = generateNodes(new MapNode(), 0, 1, 0, 0);
    displayMapNodes();
    connectNodes();
    addMainCharacters();
  }
  //List of items available.
  //Events and interactions. 
  //Mappings of images and icons

  //Want a function to return a map, an image of a map and interactions in the map. 
  //Function here that deals with player movement in the map. 
  //Ie. void playermove(direction); TriggerEvent playerinteract(), if theres something return something. 
  void playerMovement(int direction) {
    if (timers[5] < millis()) {
      switch(direction) {
      case 0: 
        {
          if (playerPosition.x >0 && nodeMap[mapPosY][mapPosX].isWalkable[(int)playerPosition.y/30][((int)playerPosition.x/30)-1])playerPosition.x -= unitLength;
          if (playerPosition.x == 0) {
            playerPosition.x = width-unitLength*2;
            mapPosX--;
          }
          currentPosition = 0;
          break;
        }
      case 1: 
        {
          if (playerPosition.y > 0  && nodeMap[mapPosY][mapPosX].isWalkable[((int)playerPosition.y/30)-1][((int)playerPosition.x/30)]) playerPosition.y -=unitLength;
          if (playerPosition.y == 0) {
            playerPosition.y = height-unitLength*2;
            mapPosY--;
          }
          currentPosition=1;
          break;
        }
      case 2: 
        {
          if (playerPosition.x <width-unitLength  && nodeMap[mapPosY][mapPosX].isWalkable[(int)playerPosition.y/30][((int)playerPosition.x/30)+1])playerPosition.x += unitLength;
          if (playerPosition.x == width-unitLength) {
            playerPosition.x = unitLength*2;
            mapPosX++;
          }
          currentPosition=2;
          break;
        }
      case 3: 
        {
          if (playerPosition.y < height-unitLength*2 && nodeMap[mapPosY][mapPosX].isWalkable[((int)playerPosition.y/30)+1][((int)playerPosition.x/30)])playerPosition.y +=unitLength;
          if (playerPosition.y == height-unitLength*2) {
            playerPosition.y = unitLength*2;
            mapPosY++;
          }
          currentPosition=3;
          break;
        }
      }
      timers[5] = millis()+150;
    }
  }

  void render() {
    //Display all the assets etc. 
    //hard code for now. 
    spawnFloor(0);
    spawnLines();

    spawnTrees();
    renderCharacter();
    spawnNPC();
  }

  TriggerEvent playerInteract() {
    int relY = (int)playerPosition.y/30;
    int relX = (int) playerPosition.x/30;
    switch(currentPosition) {
    case 0:
      {
        if (nodeMap[mapPosY][mapPosX].isInteractable[relY][relX-1]) {
          for (int i = 0; i < (nodeMap[mapPosY][mapPosX].npcs.size()); i++) {
            NPC n = nodeMap[mapPosY][mapPosX].npcs.get(i);
            if (n.position.x == ((relX-1)*unitLength) && n.position.y == (relY*unitLength)) {
              if (n.eventTicker < globalEventID) {
                n.eventTicker = globalEventID;
                n.triggerTicker = 0;
              }
              if (n.eventTicker>globalEventID) {
                globalEventID = n.eventTicker;
                n.triggerTicker=0;
              }
              String[] speech = n.getSpeech();
              if (speech == null) return null;
              System.out.println(globalEventID + " THE GLOBAL EVENT ID");
              TriggerEvent te = new TriggerEvent(speech);
              if (n.canBattle && n.battleEventID == n.eventTicker) {
                System.out.println("Transition was altered");
                te.isTransition = true;
              }
              System.out.println(n.eventTicker + " yes " + globalEventID);
              return te;
            }
          }
        }
      }
      break;
    case 1:
      {
      }
      break;
    case 2:
      {
      }
      break;
    case 3:
      {
      }
      break;
    }
    return null;
  }

  public class MapNode {
    //Each map node will have a fixed size of 600x600. 
    boolean isWalkable[][] = new boolean[height/unitLength][width/unitLength];
    boolean isInteractable[][] = new boolean[height/unitLength][width/unitLength];
    ArrayList<NPC> npcs = new ArrayList<NPC>();
    MapNode top;
    MapNode left;
    MapNode right;
    MapNode bottom;
    MapNode nodes[] = new MapNode[4];
    boolean hasEntryPoint[] = new boolean[4];
    int entryPoints[] = new int[8]; //LEFT UP RIGHT DOWN
    public MapNode() {
      //Generate Borders
      for (boolean[] row : isWalkable) Arrays.fill(row, true);
      for (int i =0; i < width/unitLength; i++) {
        isWalkable[1][i] = false;
        isWalkable[18][i] = false;
        isWalkable[0][i] = false;
        isWalkable[19][i] = false;
      }
      for (int i =0; i < height/unitLength; i++) {
        isWalkable[i][1] = false;
        isWalkable[i][18] = false;
        isWalkable[i][0] = false;
        isWalkable[i][19] = false;
      }
      //Generate NPC Location
      int npcNumber = (int) random(5);
      for (int i = 0; i < npcNumber; i++) {
        int placement = (int) random(scene.npcList.size()); //can change to pseudorandom
        NPC npc = scene.npcList.get(placement);
        if (!npc.isInStory) {
          //generate random position within block
          npc.position = findNewPosition(1, 2);
          npcs.add(npc);
        }
      }
    }
    PVector findNewPosition(int x, int y) {
      boolean found = false;
      int placeX = 0;
      int placeY = 0;
      while (!found) {
        boolean intercept = false;
        placeX = ((int) random(15))+2;
        placeY = ((int) random(15))+2;
        for (int i = 0; i < y; i++) {
          for (int j = 0; j < x; j++) {
            if (!isWalkable[placeY+i][placeX+j]) intercept =true;
          }
        }
        if (!intercept) found =true;
      }
      for (int i = 0; i < y; i++) {
        for (int j = 0; j < x; j++) {
          isWalkable[placeY+i][placeX+j] = false;
          isInteractable[placeY+i][placeX+j] = true;
        }
      }
      return new PVector(placeX*unitLength, placeY*unitLength);
    }
    void addNorthEntryPoint(int start, int finish) {
      entryPoints[2] =  start;
      entryPoints[3] =  finish;
      hasEntryPoint[1] = true;
      for (int i = start; i <=finish; i+=unitLength) {
        isWalkable[0][i/30] = true;
        isWalkable[1][i/30] = true;
      }
    }

    void addWestEntryPoint(int start, int finish) {
      entryPoints[0] =  start;
      entryPoints[1] =  finish;
      hasEntryPoint[0] = true;
      for (int i = start; i <=finish; i+=unitLength) {
        isWalkable[i/30][0] = true;
        isWalkable[i/30][1] = true;
      }
    }
    void addEastEntryPoint(int start, int finish) {
      entryPoints[4] =  start;
      entryPoints[5] =  finish;
      hasEntryPoint[2] = true;
      for (int i = start; i <=finish; i+=unitLength) {
        isWalkable[i/30][18] = true;
        isWalkable[i/30][19] = true;
      }
    }

    void addSouthEntryPoint(int start, int finish) {
      System.out.println("South Connector Established");
      entryPoints[6] =  start;
      entryPoints[7] =  finish;
      hasEntryPoint[3] = true;
      for (int i = start; i <=finish; i+=unitLength) {
        isWalkable[18][i/30] = true;
        isWalkable[19][i/30] = true;
      }
    }
  }

  public void addMainCharacters() {
    for (int i = 0; i < scene.npcList.size(); i++) {
      if (scene.npcList.get(i).isInStory) {
        switch(scene.npcList.get(i).initialPosition) {
        case "start": 
          {
            NPC character = scene.npcList.get(i);
            character.position = nodeMap[0][0].findNewPosition(1, 2);
            nodeMap[0][0].npcs.add(character);
            break;
          }
        case "random":
          {
            break;
          }
        case "end":
          {
            NPC character = scene.npcList.get(i);
            character.position = endNode.findNewPosition(1, 2);
            endNode.npcs.add(character);
            break;
          }
        default: 
          System.err.println("JSON Parser incorrectly formed attribute.");
          break;
        }
      }
    }
  }

  //Use this to generate Map.
  public void displayMapNodes() {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        String t = "x";
        if (nodeMap[i][j]!=null) t = "o";
        System.out.print(t);
      }
      System.out.print("\n");
    }
  }

  void connectNodes() {
    for (int y = 0; y < 5; y++) {
      for (int x = 0; x < 5; x++) {
        if (y > 0) {
          if (nodeMap[y-1][x] !=null && nodeMap[y][x]!=null) {
            int positionSplit = (int) random(7);
            nodeMap[y-1][x].addSouthEntryPoint(positionSplit*60, (positionSplit+2)*60);
            nodeMap[y][x].addNorthEntryPoint(positionSplit*60, (positionSplit+2)*60);
          }
        }
        if (x > 0) {
          if (nodeMap[y][x-1] != null && nodeMap[y][x]!=null) {
            int positionSplit = (int) random(7);
            nodeMap[y][x-1].addEastEntryPoint(positionSplit*60, (positionSplit+2)*60);
            nodeMap[y][x].addWestEntryPoint(positionSplit*60, (positionSplit+2)*60);
          }
        }
      }
    }
  }

  MapNode generateNodes(MapNode node, int layer, int maxLayer, int posX, int posY) {
    if (layer == maxLayer) {
      if (endNode==null) endNode = node;
      return node;
    } else {
      int separator = (int) (random(10));
      if (separator%2 == 0) {
        if (nodeMap[posY+1][posX]==null) {
          System.out.println("Added South");
          MapNode newNode = new MapNode();
          newNode.top = node;
          nodeMap[posY+1][posX] = newNode;
          node.bottom = generateNodes(newNode, layer+1, maxLayer, posX, posY+1);
        } else {
          return nodeMap[posY+1][posX];
        }
      } else if (separator%2 == 1) {
        if (nodeMap[posY][posX+1]==null) {
          MapNode newNode = new MapNode();
          newNode.left = node;
          nodeMap[posY][posX+1] = newNode;
          node.right = generateNodes(newNode, layer+1, maxLayer, posX+1, posY);
        } else {
          return nodeMap[posY][posX+1];
        }
      } else {/*
        if (nodeMap[posY][posX+1] == null) {
       MapNode newNode = new MapNode();
       newNode.left = node;
       nodeMap[posY][posX+1] = newNode;
       node.right = generateNodes(newNode, layer+1, maxLayer, posX+1, posY);
       } else {
       return nodeMap[posY][posX+1];
       }
       if (nodeMap[posY+1][posX] == null) {
       System.out.println("Added South");
       MapNode newNode = new MapNode();
       nodeMap[posX][posY+1] = newNode;
       newNode.top = node;
       node.bottom = generateNodes(newNode, layer+1, maxLayer, posX, posY+1);
       } else {
       return nodeMap[posY+1][posX];
       } */
      }
    }
    return node;
  }

  void spawnFloor(int floorType) {
    for (int i = 0; i < width; i+=unitLength) {
      for (int j = 0; j < height; j+=unitLength) {
        image(rpgBackground[floorType], i, j);
      }
    }
  }
  void spawnLines() {
    for (int i = 0; i < width; i+=unitLength) {
      line(i, 0, i, 600);
    }
    for (int i = 0; i < height; i+=unitLength) {
      line(0, i, 600, i);
    }
    //debug. 
    boolean[][] walk = nodeMap[mapPosY][mapPosX].isWalkable;
    for (int i = 0; i < walk.length; i++) {
      for (int j = 0; j < walk[i].length; j++) {
        if (!walk[i][j]) {
          fill(140, 20, 15);
          rect(j*unitLength, i*unitLength, unitLength, unitLength);
        }
      }
    }
    fill(40, 60, 190);
    rect((playerPosition.x), (playerPosition.y), unitLength, unitLength);
  }
  void spawnNPC() {
    MapNode current = nodeMap[mapPosY][mapPosX];
    for (int i = 0; i < current.npcs.size(); i++) {
      image(mainCharacter[3], current.npcs.get(i).position.x, current.npcs.get(i).position.y);
    }
  }
  void renderCharacter() {
    image(mainCharacter[currentPosition], playerPosition.x, playerPosition.y);
  }
  //Take Current Node and separation.
  void spawnTrees() {
    MapNode current = nodeMap[mapPosY][mapPosX];

    for (int i = 0; i < height; i+=unitLength*2) {
      if (!(current.hasEntryPoint[0] && i >= current.entryPoints[0] && i <= current.entryPoints[1])) {
        image(rpgBackground[2], 0, i);
      }
    }
    for (int i = 0; i < width; i+=unitLength*2) {
      if (!(current.hasEntryPoint[1] && i >= current.entryPoints[2] && i <= current.entryPoints[3])) {
        image(rpgBackground[2], i, 0);
      }
    }
    for (int i = 0; i < height; i+=unitLength*2) {
      if (!(current.hasEntryPoint[2] && i >= current.entryPoints[4] && i <= current.entryPoints[5])) {
        image(rpgBackground[2], 540, i);
      }
    }
    for (int i = 0; i < width; i+=unitLength*2) {
      if (!(current.hasEntryPoint[3] && i >= current.entryPoints[6] && i <= current.entryPoints[7])) {
        image(rpgBackground[2], i, 540);
      }
    }
  }
}
