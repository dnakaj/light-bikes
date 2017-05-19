class Wall {
  int x;
  int y;
  int h;
  int w;
  ArrayList<Location> grid;
  
  Wall(int x, int y, int h, int w, ArrayList<Location> grid) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    this.grid = grid;
  }
  
  void render() {
     // We need a faster way to jump to a location
  }
  
  
}