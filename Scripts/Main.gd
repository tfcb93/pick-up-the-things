extends Node

var score := 0;
@onready var endMenu := $End_menu;
@onready var player := $Player;

func _ready():
	Events._timer_end.connect(game_finished);
	Events._restart_game.connect(_on_restart_game);
	endMenu.visible = false;
	start_game();

func _process(_delta: float) -> void:
	if(WorldGlobals.totalCollected == WorldGlobals.totalCollectables):
		Events.emit_signal("_win");
		WorldGlobals.gameIsStop = true;
		Events.emit_signal("_game_stop");
		endMenu.visible = true;


func start_game() -> void:
	Events.emit_signal("_timer_start");

func game_finished() -> void:
	WorldGlobals.gameIsStop = true;
	if(WorldGlobals.totalCollected == WorldGlobals.totalCollectables):
		Events.emit_signal("_win");
		Events.emit_signal("_game_stop");
		endMenu.visible = true;
	else:
		Events.emit_signal("_lose");
		Events.emit_signal("_game_stop");
		endMenu.visible = true;

func _on_restart_game() -> void:
	endMenu.visible = false;
	player.position = Vector3.ZERO;
	WorldGlobals.gameIsStop = false;
	WorldGlobals.gameTime = WorldGlobals.game_initial_time;
	WorldGlobals.totalCollectables = WorldGlobals.game_initial_total_collectable;
	WorldGlobals.totalCollected = 0;
	PlayerGlobals.score = 0;
	start_game();
