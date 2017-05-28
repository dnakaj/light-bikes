class Wall {
  int x;
  int y;
  int h;
  int w;
  
  Wall(int x, int y, int h, int w) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }
  
  // Draws the wall on the game screen (at x,y with width w and height h)
  void render() {
    int pixel = getPixelSize();
    for (int xx = x; xx<x+w; xx += pixel) {
      for (int yy = y; yy<y+h; yy += pixel) {
        Location next = getLocation(xx, yy);
        if (next != null) { // This way if a wall is spawned at the edge it's ok
          next.setColor(color(255,255,255));
          next.setType(LocationType.WALL);
          getGridCache().add(next);
        }
      }
    }
  }
}