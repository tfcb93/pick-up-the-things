extends CharacterBody3D

@export var speed = 14;

@export var fall_acceleration = 75;

@onready var camera_pivot = $CameraPivot;
@onready var camera = $CameraPivot/Camera3D;

var target_velocity = Vector3.ZERO;

func _physics_process(delta):
	_movement(delta);

func _process(delta):
	camera_pivot.position = position;

func _movement(delta: float) -> void:
	var direction = Vector3.ZERO;

	direction.x = Input.get_axis("move_left","move_right");
	direction.z = Input.get_axis("move_forward", "move_back");
	
	# Move the direction vector to the camera's springArm rotation, so it can move relatively
	direction = direction.rotated(Vector3.UP, camera_pivot.rotation.y).normalized();

	target_velocity.x = direction.x * speed;
	target_velocity.z = direction.z * speed;

	velocity = target_velocity;
	move_and_slide();
