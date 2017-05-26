class ColorPicker {
  color playerColor;
  Player currentPlayer;

  Button red;
  Button pink;
  Button blue;
  Button yellow;

  public ColorPicker() {
    playerColor = color(0,0,0);
    currentPlayer = null;
    int spacing = width / 50;
    int buttonWidth = 80;
    red = new Button(width/2-200, height/2, "Red");
    pink = new Button(width/2-300, height/2, "Pink");
    blue  = new Button(width/2-400, height/2, "Blue");
    yellow = new Button(width/2-100, height/2, "Yellow");
  }
  
  // Sets the current player for the colorpicker
  void setPlayer(Player player) {
    this.currentPlayer = player;
  }

  void keyPressed() {
    if(key == '1'){
      currentPlayer.setColor(color(255,0,0));
    }
   if(key == '2'){
      currentPlayer.setColor(color(255,105,180));
    }
   if(key == '3'){
      currentPlayer.setColor(color(0,0,255));
    }
    if(key == '4'){
      currentPlayer.setColor(color(0,255,255));
    }
  }

  void draw() {
      if (currentPlayer == null) {
        throw new NullPointerException(); 
      }
      println("drawing!");
      //background(0,0,0);
      textAlign(CENTER);
      textSize(60);
      text("Please select your color", width/2, 50);
      textSize(16);
      red.draw();
      blue.draw();
      pink.draw();
      yellow.draw();
  }
}