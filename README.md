# Pick up the things!
### by Thiago Borges (tfcb93)

This is a 3D game where you have to pick up stuff in a given time. This game is inspired on the cones pick up minigame in the Yurucamp mobile game.
I made this project as a well of learning more about Godot, GDScript, and game development techniques.


##### One thing about this code


## About this game

During 2023, the [Laidback Camp All-in-One](https://yurucamp-game.enish.com/lang_en/) had for limited time a small minigame, presenting the character Shima Rin walking around collecting pines. This pines would later become points to upgrade habilities and features in the small game, as well helping on getting tickets for the major game it was inside.  
For me, the game was really fun to play. It wasn't something special, but it had some challenge and enjoyment on trying my best to compete against the timer to get my highest score, and achieve maximum level on the said features and upgrades.  
But the game was only for limited time. I wanted to play it again, and since I had time to do that, I decided to have a try and make my version of it, maybe even test some other ideas over it. I never have done a 3D game, but I decided to take the shot.  
In this version, you control a small sphere that walks (not rolls) over small collectable balls. Each ball gives you one point. Orange balls also increse your time in 1 second. After you collect 100 balls you win the game. The levels are only randomly generated.  

## Why I decided to open it
I think I worked on it for a month or so to reach a small playable state. No menus, only restart and quit at the end, and even no obstacles, only the collectables.  
Working on that I came with various ideas for it:
    - Various types of levels
    - Different types of collectables
    - An album for special collectable items
    - Power ups
    - Level ups (like int he Laidback Camp game)
    - and so on...
But the game development entered in a halt after sometime. I don't even rememeber what caused me to abandon the project and start something new. Don't remember if it was a roadblock, or looking for the excitement of a new project, but I decided to put it aside and probably start something new.  
This end of year I decided to at least put some of my projects on a more "presentable" state, to build portfolio, showing people what I have been doing this last 2 years.  
I might still update this project in the future, for fixes and small adjustments when I feel necessary. Maybe I finish it, or maybe someone else interested on the idea, who knows.

## About this code

This game is all coded in GDScript.


### Camera moviment
The code for the moviment of the camera was heavily insipired in the video [3D Movement in Godot in Only 6 Minutes](https://www.youtube.com/watch?v=UpF7wm0186Q) by [GDQuest](). Lines 24 to 28 are actually from the video, as well as might be other tips and bits here and there.  
For the rest of it I adapted for the use in a controller, by making a sole function for it. As well, I added controlls for zooming in and out.


### Level generator
Levels are generated following few rules. The first one is that the floor is generated based in a sub-division/sub-area size. All sub-areas are square and have only one obstacle. This was decided due to simplicity, making easier to calculate and implement areas where you need to have an obstacle, and that must not collide with other obstacles nor generate collectables inside those.
On each sub-area, the following steps are follow:
    - The area is calculated
    - The position of that area obstacle is decided randomly
      - It's is checked if the area is not colliding with the initial player position for a small distance
    - The position value is returned by the function so it can be passed for the collectable list
    - Collectables are generated
      - They are checked if the distance between themselves, the obstacle and the player are not colliding
      - There is also calculated a probability (not uniform) for time collectables to appear
      - This is repeated until the area reaches the maximum value of collectables there

#### `add_to_collectables_list`
This function has a bunch of paramenters, which are:
    - `area_x_0`: The point X0 of the area, I assume it's smaller than `area_x_1`.
    - `area_x_1`: The point X1 of the area.
    - `area_z_0`: The point Z0 of the area. I assume it's smaller than `area_z_1`.
    - `area_z_1`: The point Z1 of the area.
    - `sub_area_obstacle_pos: Vector3`: Sub-area's obstacle position.
    - `total_area_collectables: int`: Total value of collectables in that area.

I decided to not use a dictionary nor an array in this case, even though knowing that a reference would save memory, but for simplicity in implementation I decided to keep the parameters separated from each other.

Total area collectable needs to be passed since the value has to be in accordance of the division of each area plus allowing the remaining value to be used until reach the maximum value for it.

I could make it accept more obstacles in sub-areas. I would need to check all values before inserting, to not collide with other obstacles, as well as keep those values for not colliding with collectables as well.


## Conclusion

Feel free to open issues regards a problems in the code, better optimization, or help learning more about GDScript. This code is under the MIT license and is totally ok for people to use it as said. The only request I have is, if possible, recognize my work by including my name and a link for this project.