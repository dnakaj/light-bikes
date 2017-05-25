import java.util.*;
class PowerUp
{
  Random generator = new Random ();
  ArrayList <Location> imageLocs;
  ArrayList <PowerUp> powerUps;
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
    addToCache();
  }
  
  void populate () {
    image (img, xC, yC, xLength, yLength);
  }
    
  void addToCache () {
    ArrayList <Location> gridCache = getGridCache();
    for (Location l : imageLocs) {
      gridCache.add (l);
    }
  }
  
  ArrayList <PowerUp> getPowerUps (int low, int high, int h, int w) {
    createPowerUps (low, high, h , w);
    return powerUps;
  }

  void createList () {
    imageLocs = new ArrayList <Location> ();
    for (int i = xC; i <= xLength + xC; i++) {
      for (int j = yC; j <= yLength + yC; j++) {
        Location l = new Location (i, j, LocationType.POWERUP, true);
        imageLocs.add (l);
      }
    }
  }
}