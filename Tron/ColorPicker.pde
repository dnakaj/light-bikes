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
    int buttonHeight = 40;
    red = new Button(width/2-200, height/2, buttonWidth, buttonHeight, "a", color(#EA5056));
    pink = new Button(width/2-100, height/2, buttonWidth, buttonHeight, "b", color(#F28BED));
    blue  = new Button(width/2, height/2, buttonWidth, buttonHeight, "c", color(#24ADF0));
    yellow = new Button(width/2+100, height/2, buttonWidth, buttonHeight, "d", color(#F0E924));
  }
  
  // Sets the current player for the colorpicker
  void setPlayer(Player player) {
    this.currentPlayer = player;
  }

  void keyPressed() {
    if(key == 'a'){
      currentPlayer.setColor(red.getCol());
    }
   if(key == 'b'){
      currentPlayer.setColor(pink.getCol());
    }
   if(key == 'c'){
      currentPlayer.setColor(blue.getCol());
    }
    if(key == 'd'){
      currentPlayer.setColor(yellow.getCol());
    }
  }
  
  
  void draw() {
      if (currentPlayer == null) {
        throw new NullPointerException(); 
      }
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