class TextBox{
  String input;
  Player player;
  color col = color(0,0,0);;
  PFont f;
  
  public TextBox(Player player){
    if (player.name() != null) {
      input = player.name();
    } else {
      input = ""; 
    }
    
    this.player = player;
    f = createFont("HelveticaNeue-Light", 60, true);
  }

  void draw() {
      background(color(0,0,0));
      textFont(f);
      fill(col);
      textAlign(CENTER);
      text(input, width/2, height/2);
  }

  void keyPressed() {
    if (key == ENTER) {
      if (input.length() == 0) {
        println("Please enter at least one letter.");
      } else {
        println("Your name is: "+input);
        col = color(0,255,0);
        //Screen.setStage(3);
      }
    }

    if ((key == CODED || keyCode < 48) && key != BACKSPACE) { // valid char check
      println("Please enter a valid character.");
    } else if (input.length() > 0 && key == BACKSPACE) { // backspace delete
      input = input.substring(0, input.length()-1);
    } else if (input.length() <= 10) { // add key
      println(key);
      input += key;
      player.setPlayerName(player.name() + key);
    } else { // input is too long
      println("Your input cannot be longer than 10 characters.");
    }
  }
}