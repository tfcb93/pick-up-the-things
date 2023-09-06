extends CanvasLayer

@onready var scoreLabel := $"HBoxContainer/Value - Score";
@onready var runTimer := $RunTimer;
@onready var timerLabel := $"HBoxContainer2/Text - Timer";

func _ready() -> void:
	Events._collectable_picked.connect(increase_score);
	Events._timer_start.connect(start_timer);
	Events._add_time.connect(_on_add_time);
	runTimer.timeout.connect(game_stop);
	
func _process(delta: float) -> void:
	if not runTimer.is_stopped():
		set_timer_text();
	
func increase_score() -> void:
	PlayerGlobals.score += 1;
	scoreLabel.text = str(PlayerGlobals.score);
	

func start_timer() -> void:
	runTimer.start(WorldGlobals.gameTime);
	WorldGlobals.timeIsOut = false;

func game_stop() -> void:
	print("time stoped");
	timerLabel.text = "0:000"; # Yeah yeah, I know...
	runTimer.stop();
	WorldGlobals.timeIsOut = true;
	Events.emit_signal("_timer_end");

func set_timer_text():
	timerLabel.text = "%1.3f" % runTimer.time_left;
	timerLabel.text = timerLabel.text.replace(".",":");

func _on_add_time(additionalTime) -> void:
	runTimer.start(runTimer.time_left + additionalTime);
