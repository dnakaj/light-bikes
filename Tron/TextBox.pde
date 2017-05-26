class TextBox{
  String input;
  Player player;
  color col = color(50,50,200);
  PFont f;
  char BLANK_KEY = ')';
  
  public TextBox(Player player){
    this.input = player.name();
    
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
    println("k="+key);
    if (key == ENTER) {
      if (input.length() == 0) {
        println("Please enter at least one letter.");
      } else {
        println("Your name is: "+input);
        col = color(0,255,0);
        this.player.setHasName();
        //Screen.setStage(3);
      }
    } else if (key == BLANK_KEY) {
      return;
    } else if ((key == CODED || (int) key < 48) && key != BACKSPACE) { // valid char check
      println("Please enter a valid character. key="+key+" code="+(int) key);
    } else if (input.length() > 0 && key == BACKSPACE) { // backspace delete
      
      player.setPlayerName(input.substring(0, input.length()-1));
    } else if (input.length() <= 10) { // add key
      println();
      input += key;
      println("input="+input);
      player.setPlayerName(player.name() + key);
      //println(player.name());
      this.draw();
    } else { // input is too long
      println("Your input cannot be longer than 10 characters.");
    }
  }
}