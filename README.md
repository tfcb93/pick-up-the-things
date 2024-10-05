# Pick Up The Things!

Pick Up The Things is a 3D game made in Godot using GDScript, where the player has to pick up small collectables in an area in a given time. The game isn't finished, and it might not be, but it was used to learn about 3D.

## About this game

During 2023, the [Laidback Camp All-in-One](https://yurucamp-game.enish.com/lang_en/) game had, for a limited time, a small minigame inside it, presenting the character Shima Rin walking around collecting pines. These pines would later be used to upgrade abilities and features in the small game and could also be used to get other items for the main game.  
The minigame was a fun play, and since it was only for a limited time, the decision to try making something similar came into mind. The game mechanics could be enjoyed again, and a project like that would possibly try different features that could work. Creating a project like that could also help in learning 3D development.  
In this version, the player controls a small yellow sphere that walks (not rolls) in a field to collect small collectable blue and orange balls. Each ball gives you one point. Orange balls also increase your time by 1 second. The player wins after you collect 100 balls. The levels are randomly generated.  

## Why the decision to open the code
The project started around August 2023, and after a month, the game was in a presentable state, allowing the player to collect random spheres in an open place. After that, the development was halted, and other ideas came after this one. After some time, the development goals were lost, and the project didn't have a finish line. Some of the ideas were:
  - Various types of levels
  - Different types of collectables
  - Lists of special items
  - Power-ups
  - Level-ups (like in the Laidback Camp game)
  - and other ideas that came to mind
  
In the end, it was decided to at least put it in a more "presentable" state, aiming at a portfolio and showing its progress. Although putting this project as "canceled" on the itch.io page, it might still get some updates from time to time for fixes and some adjustments when necessary. Maybe some features can be added in the future.

## About this code
The code is in GDScript. This decision is because the language is simple, and disposes of various tutorials and examples that are easy to find. But despite being a script language, this code follows some non-script style writing, having `;` at the end of every line, `()` for `if`s and `while`s and other small details.  
This document doesn't plan on explaining everything about it but points out a few details about parts of its code.


### Camera moviment
The code for the camera pivot uses some content from the video [3D Movement in Godot in Only 6 Minutes](https://www.youtube.com/watch?v=UpF7wm0186Q) by [GDQuest](https://www.gdquest.com/). Lines 35 to 39 are specifically from the video, and might as well contain other tips from there.  
The rest of the code also includes controls for zoom using both controllers and keyboard + mouse.


### Level generator
Levels are generated following a few rules. First, the floor dimensions are generated using a defined value for a sub-division/sub-area side size. Sub-areas are square and have only one obstacle each. This was done for simplicity, making it easy to calculate positions and avoid collision among obstacles, collectables, and the player.  
On each sub-area, the next steps are followed
  - The whole floor is calculated using `side_area_division` for the number of "columns" and "lines" the area will have and using `area_ratio` to calculate its final size.
  - A sub-area is a small portion of the floor, a position inside the "columns" and "lines" in it.
  - The values for x and z minimum and maximum (x0, z0 and x1, z1) are calculated.
  - The position of the obstacle is decided randomly.
    - It's checked if the area is not colliding with the initial player position for a given distance.
  - The obstacle's position is returned by the function so it can be used for the collectables list.
  - Collectables are generated
    - They are checked to not collide with the player, the obstacle of that sub-area, and the other collectable previously generated.
    - The time collectables are calculated using a (non-uniform) random number and defined probability.
    - This is repeated until the sub-area generates the maximum value of collectables.

#### `add_to_collectables_list`
This function accepts 6 parameters, and those are:  
  - `area_x_0`: The point X0 of the area, assuming this value is smaller than `area_x_1`.
  - `area_x_1`: The point X1 of the area.
  - `area_z_0`: The point Z0 of the area. assuming this value is smaller than `area_z_1`.
  - `area_z_1`: The point Z1 of the area.
  - `sub_area_obstacle_pos: Vector3`: Sub-area's obstacle position.
  - `total_area_collectables: int`: Total value of collectables in that area.

The decision not to use a dictionary or an array here, even knowing that a reference would save more memory, is for pure simplicity in implementation. The separation of parameters looks more visible than passing a single parameter called `area_dimensions`, for example.  

The total area collectable has to be passed since the value for each sub-area doesn't need to be the same, but the value needs to be reduced later from the total (remaining value).

For curiosity, more obstacles could be implemented in the future. Modifying the obstacle generator function to check if the sub-area reaches the maximum value, as well as checking the distance between other obstacles avoiding those from colliding with each other. At the end, return an array of `Vector3` containing the obstacles' positions.


## Conclusion

Feel free to open issues about problems, optimization, or questions related to the code. The code is under the MIT license.  
If it's possible to request, please consider including the author's name in the credits if used as the base of another project.  