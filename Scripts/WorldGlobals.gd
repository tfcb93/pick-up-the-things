extends Node;

const game_initial_time := 30.0;
const game_initial_total_collectable := 100;
const game_max_timer_collectables := 30;

var total_collectables := game_initial_total_collectable;
var total_collected := 0;
var time_is_out := false;
var game_time := game_initial_time;
var game_is_stop := false;

# settings
var is_game_in_fullscreen := false;
var is_scroll_inverted := false;
var is_showing_miliseconds := true;