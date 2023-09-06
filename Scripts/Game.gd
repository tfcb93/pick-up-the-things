extends Node

var isPaused := false;
var mainGameInstance := preload("res://Scenes/Main.tscn");

func _ready() -> void:
	pass;

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		isPaused = not isPaused;
		if isPaused == true:
			_on_pause();
		else:
			_on_unpause();
		

func _on_pause() -> void:
	get_tree().paused = true;
	
func _on_unpause() -> void:
	get_tree().paused = false;
