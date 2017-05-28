class Button{
  int x,y,w,h;
  String label;
  boolean overButton;
  color col;

  //Creates a new Button
  Button(int x, int y, int w, int h, String label, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.col = c;
  }

  void draw(){
    stroke(col);   
    fill(col);
    
    rect(x,y, w,h);
    fill(0);
    textAlign(CENTER, CENTER);
    
    text(label, x+w/2, y + h/2);    //Creates a button in a retangle, filled with the color from the constructor
  }
  
  color getCol() {      //Returns the color of the object
    return this.col; 
  }
}