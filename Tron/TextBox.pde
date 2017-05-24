
String input = "";
color col = color(0,0,0);;

void setup() {
  size(500,500); 
  col = color(134, 244, 250);
}

void draw() {
    background(color(0,0,0));
    PFont f = createFont("HelveticaNeue-Light", 60, true);
    
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
    }
  }
  
  if ((key == CODED || keyCode < 48) && key != BACKSPACE) { // valid char check
    println("Please enter a valid character.");
  } else if (input.length() > 0 && key == BACKSPACE) { // backspace delete
    input = input.substring(0, input.length()-1); 
  } else if (input.length() <= 10) { // add key
    println(key);
    input += key; 
  } else { // input is too long
    println("Your input cannot be longer than 10 characters."); 
  }
}