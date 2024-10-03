extends CanvasLayer;

@onready var runTimer := $RunTimer;
@onready var scoreLabel := $"HBoxContainer/Value - Score";
@onready var timerLabel := $"HBoxContainer2/Text - Timer";

func _ready() -> void:
	events.connect("collectable_picked", increase_score);
	events.connect("timer_start", start_timer);
	events.connect("add_time", _on_add_time);
	events.connect("game_stop", _on_game_stop);
	runTimer.timeout.connect(game_stop);

	
func _process(_delta: float) -> void:
	if (not runTimer.is_stopped()):
		set_timer_text();
	
# Não deveria ter como aumentar o score aqui, só atualizar
func increase_score() -> void:
	player_globals.score += 1;
	scoreLabel.text = str(player_globals.score);
	

# Maybe starting the timer in the UI is not good, but for now it is what it is
func start_timer() -> void:
	runTimer.start(globals.game_time);
	globals.time_is_out = false;
	scoreLabel.text = str(player_globals.score);

func game_stop() -> void:
	if (globals.is_showing_miliseconds):
		timerLabel.text = "0:000"; # I need to do that otherwise the time can stop in a strange way
	else:
		timerLabel.text = "00";
	runTimer.stop();
	globals.time_is_out = true;
	events.emit_signal("timer_end");

func _on_game_stop() -> void:
	runTimer.stop();

func set_timer_text() -> void:
	if (globals.is_showing_miliseconds):
		timerLabel.text = "%1.3f" % runTimer.time_left;
		timerLabel.text = timerLabel.text.replace(".",":");
	else:
		timerLabel.text = "%2d" % runTimer.time_left;

func _on_add_time(additionalTime) -> void:
	runTimer.start(runTimer.time_left + additionalTime);
