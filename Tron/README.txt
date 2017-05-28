﻿Group members: Dan, Kabir, and Josh
a. Total time spent on project:
    ~20 hours combined (but probably more)
b. Project Summary
    Our project is the multi-player game Tron. The goal of the game is to cause the other "light cycle(s)"
    to crash, which happens when a cycle either runs into itself/another player, a wall, or runs into the
    edge of the map. Each cycle leaves a trail of color behind it, and the trail will also cause a player
    to crash. The longer the match runs, the more "cycle trails" there are on the map, making it increasingly hard
    to survive. At the end of the game, a final scoreboard is displayed, showing how many lives the winning
    player had remaining.

    There is also a wall which randomly spawns at the start of a match, in addition to powerups, which provide a speed boost
    (but they can provide too much speed as well, which can prove to be fatal).

    Lastly, we have a menu screen where each player selects a color and then a display name.

    NOTE: The Processing Sound library was used to add sound effects to the game

    Additionally, we have in game sound effects.

c. How to run / play Tron
    - To run the program hit the "play" button in Processing (with Tron.pde opened).
    * For the left hand player, the controls are:    W
                                                  A  S  D
    * For the right hand player, the controls are:    up arrow, down arrow, left arrow, right arrow

    * For players 3 and 4 (if chosen) the control are: I, J, K, L and G, V, B, N

    * Follow on-screen instructions. When you are done with a step in the menu, hit ‘Enter’.

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
        --> Added methods to spawn PowerUps/Walls on the grid and implement sound effects
        * Player.pde
        --> Wrote almost all of the player-related methods (except for the two methods I wrote) including getting the player to
            track all locations where the cycle had been, a method to pickup the powerups
        * PowerUp.pde
        --> Spawns a powerup on the grid and draws it as an image. Provides a speed boost to the player when picked up
	* SoundFX.pde
	--> Adds sound effects to the game 
    - Josh:
        * Tron.pde
        --> Methods to draw the main menu screen / cycle through screens for picking color/name/starting game, and add support for 2-4 players.
        * ColorPicker.pde
        --> Method to display a bunch of buttons with colors, when a button is hit it will set the player's color
        * Button.pde
        --> Displays a button of specified height/width at x,y coordinate with input label and color
        * TextBox.pde
        --> Made my base text box code into a usable interface
e. Major difficulties encountered
    DEVELOPMENT:
    - For a while, the cycles would simply spawn and then the game would end (without ever appearing on screen). This
      was due to the fact that I had swapped a few lines of code, and thus it would draw the cycles and then overwrite them
      on the next line.
    - We were initially going to go with a larger color pallete and allow the player to mouse over each button, clicking to select,
      the color, but there were too many glitches (visually and functionally) and thus we decided to go with the current
      implementation instead.
    - Processing ran into a weird error where it claimed non of the classes (Wall, Player, etc) existed. This error was
      fixed by messing around with the file names and then setting them back to the original names.
    BUGS:
    - Game doesn't restart (it's supposed to) after the game over screen
    - Name selection screen sometimes glitches and enters a character twice
    - Controls sometimes freeze up when the round restarts
    - The sound sometimes gets limited by the computer speaker for some reason
    UN-IMPLEMENTED FEATURES:
    - An AI cycle so that one person can play by themselves
    - More powerups (rewind the game, jump over/through a wall/cycle)
    - More game options available from the menu screen such as starting speed, # of walls, size of walls,
      frequency of walls, which power-ups can spawn.
