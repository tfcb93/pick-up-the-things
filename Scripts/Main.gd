extends Node

var score := 0;
@onready var endMenu := $End_menu;
@onready var player := $Player;

func _ready():
	Events._timer_end.connect(game_finished);
	Events._restart_game.connect(_on_restart_game);
	endMenu.visible = false;
	start_game();

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
		endMenu.visible = true;

func _on_restart_game() -> void:
	endMenu.visible = false;
	player.position = Vector3.ZERO;
	start_game();
