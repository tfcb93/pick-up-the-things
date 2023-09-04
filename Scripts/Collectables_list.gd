extends Node

@export var area := Vector2(10, 10);
@export var total_collectables: int = 10;

@onready var piece = preload("res://Scenes/Collectable.tscn");

func _ready():
	print(area);
	for collectable_number in total_collectables:
		var new_collectable = piece.instantiate();
		new_collectable.position = Vector3(
			randf_range(-area.x/2, area.x/2),
			0,
			randf_range(-area.y/2, area.y/2)
		);
		add_child(new_collectable);


func _process(delta):
	pass
