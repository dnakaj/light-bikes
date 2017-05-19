class TopBar {
  
  String message;
  // Top bar of the game; can move this somewhere else later
  TopBar(ArrayList<Player> players) {
  // FORMAT: <name> [***] : 
    StringBuilder bar = new StringBuilder();
    int count = 0;
    for (Player player : players) {
      // max lives = 3
      bar.append(player.name() + "[");
      for (int i=0; i<3; i++) {
        if (i < player.lives()) {
          bar.append("*"); 
        } else {
          bar.append("-"); 
        }
      }
      
      bar.append("]  ");
    }
  
    this.message = bar.toString();
  }
  
  String getMessage() {
    return this.message;
  }
  
}