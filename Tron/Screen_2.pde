class Screen{
  color player;
  Button red;
  Button pink;
  Button blue;
  Button yellow;
  public Screen() {
    player = null;
    stage = 1;
    red = new Button(width/2-200, height/2, "Red");
    pink = new Button(width/2-300, height/2, "Pink");
    blue  = new Button(width/2-400, height/2, "Blue");
    yellow = new Button(width/2-100, height/2, "Yellow");}

  void setStage(int x){
    this.stage=x;
  }

  void keyPressed(){
    Player player = players.get(stage);
      if(key == '1'){
        player.setColor(color(255,0,0));
      }
      if(key == '2'){
        player.setColor(color(255,105,180));
      }
      if(key == '3'){
        player.setColor(color(0,0,255))
      }
      if(key == '4'){
        player.setColor(color(0,255,255));
      }
    }

  void draw(){
      textAlign(CENTER);
      textSize(60);
      text("Select your color", width/2, 50);
      textSize(16);
      red.draw();
      blue.draw();
      pink.draw();
      yellow.draw();
    }

}
