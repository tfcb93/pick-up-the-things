extends CanvasLayer

@onready var scoreLabel := $"HBoxContainer/Value - Score";
@onready var runTimer := $RunTimer;
@onready var timerLabel := $"HBoxContainer2/Text - Timer";

func _ready() -> void:
	Events._collectable_picked.connect(increase_score);
	Events._timer_start.connect(start_timer);
	
func _process(delta: float) -> void:
	if not runTimer.is_stopped():
		set_timer_text();
	
func increase_score() -> void:
	PlayerGlobals.score += 1;
	scoreLabel.text = str(PlayerGlobals.score);
	

func start_timer() -> void:
	runTimer.start(WorldGlobals.gameTime);
	runTimer.timeout.connect(game_stop);

func game_stop() -> void:
	timerLabel.text = "0"; # Yeah yeah, I know...
	runTimer.stop();
	WorldGlobals.timeIsOut = true;
	Events.emit_signal("_timer_end");

func set_timer_text():
	timerLabel.text = "%d" % (runTimer.time_left + 1);
