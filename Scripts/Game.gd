extends Node;

@onready var pause_screen := $"Pause Menu";

var is_paused := false;
var main_game_instance := preload("res://Scenes/Main.tscn");

func _ready() -> void:
	events.connect("is_unpaused", _on_unpause);
	events.connect("game_stop", _on_game_stop);
	events.connect("restart_game", _on_game_restart);
	pause_screen.visible = false;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;

func _process(_delta: float) -> void:
	# Detect if it's in game and open the menu screen
	if (Input.is_action_just_pressed("pause") and not globals.game_is_stop):
		is_paused = not is_paused;
		if (is_paused == true):
			_on_pause();
			pause_screen.visible = true;
		else:
			_on_unpause();
			pause_screen.visible = false;
		

func _on_pause() -> void:
	events.emit_signal("is_paused");
	get_tree().paused = true;
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
	
func _on_unpause() -> void:
	get_tree().paused = false;
	is_paused = false;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	pause_screen.visible = false;
	
func _on_game_stop() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;

func _on_game_restart() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
