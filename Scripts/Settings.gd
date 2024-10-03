extends CanvasLayer;

@onready var fullscreen_toggle := $VBoxContainer/fullscreen;
@onready var scroll_toggle := $VBoxContainer/invert_scroll;
@onready var millisec_toggle := $VBoxContainer/show_mili;

func _ready() -> void:
	fullscreen_toggle.button_pressed = globals.is_game_in_fullscreen;
	scroll_toggle.button_pressed = globals.is_scroll_inverted
	millisec_toggle.button_pressed = globals.is_showing_miliseconds
	fullscreen_toggle.grab_focus();

func _on_check_button_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN);
		globals.is_game_in_fullscreen = true;
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED);
		globals.is_game_in_fullscreen = false;


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Start_screen.tscn");


func _on_invert_scroll_toggled(toggled_on: bool) -> void:
	globals.is_scroll_inverted = toggled_on;
	events.emit_signal("invert_mouse", toggled_on);


func _on_show_mili_toggled(toggled_on: bool) -> void:
	globals.is_showing_miliseconds = toggled_on;
