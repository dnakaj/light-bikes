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
  private int speed;
  private Tron game;
  private boolean alive;
  int lives = 3;

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
    speed = 1;
    game = g;
    alive = true;
    
    keyList = new ArrayList();
    
    keyList.add(UP);
    keyList.add(DOWN);
    keyList.add(LEFT);
    keyList.add(RIGHT);
    
    direction = keyList.get((int) random(keyList.size()));
    
    playerLocations = new ArrayList<Location>();
    
    int w = g.getWidth();
    int h = g.getHeight();
    
    int x = ((int) random(w/5)) * 5;
    int y = ((int) random (h/5)) * 5;
    
    //System.out.println(x+" : "+y);
    
    playerLocations.add(new Location(x,y, c, LocationType.PLAYER));
  }

  public ArrayList<Character> getKeys() {
    return keyList;
  }

  // Moves the bike forward x amount
  public void move ()
  {
    if (!alive) { return; }
     //<>//
    Location last = playerLocations.get(playerLocations.size()-1); //<>//
    Location next = null;

    if (direction == UP)
    {
      next = game.getLocation(last.getX(), last.getY() - speed * game.getPixelSize());
    }

    else if (direction == DOWN)
    {
      next = game.getLocation(last.getX(), last.getY() + speed * game.getPixelSize());
    }

    else if (direction == LEFT)
    {
      next = game.getLocation(last.getX() - speed * game.getPixelSize(), last.getY());
    }

    else if (direction == RIGHT)
    {
      next = game.getLocation(last.getX() + speed * game.getPixelSize(), last.getY());
    }

    if (checkCrash (next))
    {
      // Game over
      System.out.println("GAME OVER!");
      this.lives --;
      this.alive = false;
    
    } else {
      next.setType(LocationType.PLAYER);
      playerLocations.add(next);
      next.setColor(this.col); 
    }
  }
  
  void addSpeed(int speed) {
    this.speed += speed; 
  }
  
  void setSpeed(int speed) {
    this.speed = speed; 
  }
  
  color getColor() {
    return this.col;
  }
  
  int lives() {
    return this.lives; 
  }
  
  void respawn() {
    this.alive = true; 
  }

  // Changed int direction to char direction
  public void changeDirection (char dir)
  {
    if ((dir == UP || dir == DOWN || dir == RIGHT || dir == LEFT) && validMove(dir))
    {
      direction = dir;
    }
  }

  private boolean validMove(char dir) {
    return !(dir == UP && direction == DOWN || dir == DOWN && direction == UP || dir == LEFT && direction == RIGHT || dir == RIGHT && direction == LEFT); 
  }

  String name() {
    return this.name;
  }

  ArrayList<Location> locations() {
    return this.playerLocations; 
  }

  private boolean checkCrash (Location next)
  {
    if (next == null) {
      System.out.println("Was null.");
      return true;
    }
    LocationType type = next.getType();
    if (type == null || type == LocationType.PLAYER || type == LocationType.WALL)
    {
      return true;
    }
    return false;
  }
}