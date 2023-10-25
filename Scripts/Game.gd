extends Node

var isPaused := false;
var mainGameInstance := preload("res://Scenes/Main.tscn");
@onready var pause_screen := $"Pause Menu";

func _ready() -> void:
	Events._is_unpaused.connect(_on_unpause);
	pause_screen.visible = false;

func _process(delta: float) -> void:
	# Detect if it's in game and open the menu screen
	if Input.is_action_just_pressed("Pause"):
		isPaused = not isPaused;
		if isPaused == true:
			_on_pause();
			pause_screen.visible = true;
		else:
			_on_unpause();
			pause_screen.visible = false;
		

func _on_pause() -> void:
	Events.emit_signal("_is_paused");
	get_tree().paused = true;
	
func _on_unpause() -> void:
#	Events.emit_signal("_is_paused");
	get_tree().paused = false;
	isPaused = not isPaused;
	pause_screen.visible = false;
