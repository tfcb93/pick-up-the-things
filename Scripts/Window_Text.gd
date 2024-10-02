extends CanvasLayer;


@onready var timer := $TextTimer;
@onready var label := $BoxContainer/Label;
@onready var final_score := $BoxContainer/final_score

func _ready() -> void:
	events.connect("timer_start", start_game);
	events.connect("restart_game", _on_restart_game);
	events.connect("win", _on_win);
	events.connect("lose", _on_lose);
	timer.timeout.connect(clean_label);


func start_game() -> void:
	label.text = "START!";
	timer.start(1);
	
func _on_win() -> void:
	label.text = "YOU WIN!";
	final_score.text = "Your final score is: %d" % player_globals.score;
	
func _on_lose() -> void:
	label.text = "YOU LOSE!";
	final_score.text = "Your final score is: %d" % player_globals.score;

func _on_restart_game() -> void:
	label.text = "";
	final_score.text = "";

func clean_label() -> void:
	label.text = "";
