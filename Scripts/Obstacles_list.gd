extends Node;

var obstacle_instance := preload("res://Scenes/Obstacle.tscn");

func add_to_obstacle_list(area_x_0: float, area_x_1: float, area_z_0: float, area_z_1: float) -> Vector3:
	var sub_x := randf_range(area_x_0, area_x_1);
	var sub_z := randf_range(area_z_0, area_z_1);
	
	var obstacle_pos := Vector3(sub_x, 0, sub_z);
	var new_obstacle := obstacle_instance.instantiate();
	add_child(new_obstacle);
	new_obstacle.position = obstacle_pos;
	return obstacle_pos;

func reset() -> void:
	for child in get_children():
		child.queue_free();