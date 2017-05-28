import processing.sound.*;

import java.text.DecimalFormat;
import java.util.Collections;
import java.util.*;

/*
    Helvetica
 Helvetica-Bold
 Helvetica-BoldOblique
 Helvetica-Light
 Helvetica-LightOblique
 Helvetica-Oblique
 HelveticaNeue
 HelveticaNeue-Bold
 HelveticaNeue-BoldItalic
 HelveticaNeue-CondensedBlack
 HelveticaNeue-CondensedBold
 HelveticaNeue-Italic
 HelveticaNeue-Light
 HelveticaNeue-LightItalic
 HelveticaNeue-Medium
 HelveticaNeue-MediumItalic
 HelveticaNeue-Thin
 HelveticaNeue-ThinItalic
 HelveticaNeue-UltraLight
 HelveticaNeue-UltraLightItalic
 */

ArrayList<Player> players = new ArrayList();
ArrayList<String> directions = new ArrayList();
HashMap<String, Location> spawns = new HashMap();
ArrayList<Location> grid = new ArrayList();
ArrayList<Location> gridCache = new ArrayList();

PFont f = null;
int w = 0;
int h = 0;
final int topHeight = 50;
final int pixelSize = 5;
/*final int startMenu = 0;
 final int stateCreatePlayer = 1;
 final int statePlayGame = 2;
 final int stateExit = 3;*/
GameState state = GameState.MENU;
ScoreBar bar = null;
boolean doRespawn = false;
boolean doFullRender = true;
boolean doLeaderboard = false;
boolean runGame = false;
boolean ENABLE_SOUND = false;
float framerate = 30;
double respawnTimer = 3.0;
double respawnTimerBackup = respawnTimer; // Need a better way to save this variable
ArrayList <PowerUp> powerUps;

// SOUND [begin]

SoundFile readyToPlay;
SoundFile powerUp;
SoundFile gameOver;
SoundFile preGame;
SoundFile inGame;
SoundFile postGame;
SoundFX sfx;

// SOUND [end]

// Return dimensions of ColorPicker
int getWidth() {
  return w;
}
int getHeight() {
  return h;
}
int getTopHeight() {
  return topHeight;
}
int getPixelSize() {
  return pixelSize;
}
PFont getFont() {
  return f;
}

ArrayList<Player> getPlayers() { // Yes we don't actually need this getter, but it's good practice
  return players;
}

ArrayList<Location> getGridCache() {
  return gridCache;
}

// Get the powerup from the specified location
PowerUp getPowerUp(Location loc) {
  for (PowerUp pu : powerUps) {
    for (Location l : pu.imageLocs) {
      if (l.equals(loc)) {
        return pu;
      }
    }
  }
  return null;
}

void removePowerUp(PowerUp p) {
  for (Location loc : p.getLocations()) {
    Location replacement = new Location(loc.getX(), loc.getY());
    gridCache.add(replacement);
  }

  powerUps.remove(p); 
  render();
}

void setup() {
  // SOUND [begin]
  if (ENABLE_SOUND) {
    sfx = new SoundFX ();
    readyToPlay = new SoundFile (this, "ReadyToPlay.mp3");
    powerUp = new SoundFile (this, "PowerUp.wav");
    gameOver = new SoundFile (this, "GameOver.mp3");
    preGame = new SoundFile (this, "PreGame.mp3");
    inGame = new SoundFile (this, "InGame.mp3");
    postGame = new SoundFile (this, "PostGame.mp3");
  }
  // SOUND [end]
  
  f = createFont("HelveticaNeue-Light", 60, true);
  //println(join(PFont.list(), "\n"));
  directions = new ArrayList();
  directions.add("LEFT");
  directions.add("RIGHT");
  directions.add("UP");
  directions.add("DOWN");
  size(800, 720);
  resetGame();
}

// Resets the framerate, ColorPicker size, fields, playerlist, and game grid.
void resetGame() {
  frameRate(framerate);
  w = width;
  h = height;
  if (width % pixelSize != 0 || height % pixelSize != 0) {
    throw new IllegalArgumentException();
  }
  
  this.resetGrid();
  this.doRespawn = false;
  this.runGame = true;
  //this.state = GameState.MENU;

  // Size = 2 for now -- later can do a for loop given the amount of players
  // Four locations = (0 + WIDTH/
  spawns = new HashMap();
  spawns.put("RIGHT", new Location(50, (h - topHeight) / 2)); // LEFT SIDE
  spawns.put("LEFT", new Location(w-50, (h - topHeight) / 2)); // RIGHT SIDE
  spawns.put("DOWN", new Location(w/2, topHeight + 50)); // TOP SIDE
  spawns.put("UP", new Location(w/2, h - 50)); // BOTTOM SIDE
}

