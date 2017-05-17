import java.awt.*;
public class Player
{
  private static final int UP, DOWN, LEFT, RIGHT;
  private final int upKey, downKey, leftKey, rightKey;
  private int direction;
  private Color color;
  private String name;
  private ArrayList <Location> locList;
  private int direction;
  private int change;

  public Player (String n, Color c, int u, int d, int l, int r)
  {
    name = n;
    color = c;
    upKey = u;
    downKey = d;
    leftKey = l;
    rightKey = r;
    UP = 1;
    DOWN = 2;
    LEFT = 3;
    RIGHT = 4;
    direction = UP;
    change = 10;
    locList = new ArrayList <Location> ();
  }

  public void move ()
  {
    Location last = locList.get(locList.size() - 1);
    Location next;

    if (direction == UP)
    {
      next = new Location (last.getX(), last.getY() - change);
    }

    else if (direction == DOWN)
    {
      next = new Location (last.getX(), last.getY() + change);
    }

    else if (direction == LEFT)
    {
      next = new Location (last.getX() - change, last.getY());
    }

    else if (direction == RIGHT)
    {
      next = new Location (last.getX() + change, last.getY());
    }

    if (checkCrash (next));
    {
      gameOver();
    }

    else
    {
      locList.add (next);
      grid.set(next);
    }
  }

  public void changeDirection (int i)
  {
    if (i >= 1 && i <= 4)
    {
      direction = i;
    }
  }

  private boolean checkCrash (Location next)
  {
    LocationType type = next.getType();
    if (type == LocationType.PLAYER || type == LocationType.WALL) //.equals()?
    {
      return true;
    }
    return false;
  }

  public void gameOver ()
  {
    System.out.println("Game Over");
  }
}
