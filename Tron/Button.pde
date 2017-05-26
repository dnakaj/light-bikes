class Button{
  int x,y,w,h;
  String label;
  boolean overButton;
  color col;

  Button(int x, int y, int w, int h, String label, color c){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.label = label;
    this.col = c;
  }

  void draw(){
    //update(mouseX, mouseY);
    stroke(col);
    fill(col);
    /*if (overButton) {
      
      this.mousePressed();
      fill(255);
    }*/
    
    rect(x,y, w,h);
    fill(0);
    textAlign(CENTER, CENTER);
    
    text(label, x+w/2, y + h/2);
  }
  
  color getCol() {
    return this.col; 
  }
  
 /*
  boolean over(int s, int z){
    if ((mouseX >= x && mouseX <= (x+w)) && (mouseY >= y && mouseY <= (y+h))) {
      return true;
    }
    else{
      return false;
    }
  }

  void update(int s, int z){
    if(over(s, z)){
      overButton = true;
     } else {
       overButton = false;
     }
  }*/
}