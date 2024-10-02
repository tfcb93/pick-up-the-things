extends CanvasLayer

@onready var scoreLabel := $"HBoxContainer/Value - Score";
@onready var runTimer := $RunTimer;
@onready var timerLabel := $"HBoxContainer2/Text - Timer";

func _ready() -> void:
	events.connect("collectable_picked", increase_score);
	events._timer_start.connect(start_timer);
	events._add_time.connect(_on_add_time);
	events.connect("_game_stop", _on_game_stop);
	runTimer.timeout.connect(game_stop);
	
func _process(_delta: float) -> void:
	if not runTimer.is_stopped():
		set_timer_text();
	
# Não deveria ter como aumentar o score aqui, só atualizar
func increase_score() -> void:
	player_globals.score += 1;
	scoreLabel.text = str(player_globals.score);
	

# Eu também acho que não deveria começar o timer por aqui, mas sim por outra fonte. Aqui deveria só mostrar o tempo
# Eu posso olhar o exemplo inicial do godot para ver como ele cuida do tempo, pois ficar enviando sinal toda vez que o tempo muda é ruim
func start_timer() -> void:
	runTimer.start(globals.gameTime);
	globals.timeIsOut = false;
	scoreLabel.text = str(player_globals.score);

func game_stop() -> void:
	timerLabel.text = "0:000"; # Yeah yeah, I know...
	runTimer.stop();
	globals.timeIsOut = true;
	events.emit_signal("_timer_end");

func _on_game_stop() -> void:
	runTimer.stop();

func set_timer_text():
	timerLabel.text = "%1.3f" % runTimer.time_left;
	timerLabel.text = timerLabel.text.replace(".",":");

func _on_add_time(additionalTime) -> void:
	runTimer.start(runTimer.time_left + additionalTime);
