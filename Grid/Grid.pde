class Grid {
  
  ArrayList<Location> grid; 
  int w;
  int h;
  
  public Grid(int w, int h) {
    this.w = w;
    this.h = h;
    grid = new ArrayList();
    for (int x=0; x<w; x++) {
      for (int y=0; y<h; y++) {
        grid.add(new Location(x, y));
      }
    }
  }
  
  Location get(int x, int y) {
    for (Location loc : grid) {
      if (grid.getX() == x && grid.getY() == y) {
        return loc;
      }
    }
  }
  
  void set(Location loc) { // If it's out of bounds an error should get thrown
    for (int i=0; i<grid.size(); i++) {
      if (loc.equals(grid.get(i)) {
        grid.set(i, loc); 
      }
    }
  } 
}