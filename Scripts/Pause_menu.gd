extends CanvasLayer;

@onready var focus_button := $VBoxContainer/Back;

func _ready() -> void:
	events.connect("is_paused", _on_open_menu);

func _on_reset_pressed() -> void:
	events.emit_signal("restart_game");
	events.emit_signal("is_unpaused");


func _on_exit_pressed() -> void:
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://Scenes/Start_screen.tscn");
	

func _on_open_menu() -> void:
	focus_button.grab_focus();


func _on_back_pressed() -> void:
	events.emit_signal("is_unpaused");
