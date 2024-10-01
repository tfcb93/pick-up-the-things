extends Node

@onready var collectable_instance = preload("res://Scenes/Collectable.tscn");

func add_to_collectables_list(area_x_0: float, area_x_1: float, area_z_0: float, area_z_1: float, sub_area_obstacle_pos: Vector3, total_area_collectables: int) -> void:
	var remaning_collectables_in_area := total_area_collectables if (total_area_collectables > 0) else 0;
	var new_collectable_pos: Array[Vector3] = [];
	var do_it_again := false;
	while(remaning_collectables_in_area > 0):
		var col_x := randf_range(area_x_0, area_x_1);
		var col_z := randf_range(area_z_0, area_z_1);
		var collectable_pos := Vector3(col_x, 0, col_z);
		if (collectable_pos.distance_squared_to(sub_area_obstacle_pos) < 1.2):
			continue;
		# I'm not a fan of this, but this is the way I thought on verifying the distance over each already generated collectable position.
		for used_pos in new_collectable_pos:
			if(collectable_pos.distance_squared_to(used_pos) < 1.0):
				do_it_again = true;
				break;
		if do_it_again:
			do_it_again = false;
			continue;
		var new_collectable := collectable_instance.instantiate();
		add_child(new_collectable);
		new_collectable.position = collectable_pos;
		new_collectable_pos.push_back(collectable_pos);

		remaning_collectables_in_area -= 1;

func reset() -> void:
	for child in get_children():
		child.queue_free();
