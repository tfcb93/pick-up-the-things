extends CanvasLayer

@onready var focus_button := $VBoxContainer/Back;

func _ready():
	Events._is_paused.connect(_on_open_menu);

func _on_reset_pressed():
	Events.emit_signal("_restart_game");
	Events.emit_signal("_is_unpaused");


func _on_exit_pressed():
	get_tree().paused = false;
	get_tree().change_scene_to_file("res://Scenes/Start_screen.tscn");
	

func _on_open_menu():
	focus_button.grab_focus();


func _on_back_pressed():
	Events.emit_signal("_is_unpaused");
