extends Node;

@onready var endMenu := $End_menu;
@onready var player := $Player;

var score := 0;

func _ready() -> void:
	events.connect("timer_end", game_finished);
	events.connect("restart_game", _on_restart_game);
	endMenu.visible = false;
	start_game();

func _process(_delta: float) -> void:
	if(globals.total_collected == globals.total_collectables):
		events.emit_signal("win");
		globals.game_is_stop = true;
		events.emit_signal("game_stop");
		endMenu.visible = true;


func start_game() -> void:
	events.emit_signal("timer_start");

func game_finished() -> void:
	globals.game_is_stop = true;
	if(globals.total_collected == globals.total_collectables):
		events.emit_signal("win");
		events.emit_signal("game_stop");
		endMenu.visible = true;
	else:
		events.emit_signal("lose");
		events.emit_signal("game_stop");
		endMenu.visible = true;

func _on_restart_game() -> void:
	endMenu.visible = false;
	player.position = Vector3.ZERO;
	globals.game_is_stop = false;
	globals.game_time = globals.game_initial_time;
	globals.total_collectables = globals.game_initial_total_collectable;
	globals.total_collected = 0;
	player_globals.score = 0;
	start_game();
