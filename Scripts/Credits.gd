extends CanvasLayer;

@onready var back_button := $Button;

func _ready() -> void:
	back_button.grab_focus();

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start_screen.tscn");
