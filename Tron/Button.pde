class Button{
  int x,y;
  String label;
  boolean overButton;

  Button(int x, int y, String label){
    this.x = x;
    this.y = y;
    this.label = label;}

  void draw(){
    update(mouseX, mouseY);
    fill(200);
    if(overButton){
      fill(255);
    }
    fill(0);
    text(label, x, y + 100);}

  boolean over(int s, int z){
    if(mouseX >= s && mouseY >= z && mouseX <= s + textWidth(label) && mouseY <= z + 22){
      return true;
    }
    else{
      return false;
    }
  }

  void update(int s, int z){
    if(over(this.x, this.y)){
      overButton = true;}
     else{
       overButton = false;}
    }

  void mousePressed(){
    if(overButton){
      System.out.println("1");
    }else{
      System.out.println("-1");
    }
  }

}