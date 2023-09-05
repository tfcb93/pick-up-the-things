extends Node

var score:int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	Events._timer_end.connect(game_finished);
	start_game();

#func _increase_score():
#	score += 1;
#	print(score);

func _process(delta: float) -> void:
	if(WorldGlobals.totalCollected == WorldGlobals.totalCollectables):
		Events.emit_signal("_win");


func start_game() -> void:
	Events.emit_signal("_timer_start");

func game_finished() -> void:
	if(WorldGlobals.totalCollected == WorldGlobals.totalCollectables):
		Events.emit_signal("_win");
	else:
		Events.emit_signal("_lose");
