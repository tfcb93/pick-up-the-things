extends Node;

@export var area := Vector3(10, 0, 10);

var obstacle_instance := preload("res://Scenes/Obstacle.tscn");
var playerSize: Vector3 = Vector3(1, 0 ,1);
func _ready() -> void:
	for obstacle in WorldGlobals.totalObstacles:
		var new_obstacle := obstacle_instance.instantiate();
		while true:
			new_obstacle.position = Vector3(
				randf_range(-area.x/2, area.x/2),
				0,
				randf_range(-area.z/2, area.z/2)
			);
			
			if (new_obstacle.position.x >= playerSize.x or new_obstacle.position.x <= playerSize.x * -1) and (new_obstacle.position.z >= playerSize.z or new_obstacle.position.z <= playerSize.z * -1):
				break;
		# check if the position is not near from other obstacles in a degree
		# repeat until all obstacles are included
		add_child(new_obstacle);
