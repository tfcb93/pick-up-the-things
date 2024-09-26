extends CanvasLayer

@onready var start_button := $"VBoxContainer/ButtonContainer/Start Button";

func _ready() -> void:
	start_button.grab_focus();

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn");

func _on_settings_button_pressed() -> void:
	# only as a testxss
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn");


func _on_exit_button_pressed() -> void:
	get_tree().quit();


func _on_instruction_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Instructions.tscn");
