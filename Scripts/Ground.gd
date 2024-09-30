extends StaticBody3D

var collectableListScene := preload("res://Scenes/Collectables_list.tscn");
var obstacle_list_instance := preload("res://Scenes/Obstacles_list.tscn");
var obstacle_instance := preload("res://Scenes/Obstacle.tscn");
var collectable_instance := preload("res://Scenes/Collectable.tscn");

@onready var floorMesh := $MeshInstance3D;
@onready var floorCollision := $CollisionShape3D;
@onready var collectableList: Node;
@onready var obstacles_list := $obstacles;
@onready var collectables_list := $collectables;
# var obstacle_list: Node;

@onready var front_collision: CollisionShape3D = $bounderies/front/front_collision;
@onready var back_collision: CollisionShape3D = $bounderies/back/back_collision;
@onready var left_collision: CollisionShape3D = $bounderies/left/left_collision;
@onready var right_collision: CollisionShape3D = $bounderies/right/right_collision;


@export var floorSize := Vector3(50, 1, 50); # TODO: Change this to be a value per side of division
var area_size_shift := -25; # TODO try to fix this later. Using -25 since center is in 0,0 and using a 50x50 plane
@export var isRandomSize := false;
@export_range(1, 10, 1) var area_division := 4; # per side

func _ready() -> void:
	Events._restart_game.connect(_on_restart_game);
	if isRandomSize:
		floorSize = Vector3(
			randi_range(10, 100),
			1,
			randi_range(10, 100)
		);
	floorMesh.mesh.size = floorSize;
	floorCollision.shape.size = floorSize;
	create_bounderies();
	generate_per_area();
	# create_obstacles();
	# create_collectable_field(Vector2(floorSize.x, floorSize.z));

# func create_obstacles() -> void:
# 	obstacle_list = obstacle_list_instance.instantiate();
# 	obstacle_list.area = floorSize;
# 	add_child(obstacle_list);
	
# func create_collectable_field(areaSize := Vector2(10, 10)) -> void:
# 	collectableList = collectableListScene.instantiate();
# 	collectableList.area = areaSize;
# 	add_child(collectableList);
	
func generate_per_area() -> void:
	var divided_size := floorSize.x / area_division;
	var remaining_collectables := WorldGlobals.totalCollectables;
	var max_collectable_per_area := WorldGlobals.totalCollectables / area_division ^ 2;
	for x in area_division:
		for z in area_division:
			var sub_x := randf_range((x * divided_size) + area_size_shift, ((x + 1) * divided_size) + area_size_shift);
			var sub_z := randf_range((z * divided_size) + area_size_shift, ((z + 1) * divided_size) + area_size_shift);
			var obstacle_pos := Vector3(sub_x, 0, sub_z);
			var new_obstacle := obstacle_instance.instantiate();
			obstacles_list.add_child(new_obstacle);
			new_obstacle.position = obstacle_pos;

			var remaning_collectables_in_area := max_collectable_per_area if remaining_collectables - max_collectable_per_area > max_collectable_per_area else remaining_collectables;
			var new_collectable_pos: Array[Vector3] = [];
			var do_it_again := false;
			while(remaning_collectables_in_area > 0):
				var col_x := randf_range((x * divided_size) + area_size_shift, ((x + 1) * divided_size) + area_size_shift);
				var col_z := randf_range((z * divided_size) + area_size_shift, ((z + 1) * divided_size) + area_size_shift);
				var collectable_pos := Vector3(col_x, 0, col_z);
				if (collectable_pos.distance_squared_to(obstacle_pos) < 1.2):
					continue;
				for used_pos in new_collectable_pos:
					if(collectable_pos.distance_squared_to(used_pos) < 1.0):
						do_it_again = true;
						break;
				if do_it_again:
					do_it_again = false;
					continue;
				var new_collectable := collectable_instance.instantiate();
				collectables_list.add_child(new_collectable);
				new_collectable.position = collectable_pos;
				new_collectable_pos.push_back(collectable_pos);

				remaning_collectables_in_area -= 1;


func create_bounderies() -> void:
	# bounderies position
	front_collision.position = Vector3(floorSize.x / 2, 0, 0);
	back_collision.position = Vector3(-floorSize.x / 2, 0, 0);
	left_collision.position = Vector3(0, 0, floorSize.z / 2);
	right_collision.position = Vector3(0, 0, -floorSize.z / 2);
	
	# bounderies size
	front_collision.shape.size = Vector3(0, 10, floorSize.z);
	back_collision.shape.size = Vector3(0, 10, floorSize.z);
	left_collision.shape.size = Vector3(floorSize.x, 10, 0);
	right_collision.shape.size = Vector3(floorSize.x, 10, 0);
	

func _on_restart_game() -> void:
	collectableList.queue_free();
	# create_collectable_field(Vector2(floorSize.x, floorSize.z));
