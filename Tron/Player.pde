import java.awt.*; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
import java.util.Random;
import java.util.ArrayList;

final int DEFAULT_SPEED = 1;

class Player implements Comparable
{
  private final int UPKEY, DOWNKEY, LEFTKEY, RIGHTKEY; // The directional keys
  //private final int up, down, left, right; // Ints to store the current direction
  private color col;
  private String name;
  private ArrayList<Location> playerLocations;
  private int direction;
  private int speed;
  private boolean alive;
  private boolean hasName;
  private int speedTimer;
  private String displayKeys;
  Random generator = new Random();
  int lives = 3;
  
  SoundFX sfx = new SoundFX ();

  //Changed the constructor so that it did not initialize its name or color
  public Player (char u, char l, char d, char r)
  {
    // For the arrow keys it's possible to pass in an ampersand and itll read as a direction, but not sure how to fix that bug

    UPKEY = (int) u;
    DOWNKEY = (int) d;
    LEFTKEY = (int) l;
    RIGHTKEY = (int) r;
    this.name = "";
    this.hasName = false;

    this.col = color(0, 0, 0);
    playerLocations = new ArrayList<Location>();
  }

  public Player setSpawn(Location loc) {
    
    this.respawn(loc);
    return this;
  }
   //<>//
  // Used for the player creation screen where it displays that person's controls
  public Player setControlKeys(String keys) {
    this.displayKeys = keys;
    return this;
  }
  
  public String getControlKeys() {
    return this.displayKeys; 
  }

  // Moves player in the specified direction //<>//
  public Player setDirection(String direction) { //<>// //<>//
    switch (direction) {
      case ("UP"):
      this.direction = UPKEY;
      break;
      case ("DOWN"):
      this.direction = DOWNKEY;
      break;
      case ("LEFT"):
      this.direction = LEFTKEY;
      break;
      case ("RIGHT"): //<>//
      this.direction = RIGHTKEY; //<>//
      break;
    }
 //<>//
    return this;
  }

  // Gets the line of locations between two points (used for when speed > 1)
  ArrayList<Location> getLine(Location from, Location to) {
    // Add delta X and add delta Y (if vertical, delta x = 0, if horizontal, delta y = 0)
    if (to == null) { 
      return new ArrayList();
    } // In the future need a way to get all the points up to the border so that it draws a complete line.

    ArrayList<Location> result = new ArrayList();
    int deltaX = (from.getX() - to.getX())/getPixelSize(); // Amount of "pixels" between two the locations (x-wise) if delta = 10, 2 pixels so increase by 5 each time //<>//
    int deltaY = (from.getY() - to.getY())/getPixelSize();

    // Ensures that the deltaX and deltaY are valid (might not need this because we already know the location is valid)
    //if (deltaX % getPixelSize() != 0 || deltaY % getPixelSize() != 0) { throw new IllegalArgumentException(); }

    int currentX = from.getX();
    int currentY = from.getY();

    // Code from: https://stackoverflow.com/questions/13988805/fastest-way-to-get-sign-in-java
    int xSign = (int) Math.signum(deltaX);
    int ySign = (int) Math.signum(deltaY);

    for (int i=0; i<Math.abs(deltaX + deltaY); i++) { // This should include "to". deltaX + deltaY will be the amount of blocks to go up/horizontal because one should always be 0.
      currentX -= xSign * getPixelSize();
      currentY -= ySign * getPixelSize();
      Location loc = getLocation(currentX, currentY);

      result.add(loc);
      if (loc == null) {
        return result;
      }
    }

    return result;
  }