// Returns a sorted leaderboard of players (most lives left -> least)
ArrayList<Player> getLeaderboard() {
  ArrayList<Player> result = new ArrayList(players);
  for (Player player : players) {
    Collections.sort(result);
    Collections.reverse(result);
  }
  return result;
}

// Sets framerate to 2 and displays the game over ColorPicker (via call to draw)
void gameOver() {
  sfx.endGame();
  doLeaderboard = true;
  frameRate(10);
  //this.state = GameState.MENU;
  //If line 151 runs, it bypasses the gameover leaderboard screen for some reason
  //redraw();
}

// Places walls and powerups on the grid
void populateGrid() {
  for (int i=0; i<5; i++) {
    int chance = (int) random(10);
    if (chance <= 3) {
      int hh = ((int) random(50) + 1) * pixelSize;
      int ww = ((int) random(30) + 1) * pixelSize;

      int x = ((int) random(((width/2)/pixelSize))) * pixelSize + width/4;
      int y = ((int) random((height-topHeight)/pixelSize)) * pixelSize + topHeight;

      new Wall(w/2, 190, hh, ww).render();
    }
  }

  //int hh = ((int) random(50) + 1) * 5;
  //int ww = ((int) random(30) + 1) * 5;

  int fewestNumberOfPowerUps = 3;
  int greatesNumberOfPowerUps = 15;
  int wSize = 2;
  int hSize = 2;

  powerUps = new ArrayList <PowerUp> ();
  createPowerUps (fewestNumberOfPowerUps, greatesNumberOfPowerUps, wSize, hSize);
  //for (PowerUp p : powerUps) {
  //  println ("DREW POWERUP");
  //  p.populate();
  //}

  //PowerUp (hh, ww, pixelSize*2, pixelSize*2).addToCache();
}

// There is a very small chance a powerup will spawn offscreen in which case it might throw an exception
void createPowerUps (int low, int high, int h, int w) {
  int num = (int) (random (low, high + 1));
  for (int i = 0; i < num; i++) {
    int x = ((int) random((width/pixelSize))) * pixelSize;
    int y = ((int) random((height-topHeight)/pixelSize)) * pixelSize + topHeight;
    if (getLocation(x, y).getType() != LocationType.AIR) {
      println("Spawning on a wall!");
    }
    powerUps.add (new PowerUp (x, y, w, h));
  }
}

// Cleans the grid and and resets grid cache
void resetGrid() {
  background(50, 50, 50);
  this.grid = new ArrayList();
  //boolean black = true;
  for (int y=topHeight; y<h; y+=pixelSize) {
    for (int x=0; x<w; x+=pixelSize) {
      grid.add(new Location(x, y));
      /*if (black) {
       grid.add(new Location(x, y, color(0,0,0), LocationType.AIR));
       black ^= true;
       } else {
       grid.add(new Location(x, y, color(255,255,255), LocationType.AIR));
       black ^= true;
       }*/
    }
    //black ^= true;
  }
  populateGrid();
  /*
    new Wall(50, h/2, 100, 15).render();
   
   new Wall(w-50, h/2, 100, 15).render();
   
   new Wall(w/2, topHeight+50, 15, 50).render();
   
   new Wall(w/2, h-50, 15, 50).render();
   */
  this.gridCache = new ArrayList();
  this.doFullRender = true; // Why does this variable save as true in this method, but not when placed into resetGame()?
}

ArrayList<Location> getGrid() {
  return this.grid;
}

Location getLocation(Location loc) {
  return getLocation(loc.getX(), loc.getY());
}

// Returns the location associated with a given x and y coordinate (or null if nonexistant)
Location getLocation(int x, int y) {
  /* The initial, much slower way of fetching a location from the grid
   println();
   int c = 0;
   for (Location loc : grid) {
   if (loc.equals(new Location(x, y))) {
   println("C="+c);
   break;
   }
   c++;
   }*/


  try {
    if (x % pixelSize != 0) {
      return null;
    }

    // Jump directly to index of location

    /* PLAN:
     
     Original plan was to do: get (y-1) * getHeight() + x % pixelSize , but this returned numbers that were far too high (and threw index out of bounds exceptions). Thus, I returned to the planning
     phase, this time using a set of test coordinates:
     
     [example coords]
     
     x = 15
     y = 55
     
     c=123 [the actual index as done the slow way]
     
     55 - 50 = 5 [mistake was that I forgot to divide y - top by 5, and thus I was getting absurdly high values for my calculated "y" in grid
     
     (width / 5) * ((y - top) / 5) + x / 5
     
     New problem: Bike wraps around the edge when it collides [still ends the player's game, but this needs fixing]
     Solution: Just add an if statement checking if the Y changed without the player going up/down (see Player.pde -> checkCrash())
     
     */

    int index = (width / pixelSize) * ((y - topHeight) / pixelSize) + x / pixelSize; // A faster way to get the index of a location
    //println("D="+index);
    return grid.get(index);
  }
  catch (IndexOutOfBoundsException e) {
    //e.printStackTrace(); // An exception should be thrown for debugging purposes
  }

  return null;
}

