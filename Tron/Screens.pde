class Screen{
  int counter = 1;
  int player1 = -1;
  int player2 = -1;
  Button red = new Button(width/2-200, height/2, "Red");
  Button pink = new Button(width/2-300, height/2, "Pink");
  Button blue  = new Button(width/2-400, height/2, "Blue");
  Button yellow = new Button(width/2-100, height/2, "Yellow");
 
  void draw(){
    if(counter == 1){
      //mousePressed();
      textAlign(CENTER);
      textSize(60);
      text("Player One Select you're color", width/2, 50);
      textSize(16);
      red.draw();
      blue.draw();
      pink.draw();
      yellow.draw();
    }
    if(counter ==2){
      System.out.println("2");
      textAlign(CENTER);
      textSize(60);
      text("Player Two Select you're color", width/2, 50);
      textSize(16);
      
      red.draw();
      blue.draw();
      pink.draw();
      yellow.draw();
    }
  } 
}