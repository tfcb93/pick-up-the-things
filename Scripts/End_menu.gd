extends CanvasLayer

@onready var restart := $BoxContainer/restart;
@onready var exit := $BoxContainer/exit;

func _ready() -> void:
	pass


func _on_exit_pressed() -> void:
	get_tree().quit();



func _on_restart_pressed() -> void:
	Events.emit_signal("_restart_game");
