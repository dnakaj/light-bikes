import java.util.*;
class PowerUp
{
  String imageName;
  Random generator = new Random ();
  void populate ()
  {
    getGrid().add(new Location (200, 200, #8A15EA, LocationType.POWERUP));
  }
  
  double changeSpeed ()
  {
     if (generator.nextBoolean())
       return 0.5;
     else
       return -0.5;
  }
}