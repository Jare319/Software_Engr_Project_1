# README for our ECEN 4273 Software Engineering course Project 1.
Source Code: https://github.com/Jare319/Software_Engr_Project_1

### GAME DESIGN
Our project seeks to provide a remake of the classic arcade game Asteroids using the Godot game engine.

### GAMEPLAY:
The gameplay for our version of the game is the same as the arcade version: Upon starting a game, you must
pilot your ship to dodge asteroids, while also shooting and breaking apart said asteroids for points. Upon 
destroying all asteroids on the screen, a new level is started with progressivly faster moving asteroids. 
Once the player is hit by a asteroid, they are killed and returned to the main menu, where they may replay, 
or exit the game. Players pilot their ship using the arrow keys, and fire a projectile using the spacebar.

### COMPILATION INSTRUCTIONS:
For users seeking to compile the game themselves, this can be done using the Godot game engine (We used V4.1.2).
After opening the project file using the game engine, simply open the export menu under Project > Export > Add >
(INSERT_ARCHITECTURE_OF_CHOICE). All default export options can be left at their default values, although two
options that may be desireable to change are the export path, and the "Embed PCK" option, which enables the
project to export a single executable, as opposed to also generating a "pck" folder of associated game assets.

### KNOWN BUGS:
- Upon dying, the player's ship is only hidden and not disabled, meaning a player can continue to move and shoot for a few seconds.
- Sometimes multiple asteroids can be destroyed by a single projectile shot.
- Upon clearing a level, the player's acceleration isn't reset to zero when they are moved back to the center of the screen, leading them to continue moving immediately as a level begins.

### SOURCES: 
- Game Design:
    * https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html
    * https://freeasteroids.org/ (Reference)

- Art:
    * https://www.img2go.com/ai-art-generator
    * https://gerald-burke.itch.io/geralds-keys