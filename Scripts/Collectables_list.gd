extends Node

@export var area_width: int = 10;
@export var area_height: int = 10;
@export var total_collectables: int = 10;

@onready var piece = preload("res://Scenes/Collectable.tscn");

func _ready():
	for collectable_number in total_collectables:
		var new_collectable = piece.instantiate();
		new_collectable.position = Vector3(
			randf_range(0, area_width),
			1,
			randf_range(0, area_height)
		);
		add_child(new_collectable);


func _process(delta):
	pass
