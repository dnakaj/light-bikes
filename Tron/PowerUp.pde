import java.util.*;

class PowerUp
{
  Random generator = new Random ();
  ArrayList <Location> imageLocs;
  PImage img;
  int xC;
  int yC;
  int xLength;
  int yLength;

  PowerUp(int a, int b, int c, int d) {
    img = loadImage ("PowerUp.png");
    xC = a;
    yC = b;
    xLength = c;
    yLength = d;
    createList();
  }
  
  //returns the list to locations of the power up image
  ArrayList<Location> getLocations() {
    return this.imageLocs; 
  }
  
  //draws or renders the powerup on the grid
  void render () {
    image (img, xC, yC, xLength * getPixelSize(), yLength * getPixelSize());
  }
  
  //adds each location in imageLocs to the gridCache
  void addToCache () {
    ArrayList <Location> gridCache = getGridCache();
    for (Location l : imageLocs) {
      gridCache.add (l);
    }
  }
  
  //creates and returns a list of PowerUps
  ArrayList <PowerUp> getPowerUps (int low, int high, int h, int w) {
    createPowerUps (low, high, h , w);
    return powerUps;
  }

  //creates a list of PowerUps
  void createList () {
    imageLocs = new ArrayList <Location> ();
    for (int i = xC; i < xLength * getPixelSize() + xC; i+=getPixelSize()) {
      for (int j = yC; j < yLength * getPixelSize() + yC; j+=getPixelSize()) {
        Location loc = new Location (i, j, LocationType.POWERUP, true);

        imageLocs.add (loc);
        getGridCache().add(loc);
      
      }
    }
    
    for (Location l : getGridCache()) {
      if (l.getType() == LocationType.POWERUP) {
        //println("Powerup found!"); 
      }
    }
  }
}