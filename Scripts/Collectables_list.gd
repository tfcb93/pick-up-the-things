extends Node

@export var area := Vector2(10, 10);
@export var total_collectables: int = WorldGlobals.totalCollectables:
	set(value):
		total_collectables = value;
		WorldGlobals.totalCollectables = value;
	get:
		return total_collectables

@onready var piece = preload("res://Scenes/Collectable.tscn");

func _ready():
	for collectable_number in total_collectables:
		var new_collectable = piece.instantiate();
		var add_time = randi() % 2;
		new_collectable.position = Vector3(
			randf_range(-area.x/2, area.x/2),
			0,
			randf_range(-area.y/2, area.y/2)
		);
		add_child(new_collectable);
		if add_time != 0:
			new_collectable.change_add_time(add_time);


func _process(delta):
	pass