// Draws the current game ColorPicker (and only draws new locations as opposed to drawing every location every time)
void render() {

  /*
      gridCache is a much more efficient way of rendering the grid -- instead of iterating every single location with each render(),
   it only draws the locations which have changed, cutting down on lag.
   */

  ArrayList<Location> queue = gridCache;

  if (doFullRender) { // On the first render it should draw the entire grid
    background(255, 255, 255);
    queue = grid;
    doFullRender = false;
    this.bar = new ScoreBar(players, 0, topHeight/2 + topHeight/4);
  }

  for (PowerUp p : powerUps) { // Workaround for cache being overwritten
    p.addToCache();
  }

  for (Location loc : queue) {
    if (loc.getType() != LocationType.POWERUP) {
      color c = loc.getColor();
      stroke(c);
      fill(c);

      rect(loc.getX(), loc.getY(), pixelSize-1, pixelSize-1);
    } else {
      Location l2 = getLocation(loc);
      if (l2 != null) {
        l2.setType(LocationType.POWERUP);
      }
    }
  }

  for (PowerUp p : powerUps) {
    /*println ("DREW POWERUP @ "+p.xC + ","+p.yC);
     for (Location loc : p.getLocations()) {
     color c = color(200,50,160);
     stroke(c);
     fill(c);
     
     rect(loc.getX(), loc.getY(), pixelSize-1, pixelSize-1);
     }*/
    p.render();
  }

  gridCache = new ArrayList();

  /*for (Location loc : grid) {
   color c = loc.getColor();
   stroke(c);
   fill(c);
   
   rect(loc.getX(), loc.getY(), pixelSize, pixelSize);
   }*/
}

// Moves respective player when a key is pressed
void keyPressed() {
  for (Player player : players) {
    // Need two if statements because key = char and keyCode = int
    if (key == CODED) {
      if (player.isKey(keyCode)) {
        player.changeDirection(keyCode);
      }
    } else {
      if (player.isKey(key)) {
        player.changeDirection(key);
      }
    }
  }
}

// Draws the game ColorPicker (grid if it's in game, respawn ColorPicker, and game over ColorPicker)
void playGame() {
  if (!runGame) {
    return;
  }
  if (doLeaderboard) {
    String gameOver = "Game Over";
    String leaderboard = "";

    int place = 1;
    for (Player player : getLeaderboard()) {
      leaderboard += "\n"+(place++)+". "+player.name()+" ("+player.lives()+" lives)";
    }

    background(0, 0, 0);
    PFont f2 = createFont("HelveticaNeue-Bold", 85, true);
    textAlign(CENTER);
    textFont(f2);
    fill(color(134, 244, 250));
    text(gameOver, width/2, height/2);

    textFont(f);
    text(leaderboard, width/2, height/2 + 15); // Make text size a variable
    textAlign(BASELINE);
    this.doLeaderboard = false;
    this.runGame = false;

    // Need a way to keep this text on the ColorPicker without it getting overwritten by setup();
    // Source for below code: https://stackoverflow.com/questions/2258066/java-run-a-function-after-a-specific-number-of-seconds
    new java.util.Timer().schedule(
      new java.util.TimerTask() {
      @Override
        public void run() {
        setup();
        this.cancel();
      }
    }
    , 2000);
  } else if (this.doRespawn) {
    if (respawnTimer > 0) {
      background(0, 0, 0);
      textFont(f, 60);
      fill(color(134, 244, 250));
      DecimalFormat df = new DecimalFormat("0.0");
      textAlign(CENTER);
      text("Restarting In\n"+df.format(respawnTimer), width/2, height/2);
      textAlign(BASELINE);
      respawnTimer -= 0.1;
    } else {
      respawnTimer = respawnTimerBackup;
      this.resetGrid();
      int count = 0;

      int index = 0;
      for (int i=players.size()-1; i>=0; i--) {
        Player player = players.get(i);
        if (player.lives() > 0) {
          String dir = directions.get(index++); // just assume # players <= # of directions
          player.respawn(spawns.get(dir));
          player.setDirection(dir);
          count++;
        }
      }

      if (count <= 1) {
        //sfx.endGame();
        gameOver();
        return;
      }

      this.doRespawn = false;
      frameRate(framerate);
      return;
    }
  } else {
    int dead = 0;
    int eliminated = 0;

    // Draw the current ColorPicker
    for (Player player : players) {
      if (player.isAlive()) {
        player.move(); // This will end up with a problem where if two players run into
        // eachother at same time, the player at index 0 with die first.
      } else {
        dead++;
        // NEED SOME SORT OF "FREEZE FRAME" when everyone dies before switching to timer.
        if (player.lives() == 0) {
          eliminated++;
        }
      }
    }

    if (players.size() - dead <= 1) {
      //delay(1000); // Pause frame for 1 second
      if (eliminated >= players.size() - 1) { // Can probably merge the two calls to setup()
        // RETURN TO MENU / PLAY AGAIN ColorPicker
        gameOver();
        return;
      }
      frameRate(10);
      doRespawn = true;
    } else {
      render();
    }
  }
  if (bar != null) {
    bar.render();
  }
}

