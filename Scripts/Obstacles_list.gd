extends Node;

var obstacle_instance := preload("res://Scenes/Obstacle.tscn");
@export_range(1.0, 2.0, 0.1) var min_player_distance: float = 1.0;

func add_to_obstacle_list(area_x_0: float, area_x_1: float, area_z_0: float, area_z_1: float) -> Vector3:
	var isGenerating := true;
	var obstacle_pos := Vector3.ZERO;
	while (isGenerating):
		var sub_x := randf_range(area_x_0, area_x_1);
		var sub_z := randf_range(area_z_0, area_z_1);
		
		obstacle_pos = Vector3(sub_x, 0, sub_z);
		if (obstacle_pos.distance_squared_to(PlayerGlobals.initial_position) < min_player_distance):
			continue;
		var new_obstacle := obstacle_instance.instantiate();
		add_child(new_obstacle);
		new_obstacle.position = obstacle_pos;
		isGenerating = false;
	return obstacle_pos;

func reset() -> void:
	for child in get_children():
		child.queue_free();