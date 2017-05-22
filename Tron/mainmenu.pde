PFont font;
Screen startscreen;
int stage;

void setup(){
  size(1000,1000);
  stage = 1;
  startscreen = new Screen();
}

void draw(){
  if(stage == 1){
    textAlign(CENTER);
    text("TRON", 100, 150);
    text("Press any key to play", 100, 170);
    if(keyPressed == true){
      stage = 2;
    }
  }
  if(stage == 2){
    clear();
    background(225);
    startscreen.draw();
  }
}