class Location {
  
  int x;
  int y;
  color c;
  LocationType type;
  
  Location(int x, int y, color c, LocationType type) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.type = type;
  }
  
  Location(int x, int y) {
    this(x, y, color(0,0,0), LocationType.AIR);
  }
  
  int getX() {
    return this.x; 
  }
  
  int getY() {
    return this.y; 
  }
  
  Location get() {
    return this; 
  }
  
  void setColor(color c) {
    this.c = c; 
  }
  
  void getColor() {
    return this.c;
  }
  
  LocationType getType() {
    return this.type;
  }
  
  boolean equals(Location other) {
    return this.getX() == other.getX() && this.getY() == other.getY();
  }
}