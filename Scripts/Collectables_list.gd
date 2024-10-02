extends Node

@onready var collectable_instance = preload("res://Scenes/Collectable.tscn");

@export_range(1.0, 2.0, 0.1) var min_obstacle_distance: float = 1.2;
@export_range(1.0, 2.0, 0.1) var min_collectable_distance: float = 1.0;
@export_range(1.0, 2.0, 0.1) var min_player_distance: float = 1.0;
@export_range(30, 70, 1) var timer_collectable_probability := 30; ## Probability of a timer collectable (add 1 second on your timer) to appear in the field. I decided to close between 30 and 70 since I'm not shure about the probability distribution.

var timer_collectables_generated := 0;

func add_to_collectables_list(area_x_0: float, area_x_1: float, area_z_0: float, area_z_1: float, sub_area_obstacle_pos: Vector3, total_area_collectables: int) -> void:
	var remaning_collectables_in_area := total_area_collectables if (total_area_collectables > 0) else 0;
	var new_collectable_pos: Array[Vector3] = [];
	var do_it_again := false;
	while(remaning_collectables_in_area > 0):
		var col_x := randf_range(area_x_0, area_x_1);
		var col_z := randf_range(area_z_0, area_z_1);
		var collectable_pos := Vector3(col_x, 0, col_z);
		if (collectable_pos.distance_squared_to(player_globals.initial_position) < min_player_distance):
			continue;
		if (collectable_pos.distance_squared_to(sub_area_obstacle_pos) < min_obstacle_distance):
			continue;
		# I'm not a fan of this, but this is the way I thought on verifying the distance over each already generated collectable position.
		for used_pos in new_collectable_pos:
			if(collectable_pos.distance_squared_to(used_pos) < min_collectable_distance):
				do_it_again = true;
				break;
		if do_it_again:
			do_it_again = false;
			continue;
		var new_collectable := collectable_instance.instantiate();
		add_child(new_collectable);
		new_collectable.position = collectable_pos;
		# I think this is not uniform distribution, but it's easy to implement
		var time_probability := randi_range(0, 100);
		if (time_probability <= timer_collectable_probability and timer_collectables_generated < globals.game_max_timer_collectables):
			new_collectable.change_add_time(1);
			timer_collectables_generated += 1;
		new_collectable_pos.push_back(collectable_pos);

		remaning_collectables_in_area -= 1;

func reset() -> void:
	timer_collectables_generated = 0;
	for child in get_children():
		child.queue_free();
