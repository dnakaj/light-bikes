import java.util.*;
class PowerUp
{
  Random generator = new Random ();
  ArrayList <Location> imageLocs;
  PImage image;
  int xC;
  int yC;
  int xLength;
  int yLength;
  
  PowerUp(int a, int b, int c, int d)
  {
    image = loadImage ("PowerUp.png");
    xC = a;
    yC = b;
    xLength = c;
    yLength = d;
    createList();
  }
  
  void populate ()
  {
    ArrayList <Location> gridCache = getGridCache();
    for (Location l : imageLocs)
    {
      gridCache.add (l);
    }
  }
  
  void createList ()
  {
    imageLocs = new ArrayList <Location> ();
    for (int i = xC; i <= xLength + xC; i++)
    {
      for (int j = yC; j <= yLength + yC; j++)
      {
        Location l = new Location (i, j, LocationType.POWERUP, true);
        imageLocs.add (l);
      }
    }
  }
}