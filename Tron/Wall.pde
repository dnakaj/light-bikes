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
  
  void render() {
    int pixel = getPixelSize();
    for (int xx = x; xx<x+w; xx += pixel) {
      for (int yy = y; yy<y+h; yy += pixel) {
        Location next = getLocation(xx, yy);
        next.setColor(color(255,255,255));
        next.setType(LocationType.WALL);
         
        getGridCache().add(next);
      }
    }
  }
}