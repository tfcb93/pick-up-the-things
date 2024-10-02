extends Node

var score := 0;
@onready var endMenu := $End_menu;
@onready var player := $Player;

func _ready():
	events._timer_end.connect(game_finished);
	events._restart_game.connect(_on_restart_game);
	endMenu.visible = false;
	start_game();

func _process(_delta: float) -> void:
	if(globals.totalCollected == globals.totalCollectables):
		events.emit_signal("_win");
		globals.gameIsStop = true;
		events.emit_signal("_game_stop");
		endMenu.visible = true;


func start_game() -> void:
	events.emit_signal("_timer_start");

func game_finished() -> void:
	globals.gameIsStop = true;
	if(globals.totalCollected == globals.totalCollectables):
		events.emit_signal("_win");
		events.emit_signal("_game_stop");
		endMenu.visible = true;
	else:
		events.emit_signal("_lose");
		events.emit_signal("_game_stop");
		endMenu.visible = true;

func _on_restart_game() -> void:
	endMenu.visible = false;
	player.position = Vector3.ZERO;
	globals.gameIsStop = false;
	globals.gameTime = globals.game_initial_time;
	globals.totalCollectables = globals.game_initial_total_collectable;
	globals.totalCollected = 0;
	player_globals.score = 0;
	start_game();
