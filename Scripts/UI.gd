extends CanvasLayer

@onready var scoreLabel := $"HBoxContainer/Value - Score";

func _ready() -> void:
	Events._collectable_picked.connect(_increase_score);
	
func _increase_score() -> void:
	PlayerGlobals.score += 1;
	scoreLabel.text = str(PlayerGlobals.score);
	