void startMenu() {
  textAlign(CENTER);
  textFont(f);
  background(20, 20, 20);
  PImage img = loadImage ("TRON.png");
  image (img, 10, 100, width-20, 180);
  //text("TRON", width/2, height/2);
  fill(color(109, 236, 255));
  textSize(34);
  text("Press [2-4] to Select a Game Size", width/2, height/2 + 50);

  int playerSize = -1;

  // Below code is from: https://stackoverflow.com/questions/628761/convert-a-character-digit-to-the-corresponding-integer-in-c
  if (keyPressed) {
    playerSize = key - '0';

    if (playerSize >= 2 && playerSize <= 4) {
      // Later on player 1 and player 2 will be taken from text box input (same for color)
      this.players = new ArrayList();
      ArrayList<String> controls = new ArrayList();
      controls.add("wasd"); // player 1
      controls.add("arrows"); // player 2 
      controls.add("ijkl"); // player 3
      controls.add("gvbn"); // player 4

      for (int i=0; i<playerSize; i++) {
        String controlString = controls.get(i);
        char[] controlArray = new char[4];
        if (controlString.equals("arrows")) {
          controlArray[0] = UP;
          controlArray[1] = LEFT;
          controlArray[2] = DOWN;
          controlArray[3] = RIGHT;
        } else {
          for (int j=0; j<4; j++) { // Add each direction to the array using charAt
            controlArray[j] = controlString.charAt(j);
          }
        }
        this.players.add(new Player(controlArray[0], controlArray[1], controlArray[2], controlArray[3])); // One player mode breaks game
      }

      this.state = GameState.CREATE_PLAYER;
    }
  }
}

// Displays color picker screen until player has picked a color
void pickColor(Player player, ColorPicker picker) {
  // Going to get some nice errors here
  picker.setPlayer(player);
  background(#E3E3E3);

  if (player.getColor() != color(0, 0, 0)) {
    TextBox nameInput = new TextBox(player);
    if (keyPressed) {
      nameInput.keyPressed();
    }
    nameInput.draw();
  } else {
    picker.draw();
    picker.keyPressed();
  }

  key = 0;
}

// Player selection ColorPicker -- pick a name and color
void createPlayer() {
  ColorPicker colorPicker = new ColorPicker();

  for (Player player : players) {
    if (player.getColor() == color(0, 0, 0) || (player.hasName() == false)) {
      pickColor(player, colorPicker);
      return;
    }
  }
  sfx.moveToGame();
  
  state = GameState.PLAY_GAME;

  // Spawn players
  int index = 0;
  for (int i=players.size()-1; i>=0; i--) {
    String dir = directions.get(index); // Need to add players in reverse so that when they respawn, they move in the right direction
    players.get(i).setSpawn(spawns.get(dir)).setDirection(dir);
    index++;
  }

  // Update game state only if all players have name and color


  /*
  switch(currentPlayer) {
   case p1:
   player = players.get(0);
   int process = 1;
   
   break;
   case p2:
   player = players.get(1);
   //int process = 1;
   if ( process == 1) {
   selectColor.draw();
   if (player.getColor() != null)
   process++;
   } else if (process == 2) {
   TextBox name = new TextBox();
   name.draw();
   if (player.name() != null)
   state = GameState.PLAY_GAME;
   }
   break;
   default:
   System.out.println("Something went wrong!");
   exit();
   break;
   }*/
}

// Display's the relevant screen (relating to the game state)
void draw() {
  switch(state) {
  case MENU:
    background(0, 0, 0);
    startMenu();
    break;
  case CREATE_PLAYER:
    //background(0,200,0);
    frameRate(20);
    createPlayer();
    break;
  case PLAY_GAME:
    frameRate(framerate);
    playGame();
    break;
  }
}