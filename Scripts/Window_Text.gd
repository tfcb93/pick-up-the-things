extends CanvasLayer


@onready var timer := $TextTimer;
@onready var label := $BoxContainer/Label;

func _ready() -> void:
	Events._timer_start.connect(start_game);
	Events._win.connect(win_text);
	Events._lose.connect(lose_text);
	timer.timeout.connect(clean_label);


func start_game() -> void:
	label.text = "START!";
	timer.start(1);
	
func win_text() -> void:
	label.text = "YOU WIN!";
	timer.start(5);
	
func lose_text() -> void:
	label.text = "YOU LOSE!";
	timer.start(5);
	
func clean_label() -> void:
	label.text = "";
