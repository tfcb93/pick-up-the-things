extends Node

const game_initial_time := 30.0;
const game_initial_total_collectable := 100;

var totalCollectables := game_initial_total_collectable;
var totalCollected := 0;
var totalObstacles := 50;
var timeIsOut := false;
var gameTime := game_initial_time;
var gameIsStop := false;
