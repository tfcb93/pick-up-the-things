extends StaticBody3D

var collectableListScene := preload("res://Scenes/Collectables_list.tscn");
var obstacle_list_instance := preload("res://Scenes/Obstacles_list.tscn");

@onready var floorMesh := $MeshInstance3D;
@onready var floorCollision := $CollisionShape3D;
@onready var collectableList: Node;
var obstacle_list: Node;

@onready var front_collision: CollisionShape3D = $bounderies/front/front_collision;
@onready var back_collision: CollisionShape3D = $bounderies/back/back_collision;
@onready var left_collision: CollisionShape3D = $bounderies/left/left_collision;
@onready var right_collision: CollisionShape3D = $bounderies/right/right_collision;


@export var floorSize := Vector3(50, 1, 50);
@export var isRandomSize := false;

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
	create_obstacles();
	create_collectable_field(Vector2(floorSize.x, floorSize.z));

func create_obstacles() -> void:
	obstacle_list = obstacle_list_instance.instantiate();
	obstacle_list.area = floorSize;
	add_child(obstacle_list);
	
func create_collectable_field(areaSize := Vector2(10, 10)) -> void:
	collectableList = collectableListScene.instantiate();
	collectableList.area = areaSize;
	add_child(collectableList);
	
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
	create_collectable_field(Vector2(floorSize.x, floorSize.z));
