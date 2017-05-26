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
    red = new Button(width/2-200, height/2, buttonWidth, buttonHeight, "1", color(#EA5056));
    pink = new Button(width/2-100, height/2, buttonWidth, buttonHeight, "2", color(#F28BED));
    blue  = new Button(width/2, height/2, buttonWidth, buttonHeight, "3", color(#24ADF0));
    yellow = new Button(width/2+100, height/2, buttonWidth, buttonHeight, "4", color(#F0E924));
  }
  
  // Sets the current player for the colorpicker
  void setPlayer(Player player) {
    this.currentPlayer = player;
  }

  void keyPressed() {
    if(key == '1'){
      currentPlayer.setColor(red.getCol());
    }
   if(key == '2'){
      currentPlayer.setColor(pink.getCol());
    }
   if(key == '3'){
      currentPlayer.setColor(blue.getCol());
    }
    if(key == '4'){
      currentPlayer.setColor(yellow.getCol());
    }
  }

  void draw() {
      if (currentPlayer == null) {
        throw new NullPointerException(); 
      }
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