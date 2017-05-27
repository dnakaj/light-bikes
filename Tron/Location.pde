class Location {
  
  int x;
  int y;
  color c;
  boolean isImage = false;
  LocationType type;
  
  Location(int x, int y, color c, LocationType type) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.type = type;
  }
  
  Location (int x, int y, LocationType type, boolean b) {
    this.x = x;
    this.y = y;
    this.isImage = b;
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
  
  void setImage(boolean b) {
    this.isImage = b;
  }
  
  boolean isImage() {
    return this.isImage; 
  }
  
  void setColor(color c) {
    this.c = c; 
  }
  
  color getColor() {
    return this.c;
  }
  
  void setType(LocationType type) {
    this.type = type; 
  }
  
  LocationType getType() {
    return this.type;
  }
  
  boolean equals(Location other) {
    return this.getX() == other.getX() && this.getY() == other.getY();
  }
  
  String toString() {
    return "x="+x+",y="+y; 
  }
}