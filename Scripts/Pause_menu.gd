extends CanvasLayer

@onready var focus_button := $VBoxContainer/Back;

func _ready():
	events._is_paused.connect(_on_open_menu);

func _on_reset_pressed():
	events.emit_signal("_restart_game");
	events.emit_signal("_is_unpaused");


func _on_exit_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://Scenes/Start_screen.tscn");
	

func _on_open_menu():
	focus_button.grab_focus();


func _on_back_pressed():
	events.emit_signal("_is_unpaused");
