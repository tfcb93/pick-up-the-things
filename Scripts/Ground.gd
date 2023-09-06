extends StaticBody3D

var collectableListScene := preload("res://Scenes/Collectables_list.tscn");

@onready var floorMesh := $MeshInstance3D;
@onready var floorCollision := $CollisionShape3D;
@onready var collectableList: Node;

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
	
	create_collectable_field(Vector2(floorSize.x, floorSize.z));

func create_collectable_field(areaSize := Vector2(10, 10)) -> void:
	collectableList = collectableListScene.instantiate();
	collectableList.area = areaSize;
	add_child(collectableList);

func _on_restart_game() -> void:
	create_collectable_field(Vector2(floorSize.x, floorSize.z));
