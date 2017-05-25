class ScoreBar {
  
  ArrayList<Player> players;
  ArrayList<String> messages;
  int x;
  int y;
  
  // Top bar of the game; can move this somewhere else later
  ScoreBar(ArrayList<Player> players, int x, int y) {
  // FORMAT: <name> [***] : 
    this.players = players;
    this.x = x;
    this.y = y;
  }
  
  void render() {
     stroke(color(50,50,50));
     fill(color(50,50,50));
     rect(0,0,getWidth(), getTopHeight());
     int tempX = this.x;
     int fontSize = 150 / (players.size() * 2);
     
     this.messages = new ArrayList();
     int count = 0;
     for (Player player : players) {
    
      StringBuilder bar = new StringBuilder();
      // max lives = 3
      bar.append(player.name() + " ");
      for (int i=0; i<3; i++) {
        if (i < player.lives()) {
          bar.append('\u25AE');  // http://jrgraphix.net/r/Unicode/?range=25A0-25FF
        } else {
          bar.append('\u25AF'); 
        }
      }
        
      String message = bar.toString();
      messages.add(message);
      
      PFont f = createFont("HelveticaNeue-Thin", 1, true);
      //f = getFont(); // This actually uses the default font
      textFont(f, fontSize);
      fill(player.getColor());
      //text("■", tempX, this.y);
      //fill(0);
      //tempX += 25;
      text(message, tempX, this.y);
      
      int newX = (int) textWidth(message) + 10;
      tempX += newX;
      count++;
    }
  }
  
  ArrayList<String> getMessages() {
    return this.messages;
  }
}