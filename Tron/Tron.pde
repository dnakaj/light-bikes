  import java.text.DecimalFormat;
  
  ArrayList<Player> players = new ArrayList();
  ArrayList<Location> grid = new ArrayList();
  int w = 0;
  int h = 0;
  final int topHeight = 50;
  final int pixelSize = 10;
  TopBar bar = null;
  boolean doRespawn = false;
  float framerate = 60;
  double respawnTimer = 5.0;
  double respawnTimerBackup = respawnTimer; // Need a better way to save this variable
  //Screen screen; // Start, Pick Color, game screen
 
 // Return dimensions of screen 
  int getWidth() { return w; }
  int getHeight() { return h; }
  int getTopHeight() { return topHeight; }
  int getPixelSize() { return pixelSize; }
  
  ArrayList<Player> getPlayers() { // Yes we don't actually need this getter, but it's good practice
    return players; 
  }
  
  void setup() {
   // println(join(PFont.list(), "\n"));
    size(600,600);
    resetGame();
  }
  
  void resetGame() {
    frameRate(framerate);
    this.doRespawn = false;
    w = width;
    h = height;
    if (width % pixelSize != 0 || height % pixelSize != 0) {
      throw new IllegalArgumentException();
    }
    
    this.resetGrid();
    
    // Later on player 1 and player 2 will be taken from text box input (same for color)
    players = new ArrayList();
    players.add(new Player("Player 1", color(255,50,50), 'w', 'a', 's', 'd')); // One player mode breaks game
    players.add(new Player("Player 2", color(174, 237, 40), 'i', 'j', 'k', 'l'));
    //players.add(new Player("Player 3", color(10, 120, 70), 'g', 'v', 'b', 'n'));
    
    bar = new TopBar(players, 0, topHeight/2 + topHeight/4);
  }
  
  void resetGrid() {
    this.grid = new ArrayList();
    for (int y=topHeight; y<h; y+=pixelSize) {
      for (int x=0; x<w; x+=pixelSize) {  
        grid.add(new Location(x, y));
      }
    } 
  }
  
  ArrayList<Location> getGrid() {
    return this.grid; 
  }
  
  Location getLocation(Location loc) {
    return getLocation(loc.getX(), loc.getY()); 
  }
  
  Location getLocation(int x, int y) {
    /* The initial, much slower way of fetching a location from the grid
    println();
    int c = 0;
    for (Location loc : grid) {
      if (loc.equals(new Location(x, y))) {
        println("C="+c);
        break;
      }
      c++;
    }*/
    
    
   try {
      if (x % pixelSize != 0) { return null; }
      
      // Jump directly to index of location
      
      /* PLAN:
      
        Original plan was to do: get (y-1) * getHeight() + x % pixelSize , but this returned numbers that were far too high (and threw index out of bounds exceptions). Thus, I returned to the planning
        phase, this time using a set of test coordinates: 
      
        [example coords]
      
        x = 15
        y = 55
        
        c=123 [the actual index as done the slow way]
        
        55 - 50 = 5 [mistake was that I forgot to divide y - top by 5, and thus I was getting absurdly high values for my calculated "y" in grid
        
        (width / 5) * ((y - top) / 5) + x / 5
        
        New problem: Bike wraps around the edge when it collides [still ends the player's game, but this needs fixing]
        Solution: Just add an if statement checking if the Y changed without the player going up/down (see Player.pde -> checkCrash())

      */
      
      int index = (width / pixelSize) * ((y - topHeight) / pixelSize) + x / pixelSize; // A faster way to get the index of a location
      //println("D="+index);
      return grid.get(index);
    } catch (IndexOutOfBoundsException e) {
      //e.printStackTrace(); // An exception should be thrown for debugging purposes 
    }
    
    return null;
  }
  
  void render() {
    for (Location loc : grid) {
      color c = loc.getColor();
      stroke(c);
      fill(c);
      
      rect(loc.getX(), loc.getY(), pixelSize, pixelSize);
    }
  }
  
  // Error: why doesnt it always log my key press?
  void keyPressed() {
    for (Player player : players) {
      if (player.isKey(key)) {
        player.changeDirection(key);
      }
    }
  }
  
  void draw() {
    background(187,187,187);
    
    if (doRespawn) {
      if (respawnTimer > 0) {
        background(0,0,0);
        PFont f;
        f = createFont("Verdana", 150, true);
        textFont(f, 40);
        fill(color(134, 244, 250));
        DecimalFormat df = new DecimalFormat("0.0");
        textAlign(CENTER);
        text("Restarting in\n "+df.format(respawnTimer), width/2, height/2);
        textAlign(BASELINE);
        respawnTimer -= 0.1;
      } else {
        respawnTimer = respawnTimerBackup;
        this.resetGrid();
        int count = 0;
        for (Player player : players) {
          if (player.lives() > 0) {
            player.respawn();
            count++;
          }
        }
        
        if (count <= 1) {
          println("Game over (restart now)"); 
          setup();
          return;
        }
        
        doRespawn = false;
        frameRate(framerate);
        return;
      }
      
    } else {
      int dead = 0;
      int eliminated = 0;
    
      // Draw the current screen
      for (Player player : players) {
        if (player.isAlive()) {
         player.move(); // This will end up with a problem where if two players run into 
                        // eachother at same time, the player at index 0 with die first. 
        } else {
          dead++;
          // NEED SOME SORT OF "FREEZE FRAME" when everyone dies before switching to timer.
          if (player.lives() == 0) { eliminated++; println(player.lives()); }
        }
      }
      
      if (players.size() - dead <= 1) {
        if (eliminated >= players.size() - 1) {
          // RETURN TO MENU / PLAY AGAIN SCREEN
          setup(); 
          return;
        }
        frameRate(10);
        doRespawn = true;
      } else {
        render();
      }
      
    }
    
    bar.render();
}