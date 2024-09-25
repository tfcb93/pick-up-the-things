extends Node

var isPaused := false;
var mainGameInstance := preload("res://Scenes/Main.tscn");
@onready var pause_screen := $"Pause Menu";

func _ready() -> void:
	Events._is_unpaused.connect(_on_unpause);
	Events.connect("_game_stop", _on_game_stop);
	Events.connect("_restart_game", _on_game_restart);
	pause_screen.visible = false;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;

func _process(_delta: float) -> void:
	# Detect if it's in game and open the menu screen
	if Input.is_action_just_pressed("pause") and not WorldGlobals.gameIsStop:
		isPaused = not isPaused;
		print(isPaused);
		if isPaused == true:
			_on_pause();
			pause_screen.visible = true;
		else:
			_on_unpause();
			pause_screen.visible = false;
		

func _on_pause() -> void:
	Events.emit_signal("_is_paused");
	get_tree().paused = true;
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;
	
func _on_unpause() -> void:
	get_tree().paused = false;
	isPaused = false;
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	pause_screen.visible = false;
	
func _on_game_stop() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE;

func _on_game_restart() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
