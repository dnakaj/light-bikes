class PowerUp
{
  String imageName;
  
  
  void populate ()
  {
    getGrid().add(new Location (200, 200, #8A15EA, LocationType.POWERUP));
    println("printed powerup");
  }
}