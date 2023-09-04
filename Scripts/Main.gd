extends Node

var score:int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	Events._collectable_picked.connect(_increase_score);

func _increase_score():
	score += 1;
	print(score);
