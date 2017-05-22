  ArrayList<Player> players = new ArrayList();
  ArrayList<Location> grid = new ArrayList();
  int w = 0;
  int h = 0;
  final int topHeight = 50;
  final int pixelSize = 5;
  Tron game;
  TopBar bar = null;
  //Screen screen; // Start, Pick Color, game screen
 
 // Grid dimensions NOT dimensions of entire screen 
  int getWidth() { return w; }
  int getHeight() { return h-topHeight; }
  int getPixelSize() { return pixelSize; }
  
  
  void setup() {
    //println(join(PFont.list(), "\n"));
    size(600,600);
    w = width;
    h = height;
    if (width % pixelSize != 0 || height % pixelSize != 0) {
      throw new IllegalArgumentException();
    }
    //boolean row = true;
    //boolean black = true;
    for (int r=topHeight; r<h; r+=pixelSize) {
      for (int c=0; c<w; c+=pixelSize) {  
        //if (black) {
        //    black = false;
           grid.add(new Location(c, r, color(0), LocationType.AIR));
        //} 
        //else {
          //grid.add(new Location(c, r, color(0,0,0), LocationType.AIR)); 
          //black = true;
        //}
      }
      //black ^= true;
    }
    
    game = this;
    
    players.add(new Player("Player 1", color(255,50,50), 'w', 'a', 's', 'd', this.game));
    players.add(new Player("Player 2", color(174, 237, 40), 'i', 'j', 'k', 'l', this.game));
    players.add(new Player("Player 3", color(10, 120, 70), 'g', 'v', 'b', 'n', this.game));
    
    PowerUp p = new PowerUp();
    p.populate();
    
    bar = new TopBar(players, 0, topHeight/2 + topHeight/4);
  }
  
  ArrayList<Location> getGrid() {
    return this.grid; 
  }
  
  Location getLocation(Location loc) {
    return getLocation(loc.getX(), loc.getY()); 
  }
  
  Location getLocation(int x, int y) {
   /* try {
      if (x % pixelSize != 0) { return null; }
      //println("getting: "+x+" : "+y);
      int index = (y / pixelSize); // A faster way to get the index of a location
      
      for (int i=index; i<grid.size(); i++) {
        Location loc = grid.get(i);
        if (loc.getX() == x) {
          println(loc.getY()+" y="+y+" : "+loc.getX()+" x="+x);
          return loc;
        }
      }
      //println("index: "+index);
      //return grid.get(index);
    } catch (IndexOutOfBoundsException e) {
      e.printStackTrace(); // An exception should be thrown for debugging purposes 
    }
    return null;*/
    // get (y-1) * getHeight() + x % pixelSize
    for (Location loc : grid) {
      if (loc.equals(new Location(x, y))) {
        return loc; 
      }
    }
    return null;
  }
  
  void play() {
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
      //System.out.println("iterating players...");
      if (player.getKeys().contains(key)) {
     
        //System.out.println("key pressed...");
        player.changeDirection(key);
      }
    }
  }
  
  void draw() {
    background(187,187,187);
    // Draw the current screen
    for (Player player : players) {
       player.move(); // This will end up with a problem where if two players run into 
                      // eachother at same time, the player at index 0 with die first. 
    }
    render();
    bar.render();
    //fill(color(50,50,50));
    //rect(300,200,2,2);
    
    //grid.draw();
}