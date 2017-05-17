 Group: Dan, Josh, and Kabir
1. We plan on making a 2D Tron game using Processing.
   - 2 players
   - Powerups (speed boost, jump, rewind)
2. This project is compelling because it will be fun to code without being too simple that we end up getting
bored of working on it. In addition, the game shouldn't be too hard to split among three people, which was
another driving factor behind our decision.
3.
    a. We will likely not need any external libraries
    b. Classes:
    - Tron.java
    ---> Will connect the below classes, forming a coherent game. Will also include buttons etc.
    ---> Will have all main methods (run game, restart game, etc) and any utility methods
    - Grid.java
    ---> The game grid (will contain a bunch of locations)
    ---> Methods will include a draw method, and will have a 2d array of locations representing the screen.
    - Location.java
    ---> Used in game grid; tracks the location of each Powerup/Player
    ---> Methods will include getters/setters, and the color of that location
    - Powerup.java
    ---> Handles the game powerups.
    ---> Will have methods for each powerup, and a private field to denote which type of powerup it is.
    - Player.java
    ---> The player; constructor will include the four control keys, a color, and a name.
    c. We may have to learn how to program a simple AI if we end up enabling a single player (vs CPU) gamemode.
4. We're not quite sure as to who will specificially do what, but the classes would be broken down like so:
    [Person 1] Tron.java & Button.java
    [Person 2] Grid.java & Location.java
    [Person 3] Powerup.java & Player.java
