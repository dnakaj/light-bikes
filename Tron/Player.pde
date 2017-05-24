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
  private double speed;
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
  }


  public Player setSpawn(Location loc) {
    this.respawn(loc);
    return this;
  }

  // Moves player in the specified direction //<>//
  public Player setDirection(String direction) { //<>// //<>//
    switch (direction) {
      case ("UP"):
        this.direction = UP;
        break;
      case ("DOWN"):
        this.direction = DOWN;
        break;
      case ("LEFT"):
        this.direction = LEFT;
        break;
      case ("RIGHT"): //<>// //<>//
        this.direction = RIGHT; //<>// //<>//
        break;
    }

    return this;
  }

  // Gets the line of locations between two points (used for when speed > 1)
  ArrayList<Location> getLine(Location from, Location to) {
    // Add delta X and add delta Y (if vertical, delta x = 0, if horizontal, delta y = 0)
    if (to == null) { return new ArrayList(); } // In the future need a way to get all the points up to the border so that it draws a complete line.

    ArrayList<Location> result = new ArrayList();
    int deltaX = (from.getX() - to.getX())/getPixelSize(); // Amount of "pixels" between two the locations (x-wise) if delta = 10, 2 pixels so increase by 5 each time //<>// //<>//
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
  public void move ()
  {
    if (!alive) { return; }

    Location last = playerLocations.get(playerLocations.size()-1);
    Location next = null;

    // For the speed, iterate x blocks between last and next

    if (direction == UP)
    {
      next = getLocation(last.getX(), (int)(last.getY() - speed * getPixelSize()));
    }

    else if (direction == DOWN)
    {
      next = getLocation(last.getX(), (int)(last.getY() + speed * getPixelSize()));
    }

    else if (direction == LEFT)
    {
      next = getLocation((int)(last.getX() - speed * getPixelSize()), last.getY());
    }

    else if (direction == RIGHT)
    {
      next = getLocation((int)(last.getX() + speed * getPixelSize()), last.getY());
    }

    ArrayList<Location> line = getLine(last, next);

    if (line.size() == 0) {
      gameOver();
      return;
    }

    // Instantly crashes player despite output saying otherwise
    for (Location loc : line) {
      if (checkCrash (loc)) {
        gameOver();
        return;
      } else {
        loc.setType(LocationType.PLAYER);
        loc.setColor(this.col);

        playerLocations.add(loc);
        getGridCache().add(loc);
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
    if (x % getPixelSize() != 0 || y % getPixelSize() != 0) { throw new IllegalArgumentException(); }

    this.direction = RIGHT;
    this.alive = true;
    this.speed = 1;
    this.playerLocations = new ArrayList();
    this.playerLocations.add(new Location(x, y, this.col, LocationType.PLAYER));
  }

  void respawn(Location loc) {
    respawn(loc.getX(), loc.getY());
  }

  /* An old method for randomly spawning the player in the map
  void respawn() {

    int w = getWidth();
    int h = getHeight();

    int x = ((int) random(w/getPixelSize())) * getPixelSize();
    if (x > w/2) { x = w/2; } // Ensures player starts on left side of screen

    int y = ((int) random(h/getPixelSize())) * getPixelSize();
    if (y < getTopHeight()) { y = topHeight + (int) random(h/getPixelSize() - topHeight); }
    int count = 0;
    for (Player player : players) {
      count += getPixelSize();
      if (player.name().equals(this.name) && player.getColor() == this.col) {
         y = getTopHeight() + count * getPixelSize();
      }
    }

    respawn(x, y);
  }*/


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

    if (type == LocationType.POWERUP)
    {
      addSpeed(new PowerUp ().changeSpeed());
    }

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
  void addSpeed(double speed) {
    this.speed += speed;
  }

  void setSpeed(double speed) {
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