  // Moves the bike forward x amount
  public void move()
  {
    if (!alive) { 
      return;
    }

    if (speedTimer > 0) {
      speedTimer --;
    } else if (speedTimer == 0 && speed != DEFAULT_SPEED) {
      speed = DEFAULT_SPEED;
    }

    Location last = playerLocations.get(playerLocations.size()-1);
    Location next = null;

    // For the speed, iterate x blocks between last and next

    if (direction == UPKEY)
    {
      next = getLocation(last.getX(), (int)(last.getY() - speed * getPixelSize()));
    } else if (direction == DOWNKEY)
    {
      next = getLocation(last.getX(), (int)(last.getY() + speed * getPixelSize()));
    } else if (direction == LEFTKEY)
    {
      next = getLocation((int)(last.getX() - speed * getPixelSize()), last.getY());
    } else if (direction == RIGHTKEY)
    {
      next = getLocation((int)(last.getX() + speed * getPixelSize()), last.getY());
    }

    ArrayList<Location> line = getLine(last, next);

    if (line.size() == 0) {
      gameOver();
      return;
    }

    for (Location loc : line) {
      if (checkCrash (loc)) {
        gameOver();
        return;
      } else {
        // Former bug: For some reason when a player eats a powerup a hole appears in the line where the powerup was.
        Location l2 = getLocation(loc.getX(), loc.getY());
        l2.setType(LocationType.PLAYER);
        l2.setColor(this.col);

        playerLocations.add(l2);
        getGridCache().add(l2);
      }
    }
  }

  // Stops the player from moving and subtracts 1 from their life pool
  void gameOver() {
    this.lives --;
    this.alive = false;
  }

  // (Re)spawns ths player in the arena and resets the relevant variables. Note that there is a very small chance of two players spawning on one another -- find a workaround for this later.
  void respawn(int x, int y) {
    if (x % getPixelSize() != 0 || y % getPixelSize() != 0) { 
      throw new IllegalArgumentException();
    }

    this.direction = RIGHTKEY;
    this.alive = true;
    this.speed = DEFAULT_SPEED;
    this.playerLocations = new ArrayList();
    this.playerLocations.add(new Location(x, y, this.col, LocationType.PLAYER));
  }

  void respawn(Location loc) {
    respawn(loc.getX(), loc.getY());
  }


  // Checks if the input char is one of the player's direction keys
  boolean isKey(int dir) {
    return (dir == UPKEY || dir == DOWNKEY || dir == RIGHTKEY || dir == LEFTKEY);
  }

  // Switches the player's direction
  public void changeDirection (int dir) {
    if ((dir == UPKEY || dir == DOWNKEY || dir == RIGHTKEY || dir == LEFTKEY) && validMove(dir))
    {
      direction = dir;
    }
  }


  // Checks if player can move in that direction. Prevents player from moving in the direction opposite of their current direction
  private boolean validMove(int dir) {
    return !(dir == UPKEY && direction == DOWNKEY || dir == DOWNKEY && direction == UPKEY || dir == LEFTKEY && direction == RIGHTKEY || dir == RIGHTKEY && direction == LEFTKEY);
  }


  // Checks if the player's next location will cause the player to crash [true if it will / false if it wont]
  private boolean checkCrash (Location next)
  {
    if (next == null) {
      return true;
    }

    Location last = playerLocations.get(playerLocations.size()-1);

    LocationType type = next.getType();
    //println(getLocation(next).getType()+" : "+next);
    if (type == LocationType.POWERUP) {
      PowerUp p = getPowerUp(next);

      if (p != null) { // Basically a workaround for the NPE
        if (ENABLE_SOUND) {
          sfx.gainedPowerUp();
        }
        addSpeed(1);
        speedTimer += (int) frameRate * 2;
        removePowerUp(p);
      }

      return false;
    }

    if ((type == LocationType.PLAYER || type == LocationType.WALL) ||
      (next.getY() != last.getY() && (direction == LEFTKEY || direction == RIGHTKEY)) ||
      (next.getX() != last.getX() && (direction == UPKEY || direction == DOWNKEY))) { // This is to prevent bike from wrapping around edge of grid, because grid is a 1d array
      //sfx.lostALife(); //Commented out because you hear a shrill sound at the end for some reason
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

  void setColor(color other) {
    this.col = other;
  }

  color getColor() {
    return this.col;
  }

  int lives() {
    return this.lives;
  }

  void setPlayerName(String name) {
    this.name = name;
  }

  String name() {
    return this.name;
  }

  void setHasName() {
    this.hasName = true;
  }

  boolean hasName() { // If player's name is complete
    return this.hasName;
  }

  boolean isAlive() {
    return this.alive;
  }

  ArrayList<Location> locations() {
    return this.playerLocations;
  }
}