//Sounds taken from http://www.moviesoundclips.net/sound.php?id=235, https://www.youtube.com/playlist?list=PL7F37BB1A67E0238D and http://soundbible.com/1636-Power-Up-Ray.html

import processing.sound.*;

//String dataPath = sketchPath() + "/data/";


//For in game sound effects
class SoundFX {  
  //Plays start of game sound
  void preGame () {
    preGame.loop();
  }

  //Transitions sounds from pre game in to in game, implementation of shiftGain (gain from, gain to, time in milliseconds);
  void moveToGame () {
    preGame.stop();
    readyToPlay.play();
    inGame.play();
  }

  //Plays sound FX for power ups
  void gainedPowerUp () {
    powerUp.play();
  }
  
  //Plays sound for losing a life
  //void lostALife () {
  //  gameOver.play();
  //}

  ////Sound FX for end of game
  void endGame () {
    inGame.stop();
    //postGame.play();
  }
}