class Tron {
  ArrayList<Player> players = new ArrayList();
  ArrayList<Location> grid;
  Screen screen; // Start, Pick Color, game screen
  
  ArrayList<Location> getGrid() {
    return this.grid; 
  }
  
  void play() {
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        grid.add(new Location(x, y));
      }
    } 
  }
  
  void draw() {
    // Draw the current screen
    for (Player player : players) {
       player.move(); // This will end up with a problem where if two players run into 
                      // eachother at same time, the player at index 0 with die first. 
    }
    
    grid.draw();
  }
  
  
  
  
  
  
  
}