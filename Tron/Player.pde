import java.awt.*;
import java.util.ArrayList;

class Player
{
  private final char UP, DOWN, LEFT, RIGHT;
  private final int upKey, downKey, leftKey, rightKey;
  private color col;
  private String name;
  private ArrayList<Location> playerLocations;
  private ArrayList<Character> keyList;
  private char direction;
  private int change;
  private Tron game;

  public Player (String n, color c, char u, char l, char d, char r, Tron g)
  {
    name = n;
    col = c;
    upKey = u;
    downKey = d;
    leftKey = l;
    rightKey = r;
    UP = u;
    DOWN = d;
    LEFT = l;
    RIGHT = r;
    direction = UP;
    change = 1;
    game = g;
    
    keyList = new ArrayList();
    
    keyList.add(UP);
    keyList.add(DOWN);
    keyList.add(LEFT);
    keyList.add(RIGHT);
    
    playerLocations = new ArrayList<Location>();
    
    int w = g.getWidth();
    int h = g.getHeight();
    
    int x = (int) random(w);
    int y = (int) random (h);
    
    playerLocations.add(new Location(x,y, c, LocationType.PLAYER));
  }

  public ArrayList<Character> getKeys() {
    return keyList;
  }

  public void move ()
  {
    
    Location last = playerLocations.get(playerLocations.size()-1);
    Location next = null;

    if (direction == UP)
    {
      next = game.getLocation(last.getX(), last.getY() - change);
    }

    else if (direction == DOWN)
    {
      next = game.getLocation(last.getX(), last.getY() + change);
    }

    else if (direction == LEFT)
    {
      next = game.getLocation(last.getX() - change, last.getY());
    }

    else if (direction == RIGHT)
    {
      next = game.getLocation(last.getX() + change, last.getY());
    }

    if (checkCrash (next))
    {
      // Game over
      System.out.println("GAME OVER!");
    
      playerLocations.add (next);
    } else {
      //fill(this.col);
      //rect(300,300,1,1);
      next.setColor(this.col);  //<>//
    }
  }

  // Changed int direction to char direction
  public void changeDirection (char dir)
  {
    System.out.println("Direction changed!");
    if (dir == UP || dir == DOWN || dir == RIGHT || dir == LEFT)
    {
      direction = dir;
    }
  }

  String name() {
    return this.name;
  }

  private boolean checkCrash (Location next)
  {
    if (next == null) {
      return true;
    }
    LocationType type = next.getType(); //<>//
    if (type == null || type == LocationType.PLAYER || type == LocationType.WALL) //.equals()?
    {
      return true;
    }
    return false;
  }
}