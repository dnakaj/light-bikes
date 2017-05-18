  ArrayList<Player> players = new ArrayList();
  ArrayList<Location> grid = new ArrayList();
  final int w = 500;
  final int h = 500;
  final int topHeight = 100;
  Tron game;
  //Screen screen; // Start, Pick Color, game screen
 
 // Grid dimensions NOT dimensions of entire screen 
  int getWidth() { return w; }
  int getHeight() { return h-topHeight; }
  
  void setup() {
    size(500,500);
    for (int r=topHeight; r<h; r++) {
      for (int c=0; c<w; c++) {
        grid.add(new Location(c, r));
      }
    }
    
    game = this;
    
    players.add(new Player("Player 1", color(255,50,50), 'w', 'a', 's', 'd', this.game));
    //players.add(new Player("Player 2", color(200,200,200), 'i', 'j', 'k', 'l', this.game));
  }
  
  ArrayList<Location> getGrid() {
    return this.grid; 
  }
  
  Location getLocation(Location loc) {
    return getLocation(loc.getX(), loc.getY()); 
  }
  
  Location getLocation(int x, int y) {
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
      
      rect(loc.getX(), loc.getY(), 1, 1);
    }
  }
  
  void keyPressed() {
    for (Player player : players) {
      if (player.getKeys().contains(key)) {
        player.changeDirection(key);
      }
    }
  }
  
  void draw() {
    background(20,20,200);
    // Draw the current screen
    for (Player player : players) {
       player.move(); // This will end up with a problem where if two players run into 
                      // eachother at same time, the player at index 0 with die first. 
    }
    render();
    //fill(color(50,50,50));
    //rect(300,200,2,2);
    
    //grid.draw();
  }