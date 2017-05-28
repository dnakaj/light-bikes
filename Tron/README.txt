Group members: Dan, Kabir, and Josh
a. Total time spent on project:
    ~20 hours combined (but probably more)
b.
    Our project is the multi-player game Tron. The goal of the game is to cause the other "light cycle(s)"
    to crash, which happens when a cycle either runs into itself/another player, a wall, or runs into the
    edge of the map. Each cycle leaves a trail of color behind it, and the trail will also cause a player
    to crash. The longer the match runs, the more "cycle trails" there are on the map, making it increasingly hard
    to survive. At the end of the game, a final scoreboard is displayed, showing how many lives the winning
    player had remaining.


    There is also a wall which randomly spawns at the start of a match, in addition to powerups, which provide a speed boost
    (but they can provide too much speed as well, which can prove to be fatal).

    Lastly, we have a menu screen where each player selects a color and then a display name.

c. How to run / play Tron
    - To run the program hit the "play" button in Processing (with Tron.pde opened).
    * For the left hand player, the controls are:    W
                                                  A  S  D
    * For the right hand player, the controls are:    I
                                                   J  K  L

    * Hit spacebar to start the game, enter the corresponding number 1-4 to pick a color, and type on
      the keyboard to enter a name [10 characters max].

d. Who did what
    - Dan:
        * Tron.pde
        --> Methods to draw game grid (of a specified size & pixel size), players, and to spawn Walls
        * Location.pde
        --> Location stores its location, type, and color -- used for the game grid.
        * Player.pde
        --> Modified move() to be able to handle different speeds (via adding getLine())
        --> Added respawn() method to respawn the player at a specific location
        * ScoreBar.pde
        --> Display's the names, colors, and lives of each player (at the top of the screen, outside of the grid)
        * Wall.pde
        --> Spawns a wall of a specified width/height at the input x/y coordinate.
        * TextBox.pde
        --> Wrote base code to take keyboard input and convert it into a string (for getting the player's name)
    - Kabir:
        * Tron.pde
        --> Added methods to spawn PowerUps/Walls on the grid
        * Player.pde
        --> Wrote almost all of the player-related methods (except for the two methods I wrote) including getting the player to
            track all locations where the cycle had been, a method to pickup the powerups
        * PowerUp.pde
        --> Spawns a powerup on the grid and draws it as an image. Provides a speed boost to the player when picked up
    - Josh:
        * Tron.pde
        --> Methods to draw the main menu screen / cycle through screens for picking color/name/starting game
        * ColorPicker.pde
        --> Method to display a bunch of buttons with colors, when a button is hit it will set the player's color
        * Button.pde
        --> Displays a button of specified height/width at x,y coordinate with input label and color
        * TextBox.pde
        --> Made my base text box code into a usable interface
e. Major difficulties encountered
    BUGS:
    - Game doesn't restart (it's supposed to) after the game over screen
    - PowerUps aren't picked up when the player runs over them
    - Name selection screen sometimes glitches and enters a character twice
    - Controls sometimes freeze up when the round restarts
    UN-IMPLEMENTED FEATURES:
    - An AI cycle so that one person can play by themselves
    - More powerups (rewind the game, jump over/through a wall/cycle)
    - More game options available from the menu screen such as # players, speed, # of walls, size of walls,
      frequency of walls, which power-ups can spawn.
