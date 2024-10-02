extends StaticBody3D;

@onready var floor_mesh := $MeshInstance3D;
@onready var floor_collision := $CollisionShape3D;
@onready var obstacles_list := $obstacles_list;
@onready var collectables_list := $collectables_list;
# borders
@onready var front_collision := $bounderies/front/front_collision;
@onready var back_collision := $bounderies/back/back_collision;
@onready var left_collision := $bounderies/left/left_collision;
@onready var right_collision := $bounderies/right/right_collision;

@export_range(1, 10, 1) var side_area_division := 4; ## Divides area for obstacles. Each subdivision will have 1 obstacle. The value is applicable to the side, e.g. 4 will be 4 columns and 4 rows, total of 16 sub areas
@export_range(5, 20, 5) var area_ratio := 10; ## Area ratio is how much size the area will have for each subarea, e.g.: 10 means 10 * side_area_division = total_ground_area;
@export_range(0.1, 5, 0.1) var sub_area_padding := 1.5;

var collectable_instance := preload("res://Scenes/Collectable.tscn");
var area_size_shift := 0.0; # How much to shift from (0, 1, 0). Value should always be negative;
var total_ground_area := Vector3(0, 0, 0); # Initial area;

func _ready() -> void:
	events.connect("restart_game", _on_restart_game);

	# make area proportional to the number of obstacles using a ratio
	total_ground_area = Vector3(side_area_division * area_ratio, 1, side_area_division * area_ratio);
	if (total_ground_area == Vector3.ZERO):
		print("Something went wrong when calculating the floor area");
		get_tree().quit(1);
	area_size_shift = ((side_area_division * area_ratio) / 2) * -1;
	floor_mesh.mesh.size = total_ground_area;
	floor_collision.shape.size = total_ground_area;
	create_bounderies();
	generate_per_sub_area();

func generate_per_sub_area() -> void:
	var divided_size := total_ground_area.x / side_area_division;
	var remaining_collectables := globals.total_collectables;
	var max_collectable_per_area := globals.total_collectables / side_area_division ** 2;
	for x in side_area_division:
		for z in side_area_division:
			var area_x_0 := ((x * divided_size) + sub_area_padding) + area_size_shift;
			var area_x_1 := (((x + 1) * divided_size) - sub_area_padding) + area_size_shift;
			var area_z_0 := ((z * divided_size) + sub_area_padding) + area_size_shift;
			var area_z_1 := (((z + 1) * divided_size) - sub_area_padding) + area_size_shift;
			
			var sub_area_obstacle_pos:Vector3 = obstacles_list.add_to_obstacle_list(area_x_0, area_x_1, area_z_0, area_z_1);
			var collectables_for_this_sub_area := max_collectable_per_area if (remaining_collectables - max_collectable_per_area > max_collectable_per_area) else remaining_collectables;
			collectables_list.add_to_collectables_list(area_x_0, area_x_1, area_z_0, area_z_1, sub_area_obstacle_pos, collectables_for_this_sub_area);
			remaining_collectables -= collectables_for_this_sub_area;


func create_bounderies() -> void:
	# bounderies position
	front_collision.position = Vector3(total_ground_area.x / 2, 0, 0);
	back_collision.position = Vector3(-total_ground_area.x / 2, 0, 0);
	left_collision.position = Vector3(0, 0, total_ground_area.z / 2);
	right_collision.position = Vector3(0, 0, -total_ground_area.z / 2);
	
	# bounderies size
	front_collision.shape.size = Vector3(0, 10, total_ground_area.z);
	back_collision.shape.size = Vector3(0, 10, total_ground_area.z);
	left_collision.shape.size = Vector3(total_ground_area.x, 10, 0);
	right_collision.shape.size = Vector3(total_ground_area.x, 10, 0);
	

func _on_restart_game() -> void:
	collectables_list.reset();
	obstacles_list.reset();
	generate_per_sub_area();