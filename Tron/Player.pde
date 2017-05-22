import java.awt.*;
import java.util.ArrayList;

class Player implements Comparable
{
  private final char UP, DOWN, LEFT, RIGHT;
  private final int upKey, downKey, leftKey, rightKey;
  private color col;
  private String name;
  private ArrayList<Location> playerLocations;
  private char direction;
  private int speed;
  private boolean alive;
  int lives = 3;

  public Player (String n, color c, char u, char l, char d, char r)
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
    
    playerLocations = new ArrayList<Location>();
    
    this.respawn();
  }
  
  // Moves the bike forward x amount
  public void move ()
  {
    if (!alive) { return; }
     //<>// //<>// //<>// //<>//
    Location last = playerLocations.get(playerLocations.size()-1); //<>// //<>// //<>// //<>//
    Location next = null;

    if (direction == UP)
    {
      next = getLocation(last.getX(), last.getY() - speed * getPixelSize());
    }

    else if (direction == DOWN)
    {
      next = getLocation(last.getX(), last.getY() + speed * getPixelSize());
    } //<>// //<>//
 //<>// //<>//
    else if (direction == LEFT)
    {
      next = getLocation(last.getX() - speed * getPixelSize(), last.getY());
    }

    else if (direction == RIGHT)
    {
      next = getLocation(last.getX() + speed * getPixelSize(), last.getY());
    }

    if (checkCrash (next))
    {
      // Game over //<>// //<>//
      this.lives --;
      this.alive = false;
    
    } else {
      next.setType(LocationType.PLAYER);
      playerLocations.add(next);
      next.setColor(this.col); 
      getGridCache().add(next);
    }
  }
  
  // (Re)spawns ths player in the arena and resets the relevant variables. Note that there is a very small chance of two players spawning on one another -- find a workaround for this later.
  void respawn() {
    
    
    this.direction = RIGHT;
    this.alive = true; 
    this.speed = 1;
    this.playerLocations = new ArrayList();
    
    int w = getWidth();
    int h = getHeight();
    
    int x = ((int) random(w/getPixelSize())) * getPixelSize();
    if (x > w/2) { x = w/2; } // Ensures player starts on left side of screen
    
    int y = ((int) random(h/getPixelSize())) * getPixelSize();
    if (y < getTopHeight()) { y = topHeight + (int) random(h/5 - topHeight); }
    int count = 0; 
    for (Player player : players) {
      count += 5;
      if (player.name().equals(this.name) && player.getColor() == this.col) {
         y = getTopHeight() + count * 5;
      }
    }
    
    this.playerLocations.add(new Location(x, y, this.col, LocationType.PLAYER));
    
    //println(x+","+y);
  }

  // Checks if the input char is one of the player's direction keys
  boolean isKey(char dir) {
    return (dir == UP || dir == DOWN || dir == RIGHT || dir == LEFT);
  }

  // Switches the player's direction
  public void changeDirection (char dir)
  {
    if ((dir == UP || dir == DOWN || dir == RIGHT || dir == LEFT) && validMove(dir))
    {
      direction = dir;
    }
  }

  // Checks if player can move in that direction. Prevents player from moving in the direction opposite of their current direction
  private boolean validMove(char dir) {
    return !(dir == UP && direction == DOWN || dir == DOWN && direction == UP || dir == LEFT && direction == RIGHT || dir == RIGHT && direction == LEFT); 
  }
  
  
  // Checks if the player's next location will cause the player to crash [true if it will / false if it wont]
  private boolean checkCrash (Location next)
  {
    if (next == null) {
      return true;
    }
    
    Location last = playerLocations.get(playerLocations.size()-1);
    
    LocationType type = next.getType();
    
    if ((type == LocationType.PLAYER || type == LocationType.WALL) || 
        (next.getY() != last.getY() && (direction == LEFT || direction == RIGHT)) || 
        (next.getX() != last.getX() && (direction == UP || direction == DOWN))) { // This is to prevent bike from wrapping around edge of grid, because grid is a 1d array
      return true;
    }
    
    return false;
  }
  
  // CompareTo method for generating final leaderboard
  int compareTo(Object player) {
    return ((Player) this).lives - ((Player) player).lives;
  }
  
  
  // Getter / Setter methods -- should make these stylistcally the same (either get/set, or just the variable [eg. setSpeed() vs speed()]
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
 
  String name() {
    return this.name;
  }
  
  boolean isAlive() {
    return this.alive; 
  }
  
  ArrayList<Location> locations() {
    return this.playerLocations; 
  }
}